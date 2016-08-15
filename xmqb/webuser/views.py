#-*- coding: UTF-8 -*-
from django.shortcuts import render,redirect
from forms import LoginForm,RegisterForm,ProfileForm,ProjectForm,ChangePasswordForm
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.contrib import auth,messages
from models import Webuser,Project,Pay,UploadFile
from django.utils import timezone
import time
from django.shortcuts import render
from django.views.decorators.csrf import csrf_protect,csrf_exempt
from django.http import HttpResponse,HttpResponseRedirect,JsonResponse
import json
import os
from django.conf import settings
import uuid
# Create your views here.


def index(request):     # 首页
    user = request.user
    if user.is_superuser:
        return render(request,'adminuser/person_page.html')
    return render(request, 'index.html')


def weblogin(request):          # 登录页面，并且在登录的时候判断是不是管理员，是的话就跳转到管理员的页面
    if request.user.is_authenticated():
        if request.user.is_superuser:
            return render(request,'adminuser/person_page.html')
        else:
            return redirect('/')
    if request.method == "POST":
        form = LoginForm(request.POST)
        print form.is_valid()
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            login(request, user)
            if request.user.is_superuser:
                return render(request, 'adminuser/person_page.html')
            else:
                return redirect('/')
        else:
            return render(request, 'webuser/login.html', {'form': form})
    else:
        return render(request, 'webuser/login.html', {'form': LoginForm()})

def register(request):     # 注册功能，注册成功时返回到首页
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            email = form.cleaned_data['email']

            User.objects.create_user(username=username, password=password, email=email)
            user = authenticate(username=username, password=password)
            webuser = Webuser(user=user)
            webuser.save()
            login(request, user)
            return redirect('/')
        else:
            return render(request, 'webuser/register.html', {'form': form})
    return render(request, 'webuser/register.html', {'form': RegisterForm()})

def profile(request):            # 一般用户个人资料查看和编辑，编辑成功时返回到首页
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if request.user.is_superuser:
        return redirect('/admin_people')
    user = request.user
    if request.method =='GET':
        form = ProfileForm(instance=user, initial={
            'name': user.webuser.name,
            'telephone': user.webuser.telephone,
            'hospital': user.webuser.hospital,
            'position': user.webuser.position,
            'department': user.webuser.department,
            'abstract': user.webuser.abstract
        })
        return render(request, 'webuser/person_page_info.html', {'form': form})
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
            # messages.add_message(request, messages.SUCCESS, u'您的资料已经编辑成功.')
        return redirect('/')


def project(request):      # 一般用户查看自己的工程
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    project = Project.objects.filter(user=request.user)
    return render(request, 'webuser/project_manage.html', {'project': project})


def delete_project(request):    # 一般用户删除自己的工程
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    del_project = Project.objects.get(Order_ID=request.GET['orderId'])
    # files=UploadFile.objects.filter(Order_ID=del_project.Order_ID)
    # for del_file in files:
    #     file_delete(del_file.directory)
    del_project.delete()
    project = Project.objects.filter(user=request.user)
    return render(request, 'webuser/project_manage.html', {'project': project})


def create_project(request):       # 一般用户创建工程，包括上传文件到用户文件夹，并将文件信息对应到当前的项目
                                     # 在创建工程时创建与其相关的交易记录，并标记为未支付
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if(request.method=='POST'):
        form = ProjectForm(request.POST)
        if(form.is_valid()):
            project = Project.objects.create(user=request.user, Order_ID=str(request.user.id)+time.strftime('%Y%m%d%H%M%S'))
            dirs=request.POST['dir']
            print dirs
            dirlist=dirs.split('"')
            # After finishing file uploading , file dirs is not spilited ,and unsplited dirstring has '"',and even split this
            # string with '"', there will be empty strings ,so before we write in the database , empty strings shall be excluded
            for value in dirlist:
                if (not value == ''):
                    value = value.split("\\")[-1]
                    exist = UploadFile.objects.filter(directory=value)
                    if not len(exist):
                        uploadfile = UploadFile.objects.create(user=request.user, Order_ID=project, directory=value)
                        uploadfile.save()
            project.name = form.cleaned_data['name']
            project.classify = form.cleaned_data['classify']
            project.status = False
            project.upload_dir = request.POST['dir']
            project.remark = form.cleaned_data['remark']
            project.save()

            pay = Pay.objects.create(user=request.user, project=project)
            pay.is_pay=False
            pay.price = 200
            pay.save()

            pro = Project.objects.filter(user=request.user)
            return render(request, 'webuser/project_manage.html', {'project': pro})
        else:
            return render(request, 'webuser/project_create.html', {'form': form})
    else:
        form = ProjectForm()
        return render(request, 'webuser/project_create.html', {'form': form})

@csrf_exempt
def Change_project(request):    # 一般用户修改自己的项目，包括添加文件上传，也可以不添加，添加的文件信息关联到当前项目
    Id = request.GET['oder_id']
    print Id
    if not request.user.is_authenticated():
        print 'not log in'
        return redirect('/weblogin')
    if request.method == 'GET':
        project = Project.objects.get(Order_ID=Id)
        form = ProjectForm(initial={
            'Oder_id':Id,
            'name':project.name,
            'dir':'""',
            'classify':project.classify,
            'remark':project.remark,
        })
        return render(request,'webuser/change_project.html',{'form':form,'show_id':project.Order_ID})
    else:
        form = ProjectForm(request.POST)
        if form.is_valid():
            project = Project.objects.get(Order_ID=Id)
            project.name = form.cleaned_data['name']
            project.upload_dir = form.cleaned_data['dir']
            project.classify = form.cleaned_data['classify']
            project.remark = form.cleaned_data['remark']
            project.save()
            dirs = project.upload_dir
            print dirs
            dirlist = dirs.split('"')
            # After finishing file uploading , file dirs is not spilited ,and unsplited dirstring has '"',and even split this
            # string with '"', there will be empty strings ,so before we write in the database , empty strings shall be excluded
            for value in dirlist:
                if (not value == ''):
                    value = value.split("\\")[-1]
                    UploadFile.objects.get_or_create(user=request.user, Order_ID=project, directory=value)
                    uploadfile = UploadFile.objects.get(user=request.user, Order_ID=project, directory=value)
                    uploadfile.save()
            project = Project.objects.filter(user=request.user)
            return render(request, 'webuser/project_manage.html', {'project': project})
        return render(request,'webuser/change_project.html',{'form':form,'show_id':Id})

def pay(request):         # 一般用户查看自己的交易信息
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    pay = Pay.objects.filter(user=request.user)
    return render(request, 'webuser/pay_manage.html', {'pay': pay})

@csrf_exempt
def uploadify_script(request):        # 一般用户的文件上传接口
    ret = "0"
    file = request.FILES.get("Filedata", None)
    if file:
        result, path_name = profile_upload(file,request)
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
def profile_upload(file,request):                   # 一般用户的文件上传功能本体
    if file:
        path = os.path.join(settings.BASE_DIR, 'upload')+'\\'+str(request.user.username)
        if not os.path.exists(path):
            os.makedirs(path)
        # file_name=str(uuid.uuid1())+".jpg"
        file_name = str(uuid.uuid1())+'______' + file.name
        # fname = os.path.join(settings.MEDIA_ROOT,filename)
        path_file = os.path.join(path, file_name)
        fp = open(path_file, 'wb')
        for content in file.chunks():
            fp.write(content)
        fp.close()
        return (True, path_file)  # change
    return (False, 'failed')  # change

@csrf_exempt
def profile_delte(request):         # 对于已经上传的文件，在页面中显示的上传队列每一项的X标记对应的删除功能
                                      # 由于用以删除的功能写在基础页面的js中，所以用户，管理员的两套uploadify设置
                                      # 都是调用这个功能以实现彻底的上传取消的
    del_file = request.POST.get("delete_file", '')
    if del_file:
        os.remove(del_file)
        return JsonResponse(del_file,safe=False)
    else:
        return JsonResponse('failed', safe=False)

@csrf_exempt
def file_delete(path):  # 简单的删除功能
    if path:
        os.remove(path)

@csrf_exempt
def ShowFileName(request):         # 用以测试文件名是否成功传递的功能
    print request.POST['filename']
    return HttpResponse(request.POST['filename'])

@csrf_exempt
def Change_Passwords(request):            # 一般用户修改自己的密码，修改成功时返回到首页
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if request.method == "POST":
        form = ChangePasswordForm(request.POST)
        if form.is_valid():
            username = request.user.username
            oldpassord = form.cleaned_data['oldpassword']
            newpassword = form.cleaned_data['newpassword']
            newpassword1 = form.cleaned_data['newpassword1']
            user = authenticate(username=username,password=oldpassord)
            if user:
                if newpassword == newpassword1:
                    user.set_password(newpassword)
                    user.save()
                    # After changing the password , messages saved in the browser is still the old password ,
                    # so if you want to stay log in status after changing password , log in with new password again!!!!!!!
                    user = authenticate(username=username,password=newpassword)
                    login(request, user)
                    # user = request.user
                    # form = ProfileForm(instance=user, initial={
                    #     'name': user.webuser.name,
                    #     'telephone': user.webuser.telephone,
                    #     'hospital': user.webuser.hospital,
                    #     'position': user.webuser.position,
                    #     'department': user.webuser.department,
                    #     'abstract': user.webuser.abstract
                    # })
                    return redirect('/')
                else:
                    messages.add_message(request, messages.SUCCESS, u'两次输入新密码需要一致！！.')
                    return render(request, 'webuser/change_password.html', {'form': form})
            else:
                if newpassword == newpassword1:
                    messages.add_message(request, messages.SUCCESS, u'原密码错误！！！！')
                    return render(request, 'webuser/change_password.html', {'form': form})
                else:
                    messages.add_message(request, messages.SUCCESS, u'原密码错误,并且两次输入新密码不一致！！！！')
            return render(request, 'webuser/change_password.html', {'form': form})
        else:
            return render(request, 'webuser/change_password.html', {'form': form})
    else:
        form = ChangePasswordForm()
        return render(request, 'webuser/change_password.html', {'form': form})




