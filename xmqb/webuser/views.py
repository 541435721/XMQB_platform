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
import os,random
from django.conf import settings
import uuid
# Create your views here.

def index(request):                                    #默认页面
    user = request.user
    if user.is_superuser:                             #管理员用户跳转至另一页面
        return render(request, 'adminuser/person_page.html')
    return render(request, 'index.html')


def weblogin(request):                           #处理登录功能
    if request.user.is_authenticated():
        if request.user.is_superuser:
            return render(request,'adminuser/person_page.html')
        else:
            return redirect('/')
    if request.method == "POST":            #如果表单FORM提交数据
        form = LoginForm(request.POST)      #通过前台表单提交的数据 初始化一个FORM对象
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

def register(request):  #处理注册功能
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

def profile(request): #处理个人资料功能
    if not request.user.is_authenticated():
        return redirect('/weblogin')
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
        if request.user.is_superuser:
            return render(request, 'adminuser/person_page_info.html', {'form': form})
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
            messages.add_message(request, messages.SUCCESS, u'您的资料已经编辑成功.')
    if request.user.is_superuser:
        return render(request, 'adminuser/person_page_info.html', {'form': form})
    else:
        return render(request, 'webuser/person_page_info.html', {'form': form})



def project(request):  #该用户所有工程列表
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    project = Project.objects.filter(user=request.user)
    return render(request, 'webuser/project_manage.html', {'project': project})


def delete_project(request):  #删除工程
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    del_project = Project.objects.get(Order_ID=request.GET['orderId'])
    # files=UploadFile.objects.filter(Order_ID=del_project.Order_ID)
    # for del_file in files:
    #     file_delete(del_file.directory)
    del_project.delete()
    project = Project.objects.filter(user=request.user)
    if(request.user.is_superuser):
        return redirect('/admin_project')
    return render(request, 'webuser/project_manage.html', {'project': project})


def create_project(request):  #新建工程
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if(request.method=='POST'):
        form = ProjectForm(request.POST)
        if(form.is_valid()):
            project = Project.objects.create(user=request.user, Order_ID=str(request.user.id)+time.strftime('%Y%m%d%H%M%S'))
            dirs=request.POST['dir']
            dirlist=dirs.split('"') #上传文件返回值为 几个文件路径用“进行分割获取单个文件路径

            # After finishing file uploading , file dirs is not spilited ,and unsplited dirstring has '"',and even split this
            # string with '"', there will be empty strings ,so before we write in the database , empty strings shall be excluded
            for value in dirlist:
                if (not value == ''): #吧其中为空的字符筛选掉
                    pos = value.rfind("\\") #对于单个文件路 获取最后同一个/的位置
                    uploadfile = UploadFile.objects.create(user=request.user, Order_ID=project, directory=value[pos+1:])
                    uploadfile.save()

            project.name = form.cleaned_data['name']
            project.classify = form.cleaned_data['classify']
            project.status = False
            project.upload_dir = request.POST['dir']
            project.remark = form.cleaned_data['remark']
            project.save()

            pay = Pay.objects.create(user=request.user, project=project)  #生成工程的同时再生成 对应的订单
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
def Change_project(request): #修改工程内容
    Id = request.GET['order_id']
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    if request.method == 'GET':
        project = Project.objects.get(Order_ID=Id)
        form = ProjectForm(initial={ #初始化FORM 让页面上生成的表单里面有原本工程的内容
            'Oder_id':Id,
            'name':project.name,
            'dir':project.upload_dir,
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
            dirlist = dirs.split('"')  #类似于新建工程
            # After finishing file uploading , file dirs is not spilited ,and unsplited dirstring has '"',and even split this
            # string with '"', there will be empty strings ,so before we write in the database , empty strings shall be excluded
            for value in dirlist:
                if (not value == ''):
                    pos = value.rfind("\\")
                    UploadFile.objects.get_or_create(user=request.user, Order_ID=project, directory=value[pos+1:]) #由于修改工程 用来记录 上传文件的form 里有记录之前上传过的文件路径。。所以这列要用到get_or_create
                    uploadfile=UploadFile.objects.get(directory=value[pos+1:])
                    uploadfile.save()
            pro = Project.objects.filter(user=request.user)
            return render(request, 'webuser/project_manage.html', {'project': pro})
        else:
            project = Project.objects.get(Order_ID=Id)
            return render(request, 'webuser/change_project.html', {'form': form, 'show_id': project.Order_ID})

def display_project(request):  #查看工程
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    project= Project.objects.get(Order_ID=request.GET['order_id'])
    all_project = Project.objects.filter(user = request.user,status=True)
    return render(request, 'webuser/project_display.html', {'all_project': all_project, 'project': project})

@csrf_exempt
def pay(request):  #支付订单列表
    print 1
    if not request.user.is_authenticated():
        return redirect('/weblogin')
    pay = Pay.objects.filter(user=request.user)
    return render(request, 'webuser/pay_manage.html', {'pay': pay})

@csrf_exempt
def uploadify_script(request): #前端 uploadify在后台的处理函数，用于上传文件的处理
    ret = "0" #记录返回状态
    file = request.FILES.get("Filedata", None) #从request中获取文件类
    if file:
        result, path_name = profile_upload(file,request) #处理文件函数
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
def profile_upload(file,request):  #处理文件函数
    if file: #如果文件有效
        path = os.path.join(settings.BASE_DIR, 'upload')+'\\'+str(request.user.username) #生成路径
        if not os.path.exists(path): #如果路径不存在 就生成
            os.makedirs(path)
        # file_name=str(uuid.uuid1())+".jpg"
        file_name = str(uuid.uuid1())+'-' + file.name
        # fname = os.path.join(settings.MEDIA_ROOT,filename)
        path_file = os.path.join(path, file_name) #将路径和文件名结合
        fp = open(path_file, 'wb')   #以二进制方法写文件，生成对象fb
        for content in file.chunks(): #将文件分段读取
            fp.write(content) #写入fb
        fp.close() #关闭流
        return (True, path_file)  # change
    return (False, 'failed')  # change

@csrf_exempt
def profile_delte(request): #删除文件处理
    del_file = request.POST.get("delete_file", '')
    if del_file:
        os.remove(del_file)
        return JsonResponse(del_file,safe=False)
    else:
        return JsonResponse('failed', safe=False)

@csrf_exempt
def file_delete(path):
    if path:
        os.remove(path)

@csrf_exempt
def ShowFileName(request):
    print request.POST['filename']
    return HttpResponse(request.POST['filename'])

@csrf_exempt
def Change_Passwords(request): #修改密码
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
                    messages.add_message(request, messages.SUCCESS, u'密码修改成功.')
                else:
                    messages.add_message(request, messages.SUCCESS, u'两次输入新密码需要一致！！.')
                    if request.user.is_superuser:
                        return render(request, 'adminuser/change_password.html', {'form': form})
                    else:
                        return render(request, 'webuser/change_password.html', {'form': form})
            else:
                if newpassword == newpassword1:
                    messages.add_message(request, messages.SUCCESS, u'原密码错误！！！！')
                    if request.user.is_superuser:
                        return render(request, 'adminuser/change_password.html', {'form': form})
                    else:
                        return render(request, 'webuser/change_password.html', {'form': form})
                else:
                    messages.add_message(request, messages.SUCCESS, u'原密码错误,并且两次输入新密码不一致！！！！')
            if request.user.is_superuser:
                return render(request, 'adminuser/change_password.html', {'form': form})
            else:
                return render(request, 'webuser/change_password.html', {'form': form})
        else:
            if request.user.is_superuser:
                return render(request, 'adminuser/change_password.html', {'form': form})
            else:
                return render(request, 'webuser/change_password.html', {'form': form})
    else:
        form = ChangePasswordForm()
        if request.user.is_superuser:
            return render(request, 'adminuser/change_password.html', {'form': form})
        else:
            return render(request, 'webuser/change_password.html', {'form': form})


def show_stl(request):
    return render(request,'webuser/show_stl.html')

