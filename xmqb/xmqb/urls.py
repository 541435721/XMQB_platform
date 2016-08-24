"""xmqb URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from webuser.views import index, weblogin,register,show_stl,profile,project,delete_project, create_project,uploadify_script,profile_delte,Change_Passwords,Change_project,pay,display_project
from adminuser.views import admin_project,admin_select_project,handle_project,admin_uploadify_script,complete_project,super_profile,users,delete_user,change_user,Super_Change_Passwords,Super_Change_pay,deal_delete,admin_pay,cancel_complete_project
from django.contrib.auth.views import logout
from django.views.static import serve
import settings
urlpatterns = [
    url(r'^$', index, name='index'),
    url(r'^weblogin/', weblogin, name='weblogin'),
    url(r'^register/', register, name='register'),
    url(r'^admin/', admin.site.urls),
    url(r'^person/', profile, name='profile'),
    url(r'^project/', project, name='project'),
    url(r'^delete_project/', delete_project, name='delete_project'),
    url(r'^create_project/', create_project, name='create_project'),
    url(r'^pay/$', pay, name='pay'),
    url(r'^logout/$', logout, {'next_page': '/'}, name='logout'),
    # Here is a method of using url : url( r'...',method_name,arguments_or_just_one_argument_in_this_method_interface,name=.....)
    # So this kind of usage is similar with method like $post('url_in_this_file',{....:.....,.....:......}) in jquery
    # Seems like in django , if you want to transmit arguments to a method , you do not have to add strings like '...../&...='+''+.....
    # This just cost too much time , so just use a dictionary to match argument
    url(r'^uploadify_script/$', uploadify_script, name='upload_script'),
    url(r'^delete_uploadfile/$', profile_delte, name='profile_delte'),
    url(r'^change_passwords/$',Change_Passwords,name='change_passwords'),
    url(r'^change_project/$',Change_project,name='change_project'),
    url(r'^admin_project/', admin_project, name='admin_project'),
    url(r'^admin_project/', admin_project, name='admin_project'),
    url(r'^admin_select_project/', admin_select_project, name='admin_select_project'),
    url(r'^handle_project/', handle_project, name='handle_project'),
    url(r'^download/(?P<path>.*)$', serve, {'document_root':settings.DOWNLOAD_DIR,'show_indexes':False}),
    url(r'^admin_uploadify_script/', admin_uploadify_script, name='admin_uploadify_script'),
    url(r'^complete_project/', complete_project, name='complete_project'),
    url(r'^cancel_complete_project/', cancel_complete_project, name='cancel_complete_project'),
    url(r'^admin_people/$', super_profile, name='admin_people'),
    url(r'^user_manage/$', users, name='admin_people'),
    url(r'^delete_user/$', delete_user, name='delete_user'),
    url(r'^person_change/$', change_user, name='person_chagne'),
    url(r'^super_pay_manage/$', admin_pay, name='super_pay_manage'),
    url(r'^super_change_password/$', Super_Change_Passwords, name='super_change_password'),
    url(r'^super_change_pay/$', Super_Change_pay, name='super_change_pay'),
    url(r'^deleat_pay/$', deal_delete, name='delete_pay'),
    url(r'^show_stl/$', show_stl, name='show_stl'),
    url(r'^display_project/$', display_project, name='display_project'),
]
