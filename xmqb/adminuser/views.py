#-*- coding: UTF-8 -*-
from django.shortcuts import render,redirect
from webuser.models import Project,UploadFile,Webuser,Pay,UploadFile
from webuser.forms import LoginForm,RegisterForm,ProfileForm,ProjectForm,ChangePasswordForm
from django.contrib.auth.models import User
from django.utils import timezone
from django.contrib.auth import authenticate, login
from django.contrib import auth,messages
import time
from django.http import HttpResponse,HttpResponseRedirect,JsonResponse
from django.views.decorators.csrf import csrf_protect,csrf_exempt
import os,json
from django.conf import settings
from django.http import StreamingHttpResponse

from adminuser.forms import AdminChangePassword,ChangePayForm

def admin_project(request): #管理员用户的工程管理。可以看到所有用户的工程
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    project = Project.objects.all().order_by('create_time')
    return render(request, 'adminuser/project_manage.html', {'project': project})

def admin_select_project(request): #筛选工工程的功能
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    method = request.GET['method'] #筛选方式是 订单号 或者用户名 或者是订单状态
    value = request.GET['value'] #筛选得值

    if method == 'status':
        project = Project.objects.filter(status=value)
        return render(request, 'adminuser/project_manage.html', {'project': project})
    elif method == 'order_id':
        project = Project.objects.filter(Order_ID=value)
        return render(request, 'adminuser/project_manage.html', {'project': project})
    elif method == 'username':
        try:
            user = User.objects.get(username=value)
        except:
            user = None
        try:
            project = Project.objects.filter(user=user)
        except:
            project = None
        return render(request, 'adminuser/project_manage.html', {'project': project})

def handle_project(request): #点击工程列表的查看之后 显示的工程文件  和 工程的备注
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    order_id = request.GET.get('order_id')
    file = UploadFile.objects.filter(Order_ID_id=order_id)
    try:
        project = Project.objects.get(Order_ID=order_id)
    except:
        return HttpResponse("该用户不存在")
    return render(request, 'adminuser/project_handle.html', {'file': file,'project':project})

@csrf_exempt
def admin_uploadify_script(request): #处理管理员上传的函数
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    ret = "0"
    file = request.FILES.get("Filedata", None)
    if file:
        result, path_name = admin_profile_upload(file,request)
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
def admin_profile_upload(file,request):
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    order_id = request.GET['order_id']
    project = Project.objects.get(Order_ID=order_id)
    if file:
        path = os.path.join(settings.BASE_DIR, 'upload')+'\\'+str(project.user.username)+'\\'+str(order_id)
        if not os.path.exists(path):
            os.makedirs(path)
        # file_name=str(uuid.uuid1())+".jpg"
        file_name = file.name
        type = request.GET['stlType']
        if type == '1':
            file_name = '1.stl'   #肝实质
        if type == '2':
            file_name = '2.stl'
        if type == '3':
            file_name = '3.stl'
        if type == '4':
            file_name = '4.stl'
        if type == '5':
            file_name = '5.stl'
        if type == '6':
            file_name = '6.stl'
        # fname = os.path.join(settings.MEDIA_ROOT,filename)
        path_file = os.path.join(path, file_name)
        fp = open(path_file, 'wb')
        for content in file.chunks():
            fp.write(content)
        fp.close()
        return (True, path_file)  # change
    return (False, 'failed')  # change

def complete_project(request): #点击完成项目，将项目状态写入数据库
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    order_id = request.GET['order_id']
    project = Project.objects.get(Order_ID=order_id)
    project.status = True
    project.save()

    pro = Project.objects.all().order_by('create_time')
    return render(request, 'adminuser/project_manage.html', {'project': pro})

def cancel_complete_project(request): #取消项目的完成状态
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/weblogin')
    order_id = request.GET['order_id']
    project = Project.objects.get(Order_ID=order_id)
    project.status = False
    project.save()

    pro = Project.objects.all().order_by('create_time')
    return render(request, 'adminuser/project_manage.html', {'project': pro})

def users(request): #管理员显示所有用户信息
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/person')
    Users = Webuser.objects.all()
    return render(request, 'adminuser/person_manage.html', {'Users': Users})

def super_profile(request): #管理员个人信息页面
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
def change_user(request): #修改个人公户信息
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
        Users = Webuser.objects.all()
        return render(request, 'adminuser/person_manage.html', {'Users': Users})

@csrf_exempt
def delete_user(request):  #删除选中用户
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

def admin_pay(request): #管理支付信息
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    pay = Pay.objects.all()
    return render(request, 'adminuser/pay_manage.html', {'pay': pay})

# 新增管理员修改用户密码功能
@csrf_exempt
def Super_Change_Passwords(request):
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
                messages.add_message(request, messages.SUCCESS, u'用户密码修改成功!!')
                return render(request, 'adminuser/change_password.html', {'form': form,'userid':user_id})
        else:
            return render(request, 'adminuser/change_password.html', {'form': form,'userid':user_id})
    else:
        form = AdminChangePassword()
        return render(request, 'adminuser/change_password.html', {'form': form,'userid':user_id})

@csrf_exempt
def Super_Change_pay(request): #修改订单状态
    Id = request.GET['Order_id']
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if not request.user.is_superuser:
        return redirect('/')
    if request.method == "POST":
        form = ChangePayForm(request.POST)
        if form.is_valid():
            pay_status = form.cleaned_data['pay_status']
            price = form.cleaned_data['price']
            thisPay = Pay.objects.get(project_id=Id)
            if thisPay:
                thisPay.price = price
                if (pay_status == 'True'):
                    thisPay.is_pay = True
                else:
                    thisPay.is_pay = False
                thisPay.save()
                pay = Pay.objects.all()
                return render(request, 'adminuser/pay_manage.html', {'pay': pay})
            else:
                messages.add_message(request, messages.SUCCESS, u'此交易不存在!!')
                return render(request, 'adminuser/pay_change.html', {'form': form, 'Order_id': Id})
        else:
            return render(request, 'adminuser/pay_change.html', {'form': form, 'Order_id': Id})
    else:
        thisPay = Pay.objects.get(project_id=Id)
        form = ChangePayForm(initial={'pay_status':thisPay.is_pay,
                                      'price':thisPay.price})
        return render(request,'adminuser/pay_change.html',{'form':form,'Order_id':Id})

@csrf_exempt
def deal_delete(request): #删除订单
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

# def file_download(request):
#     file_name = request.GET["directory"]
#     the_file_name = file_name
#     def file_iterator(file_name, chunk_size=262144):
#         f = open(file_name,"rb")
#         while True:
#             c = f.read(chunk_size)
#             if c:
#                 yield c
#             else:
#                 break
#     response = StreamingHttpResponse(file_iterator(the_file_name))
#     file_name = file_name.encode("utf-8")
#     response['Content-Type'] = 'application/octet-stream'
#     response['Content-Disposition'] = 'attachment;filename=%s' % file_name
#     return response



