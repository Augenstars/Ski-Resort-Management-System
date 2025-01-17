"""
URL configuration for SkiSystem project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.contrib import staticfiles
from django.contrib import admin
from django.urls import path
from SkiApps import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path('user/ski_trails/', views.Ski_trail_list, name='ski_trail_list'),
    path('user/login/', views.user_login, name='user_login'),  # 用户登录页面
    path('user/view_ski_trails/', views.Ski_trail_list, name='view_ski_trails'),
    path('user/view_user_info/', views.view_user_info, name = 'view_user_info'),
    path('user/ski_ticket_purchase/', views.ski_ticket_purchase, name='ski_ticket_purchase'),
    path('user/equipment/rental/', views.ski_equipment_rental, name='ski_equipment_rental'),
    path('user/equipment/purchase/', views.view_user_purchases, name='view_user_purchases'),
    path('manage/login/', views.manager_login, name='manager_login'),  # 管理员登录页面,
    path('manage/equipment/', views.management_equipment, name='management_equipment'),
    path('manage/ski_trail/', views.management_ski_trail, name='management_ski_trail'),
    path('manage/operation_logs/', views.operation_logs_view, name='operation_logs'),
    path('manage/user/', views.management_user, name='management_users'),
    path('manage/user-ski-info/', views.user_ski_info_view, name='user_ski_info'),
    path('manage/statistics/', views.statistics_view, name='statistics_view'),

]
urlpatterns += staticfiles_urlpatterns()