#-*- coding: UTF-8 -*-
from django.shortcuts import render,redirect
from webuser.forms import LoginForm,RegisterForm,ProfileForm,ProjectForm,ChangePasswordForm
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.contrib import auth,messages
from webuser.models import Webuser,Project,Pay,UploadFile
from django.utils import timezone
import time
from django.shortcuts import render
from django.views.decorators.csrf import csrf_protect,csrf_exempt
from django.http import HttpResponse,HttpResponseRedirect,JsonResponse
import json
import os
from django.conf import settings
import uuid
from .forms import AdminChangePassword,ChangePayForm
# Create your views here.

# Create your views here.

@csrf_exempt
def admin_project_complete(request): # 管理员处理完图片后手动点击‘完成项目’的后台功能，让当前项目状态转为已完成
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    OrderId=request.GET['order_id']
    project = Project.objects.get(Order_ID=OrderId)
    project.status=True
    project.save()
    projects = Project.objects.all()
    return render(request, 'adminuser/project_manage.html', {'project': projects})

@csrf_exempt
def admin_project(request):  # 显示所有项目
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    project = Project.objects.all().order_by('create_time')
    return render(request, 'adminuser/project_manage.html', {'project': project})

@csrf_exempt
def admin_select_project(request): #从网页传来两个参数，method代表搜索的字段，value代表用以搜索的关键字
    method = request.GET['method']
    value = request.GET['value']

    if method == 'status':
        project = Project.objects.filter(status=value)
        return render(request, 'adminuser/project_manage.html', {'project': project})
    elif method == 'order_id':
        project = Project.objects.filter(Order_ID=value)
        return render(request, 'adminuser/project_manage.html', {'project': project})
    elif method == 'username':
        user = User.objects.get(username=value)
        project = Project.objects.filter(user=user)
        return render(request, 'adminuser/project_manage.html', {'project': project})

@csrf_exempt
def handle_project(request):    # 管理员处理项目相关的文件，上传与完成按钮均在‘adminuser/project_handle.html’里面
    print request.GET['order_id']
    order_id = request.GET['order_id']

    file = UploadFile.objects.filter(Order_ID_id=order_id)
    project = Project.objects.get(Order_ID=order_id)
    return render(request, 'adminuser/project_handle.html', {'file': file,'project':project,'order_id':order_id})

@csrf_exempt
def admin_uploadify_script(request):  # uploadify的下载功能接口，这是管理员版本，用以判断是否成功传递项目编号和文件
    order_id = request.GET['order_id']
    ret = "0"
    file = request.FILES.get("Filedata", None)
    if file:
        result, path_name = admin_profile_upload(file,request,order_id)
        if result:
            ret = "1"
        else:
            ret = "2"
        jsons = path_name
        return HttpResponse(json.dumps(jsons, ensure_ascii=False))
    else:
        jsons = 'failed'
        return HttpResponse(json.dumps(jsons, ensure_ascii=False))

@csrf_exempt

# 管理员上传的文件还没有录入数据库的步骤
def admin_profile_upload(file,request,order_id):  # 管理员版本的文件上传功能本体，根据所传的项目编号找到相关用户，并将文件上传
                                                    # 到用户文件夹的指定项目目录下
    if file:
        project = Project.objects.get(Order_ID=order_id)
        path = os.path.join(settings.BASE_DIR, 'upload')+'\\'+str(project.user.username)+'\\'+project.Order_ID
        if not os.path.exists(path):
            os.makedirs(path)
        # file_name=str(uuid.uuid1())+".jpg"
        file_name = str()+'-' + file.name
        # fname = os.path.join(settings.MEDIA_ROOT,filename)
        path_file = os.path.join(path, file_name)
        fp = open(path_file, 'wb')
        for content in file.chunks():
            fp.write(content)
        fp.close()
        return (True, path_file)  # change
    return (False, 'failed')  # change

@csrf_exempt
def super_profile(request):               # 管理员个人资料修改和查看，修改成功时返回到管理员个人资料页面
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/person')
    user = request.user
    if request.method == 'GET':
        form = ProfileForm(instance=user, initial={
            'name': user.webuser.name,
            'telephone': user.webuser.telephone,
            'hospital': user.webuser.hospital,
            'position': user.webuser.position,
            'department': user.webuser.department,
            'abstract': user.webuser.abstract
        })
        return render(request, 'adminuser/person_page_info.html', {'form': form})
    else:
        form = ProfileForm(request.POST)
        if form.is_valid():
            webuser = Webuser.objects.get(user=request.user)
            webuser.name = form.cleaned_data.get('name')
            webuser.telephone = form.cleaned_data.get('telephone')
            webuser.hospital = form.cleaned_data.get('hospital')
            webuser.position = form.cleaned_data.get('position')
            webuser.department = form.cleaned_data.get('department')
            webuser.abstract = form.cleaned_data.get('abstract')
            webuser.save()
            messages.add_message(request, messages.SUCCESS, u'您的资料已经编辑成功.')
        return render(request, 'adminuser/person_page_info.html', {'form': form})

@csrf_exempt
def users(request):                 # 显示所有注册的用户
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/person')
    Users = Webuser.objects.all()
    return render(request, 'adminuser/person_manage.html', {'Users': Users})

@csrf_exempt
def change_user(request):        # 根据唯一的用户编号修改编号对应的用户资料，修改成功时返回用户管理页面
    Id = request.GET['user_id']
    if not request.user.is_authenticated():
        print 'not log in'
        return redirect('/weblogin')
    elif not request.user.is_superuser:
        print 'not super user'
        return redirect('/')
    if request.method == 'GET':
        thisUser = Webuser.objects.get(user_id=Id)
        form = ProfileForm(initial={
            'name': thisUser.name,
            'telephone': thisUser.telephone,
            'hospital': thisUser.hospital,
            'position': thisUser.position,
            'department': thisUser.department,
            'abstract': thisUser.abstract
        })
        return render(request,'adminuser/person_change.html',{'form':form,'show_id':Id})
    else:
        form = ProfileForm(request.POST)
        if form.is_valid():
            webuser = Webuser.objects.get(user_id=Id)
            webuser.name = form.cleaned_data.get('name')
            webuser.telephone = form.cleaned_data.get('telephone')
            webuser.hospital = form.cleaned_data.get('hospital')
            webuser.position = form.cleaned_data.get('position')
            webuser.department = form.cleaned_data.get('department')
            webuser.abstract = form.cleaned_data.get('abstract')
            webuser.save()
            webusers = Webuser.objects.all()
            return render(request, 'adminuser/person_manage.html', {'Users': webusers})
        else:
            return render(request, 'adminuser/person_change.html', {'form': form, 'show_id': Id})

@csrf_exempt
def delete_user(request):            # 管理员删除用户编号指定的用户，成功时返回到用户管理页面
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/person')
    del_user = User.objects.get(pk=request.GET['user_id'])
    # files=UploadFile.objects.filter(Order_ID=del_project.Order_ID)
    # for del_file in files:
    #     file_delete(del_file.directory)
    del_user.delete()
    Users = Webuser.objects.all()
    return render(request, 'adminuser/person_manage.html', {'Users': Users})

def pay(request):               # 展示所有交易信息
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    pay = Pay.objects.all()
    return render(request, 'adminuser/pay_manage.html', {'pay': pay})

# 新增管理员修改用户密码功能
@csrf_exempt
def Super_Change_Passwords(request):  #管理员修改用户的密码，修改成功时返回到用户管理页面
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    user_id=request.GET['user_id']
    if request.method == "POST":
        form =AdminChangePassword(request.POST)
        if form.is_valid():
            newpassword = form.cleaned_data['newpassword']
            newpassword1 = form.cleaned_data['newpassword1']
            if not newpassword == newpassword1:
                messages.add_message(request, messages.SUCCESS, u'两次输入不一致!!')
                return render(request, 'adminuser/change_password.html', {'form': form,'userid':user_id})
            else:
                thisUser = User.objects.get(id=user_id)
                thisUser.set_password(newpassword)
                thisUser.save()
                Users = Webuser.objects.all()
                return render(request, 'adminuser/person_manage.html', {'Users': Users})
        else:
            return render(request, 'adminuser/change_password.html', {'form': form,'userid':user_id})
    else:
        form = AdminChangePassword()
        return render(request, 'adminuser/change_password.html', {'form': form,'userid':user_id})

@csrf_exempt
def Super_Change_pay(request):  # 管理员直接对交易信息进行修改
    Id = request.GET['Order_id']
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    if request.method == "GET":
        thisPay = Pay.objects.get(project_id=Id)
        form = ChangePayForm(initial={'pay_status': thisPay.is_pay,
                                      'price': thisPay.price})
        return render(request, 'adminuser/pay_change.html', {'form': form, 'Order_id': Id})
    else:
        form = ChangePayForm(request.POST)
        if form.is_valid():
            pay_status = form.cleaned_data['pay_status']
            price = form.cleaned_data['price']
            thisPay = Pay.objects.get(project_id=Id)
            if thisPay:
                thisPay.price = price
                if pay_status == 'False':
                    thisPay.is_pay = False
                if pay_status == 'True':
                    thisPay.is_pay = True
                thisPay.save()
                pay = Pay.objects.all()
                return render(request, 'adminuser/pay_manage.html', {'pay': pay})
            else:
                messages.add_message(request, messages.SUCCESS, u'此交易不存在!!')
                return render(request, 'adminuser/pay_change.html', {'form': form, 'Order_id': Id})
        else:
            return render(request, 'adminuser/pay_change.html', {'form': form, 'Order_id': Id})


@csrf_exempt
def deal_delete(request):              # 管理员删除一条交易信息
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    del_deal = Pay.objects.get(project_id=request.GET['Order_id'])
    # files=UploadFile.objects.filter(Order_ID=del_project.Order_ID)
    # for del_file in files:
    #     file_delete(del_file.directory)
    del_deal.delete()
    deals = Pay.objects.all()
    return render(request, 'adminuser/pay_manage.html', {'pay': deals})

def cancle_complete(request):        # 管理员将显示已完成的项目重新设置成未完成，以便于对项目的更正
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    OrderId = request.GET['order_id']
    project = Project.objects.get(Order_ID=OrderId)
    project.status = False
    project.save()
    projects = Project.objects.all()
    return render(request, 'adminuser/project_manage.html', {'project': projects})