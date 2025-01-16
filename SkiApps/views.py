from django.shortcuts import render, redirect
from django.contrib import messages
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.core.paginator import Paginator
from django.utils import timezone
from SkiApps.models import SkiUser, SkiEquipment, SkiPurchase, SkiRental, SkiTicket, SkiTrail, SkiManager, OperationLogs, UserSkiInfo
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json


def Ski_trail_list(request):
    trails = SkiTrail.objects.all()
    return render(request, 'view_ski_trails.html', {'ski_trails': trails})

def user_login(request):
    if request.method == 'POST':
        user_id = request.POST.get('UsersID')
        password = request.POST.get('UsersPassport')

        # 查找用户
        try:
            user = SkiUser.objects.get(UsersID=user_id)
        except SkiUser.DoesNotExist:
            messages.error(request, "用户不存在")
            return redirect('user_login')  # 用户不存在就重定向回登录页面

        # 验证密码
        if user.UsersPassport != password:
            messages.error(request, "密码错误!")
            return redirect('user_login')

        # 登录成功，设置用户信息，并跳转到用户主页面
        request.session['user_id'] = user.UsersID  # 存储用户ID
        return redirect('view_user_info')  # 跳转到用户主页面

    return render(request, 'user_login.html')  # 渲染登录页面

def manager_login(request):
    if request.method == 'POST':
        manager_id = request.POST.get('ManagerID')
        password = request.POST.get('Passport')

        # 查找管理员
        try:
            manager = SkiManager.objects.get(ManagerID=manager_id)
        except SkiManager.DoesNotExist:
            messages.error(request, "管理员不存在")
            return redirect('manager_login')  # 如果管理员不存在，重定向回登录页面

        # 验证密码
        if manager.Passport != password:
            messages.error(request, "密码错误")
            return redirect('manager_login')

        # 登录成功，设置管理员信息，并跳转到管理员主页面
        request.session['manager_id'] = manager.ManagerID  # 存储管理员ID
        return redirect('management_equipment')  # 跳转到管理员主页面

    return render(request, 'manager_login.html')  # 渲染管理员登录页面


def view_user_info(request):
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, "未登录，请先登录！")
        return redirect('user_login')  # 重定向到登录页面

    user = get_object_or_404(SkiUser, UsersID=user_id)

    if request.method == "POST":
        action = request.POST.get("action")
        if action == "edit":
            # 获取表单中的ID并验证
            posted_user_id = request.POST.get("user_id")
            if posted_user_id != str(user_id):
                messages.error(request, "不能修改您的用户ID！")
                return redirect('view_user_info')

            new_name = request.POST.get("username")
            new_phone = request.POST.get("phone")
            new_membership = request.POST.get("membership")

            if new_name and new_phone and new_membership:
                user.UsersName = new_name
                user.UsersPhoneNumber = new_phone
                user.MembershipType = new_membership
                user.save()
                messages.success(request, "信息更新成功！")
            else:
                messages.error(request, "所有字段均为必填项！")

    return render(request, "view_users_info.html", {"user": user})

def ski_ticket_purchase(request):
    user_id = request.session.get('user_id')
    if request.method == 'GET':
        return render(request, 'ski_ticket_purchase.html')

    elif request.method == 'POST':
        ticket_type = request.POST.get('ticket_type')
        bankcard_id = request.POST.get('bankcard_id')
        user_id = request.POST.get('user_id')

        if not ticket_type or not bankcard_id or not user_id:
            return JsonResponse({"message": "雪票类型、银行卡号或用户ID不能为空！"}, status=400)

        ticket_prices = {
            '初级道': 100,
            '初中级道': 150,
            '中级道': 200,
            '高级道': 250,
        }
        ticket_price = ticket_prices.get(ticket_type)
        print(ticket_price)

        if not ticket_price:
            return JsonResponse({"message": "无效的雪票种类！"}, status=400)

        try:
            # 根据 UsersID 查找用户实例
            user_instance = get_object_or_404(SkiUser, UsersID=user_id)
            ski_trail = get_object_or_404(SkiTrail, Difficulty=ticket_type)
            # 创建雪票
            ticket_id = f'TKT-{timezone.now().strftime("%Y%m%d%H%M%S")}'
            new_ticket = SkiTicket.objects.create(
                TicketsID=ticket_id,
                UsersID=user_instance,  # 使用通过 user_id 查找到的用户实例
                TicketsType=ski_trail.Difficulty,
                TicketsPrice=ticket_price,
                TicketsStartTime=timezone.now(),
                TicketsEndTime=timezone.now() + timezone.timedelta(days=1)
            )

            # 创建购买记录
            purchase_id = f'PUR-{timezone.now().strftime("%Y%m%d%H%M%S")}'
            SkiPurchase.objects.create(
                PurchaseID=purchase_id,
                UsersID=user_instance,  # 使用通过 user_id 查找到的用户实例
                TicketsID=new_ticket,
                PurchaseCost=ticket_price,
                BankcardID=bankcard_id
            )

            return JsonResponse({"message": "购买成功！", "ticket_id": ticket_id}, status=200)

        except Exception as e:
            return JsonResponse({"success": False, "message": f"租赁失败：{str(e)}"})

    return JsonResponse({"message": "无效的请求方法！"}, status=405)


def ski_equipment_rental(request):
    user_id = request.session.get('user_id')  # 获取当前用户ID
    if not user_id:
        messages.error(request, "未登录，请先登录！")
        return redirect('user_login')  # 用户未登录，跳转到登录页面

    user = get_object_or_404(SkiUser, UsersID=user_id)
    print(user)
    # 获取用户已租赁的设备
    rented_equipment = SkiRental.objects.filter(UsersID=user, RentalEndTime__gt=timezone.now())

    # 获取空闲设备
    available_equipment = SkiEquipment.objects.filter(EquipmentStatus='空闲')

    if request.method == 'POST':
        equipment_id = request.POST.get('equipment_id')
        print(equipment_id) 
        if equipment_id:
            try:
                # 查找空闲设备
                equipment = get_object_or_404(SkiEquipment, EquipmentID=equipment_id)

                if equipment.EquipmentStatus != '空闲':
                    return JsonResponse({"message": "设备当前不可用！"}, status=400)

                # 更新设备状态为“使用中”
                equipment.EquipmentStatus = '使用'
                equipment.EquipmentStartime = timezone.now()
                equipment.EquipmentEndtime = timezone.now() + timezone.timedelta(days=1)
                equipment.save()
                def generate_rental_id(user_id, equipment_name):
                    # 使用 UUID 和时间戳生成唯一 ID
                    return f'{timezone.now().strftime("%Y%m%d%H%M%S")}'

                rental_id = generate_rental_id(user.UsersID, equipment.EquipmentName)

                # 创建租赁记录
                SkiRental.objects.create(
                    RentalID = rental_id,
                    UsersID=user,
                    EquipmentID=equipment.EquipmentName,
                    RentalStartTime=timezone.now(),
                    RentalEndTime=timezone.now() + timezone.timedelta(days=1)  # 可设置租赁时长
                )

                return JsonResponse({"success": True, "message": "设备租赁成功！"})
            
            except Exception as e:
                return JsonResponse({"success": False, "message": f"租赁失败：{str(e)}"})

    return render(request, 'ski_equipment_rental.html', {
        'rented_equipment': rented_equipment,
        'available_equipment': available_equipment
    })

def view_user_purchases(request):
    # 获取购买记录
    user_id = request.session.get('user_id')  # 获取当前用户ID
    purchases = SkiPurchase.objects.filter(UsersID=user_id).order_by('-PurchaseTime')  # 假设按购买时间倒序排列
    
    # 分页
    paginator = Paginator(purchases, 10)  # 每页显示10条记录
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    return render(request, 'user_purchases.html', {'page_obj': page_obj})

#-------------------管理员视图--------------------

@csrf_exempt
def management_equipment(request):
    if request.method == "GET":
        # 获取所有设备信息
        equipment_list = SkiEquipment.objects.all()
        return render(request, 'manage_equipment.html', {'equipment_list': equipment_list})

    elif request.method == "POST":
        # 处理添加设备功能
        try:
            body = json.loads(request.body)
            new_equipment = SkiEquipment(
                EquipmentID = body.get("EquipmentID"),
                EquipmentName=body.get("EquipmentName"),
                EquipmentStatus=body.get("EquipmentStatus"),
                EquipmentStartime=body.get("EquipmentStartime")or None,
                EquipmentEndtime=body.get("EquipmentEndtime")or None,
            )
            new_equipment.save()
            return JsonResponse({"success": True, "message": "新设备已添加！"})
        except Exception as e:
            return JsonResponse({"success": False, "message": f"发生错误: {str(e)}"})

    elif request.method == "PUT":
        # 处理修改设备功能
        try:
            body = json.loads(request.body)
            equipment_id = body.get("EquipmentID")
            equipment = SkiEquipment.objects.get(EquipmentID=equipment_id)

            equipment.EquipmentName = body.get("EquipmentName", equipment.EquipmentName)
            equipment.EquipmentStatus = body.get("EquipmentStatus", equipment.EquipmentStatus)
            equipment.EquipmentStartime = body.get("EquipmentStartime", equipment.EquipmentStartime) or None
            equipment.EquipmentEndtime = body.get("EquipmentEndtime", equipment.EquipmentEndtime)or None

            equipment.save()
            return JsonResponse({"success": True, "message": "设备信息已更新！"})
        except SkiEquipment.DoesNotExist:
            return JsonResponse({"success": False, "message": "设备未找到！"})
        except Exception as e:
            return JsonResponse({"success": False, "message": f"发生错误: {str(e)}"})

    elif request.method == "DELETE":
        # 处理删除设备功能
        try:
            body = json.loads(request.body)
            equipment_id = body.get("EquipmentID")
            equipment = SkiEquipment.objects.get(EquipmentID=equipment_id)
            equipment.delete()
            return JsonResponse({"success": True, "message": "设备已删除！"})
        except SkiEquipment.DoesNotExist:
            return JsonResponse({"success": False, "message": "设备未找到！"})
        except Exception as e:
            return JsonResponse({"success": False, "message": f"发生错误: {str(e)}"})

    return JsonResponse({"success": False, "message": "无效的请求方式！"})

@csrf_exempt
def management_ski_trail(request):
    if request.method == "GET":
        # 获取所有雪道信息
        ski_trail_list = SkiTrail.objects.all()
        return render(request, 'manage_ski_trail.html', {'ski_trails': ski_trail_list})

    elif request.method == "POST":
        # 处理添加雪道功能
        try:
            body = json.loads(request.body)
            print(body)
            new_ski_trail = SkiTrail(
                SkiName=body.get("skiTrailName"),
                Difficulty=body.get("skiTrailDifficulty"),
                SkiDegree=body.get("SkiTrailDegree"),
                SkiLength=body.get("SkiTrailLength"),
                SkiStatus=body.get("SkiTrailStatus")
            )
            new_ski_trail.save()
            return JsonResponse({"success": True, "message": "新雪道已添加！"})
        except Exception as e:
            return JsonResponse({"success": False, "message": f"发生错误: {str(e)}"})

    elif request.method == "PUT":
        # 处理修改雪道功能
        try:
            body = json.loads(request.body)
            print(body)
            ski_trail_name = body.get("skiTrailName")
            print(ski_trail_name)
            ski_trail = SkiTrail.objects.get(SkiName=ski_trail_name)

            ski_trail.SkiName = body.get("skiTrailName", ski_trail.SkiName)
            ski_trail.Difficulty = body.get("skiTrailDifficulty", ski_trail.Difficulty)
            ski_trail.SkiDegree = body.get("SkiTrailDegree", ski_trail.SkiDegree)
            ski_trail.SkiLength = body.get("SkiTrailLength", ski_trail.SkiLength)
            ski_trail.SkiStatus = body.get("SkiTrailStatus", ski_trail.SkiStatus)

            ski_trail.save()
            return JsonResponse({"success": True, "message": "雪道信息已更新！"})
        except SkiTrail.DoesNotExist:
            return JsonResponse({"success": False, "message": "雪道未找到！"})
        except Exception as e:
            return JsonResponse({"success": False, "message": f"发生错误:   "})

    elif request.method == "DELETE":
        # 处理删除雪道功能
        try:
            body = json.loads(request.body)
            print(body)
            ski_trail_name = body.get('SkiTrailName')
            ski_trail = SkiTrail.objects.get(SkiName=ski_trail_name)
            ski_trail.delete()
            return JsonResponse({"success": True, "message": "雪道已删除！"})
        except SkiTrail.DoesNotExist:
            return JsonResponse({"success": False, "message": "雪道未找到！"})
        except Exception as e:
            return JsonResponse({"success": False, "message": f"发生错误: {str(e)}"})

    return JsonResponse({"success": False, "message": "无效的请求方式！"})

@csrf_exempt
def management_user(request):
    if request.method == "GET":
        # 获取所有用户信息
        user_list = SkiUser.objects.all()
        return render(request, 'manage_user.html', {'user_list': user_list})

    elif request.method == "POST":
        # 处理添加用户功能
        try:
            body = json.loads(request.body)
            print(body)
            new_user = SkiUser(
                UsersID=body.get("UserID"),
                UsersName=body.get("UserName"),
                UsersPhoneNumber=body.get("UserPhone"),
                MembershipType=body.get("MembershipType"),
                UsersPassport=body.get("UserPassword")
            )
            new_user.save()
            return JsonResponse({"success": True, "message": "用户添加成功"})
        except Exception as e:
            return JsonResponse({"success": False, "message": str(e)})

    elif request.method == "PUT":
        # 处理编辑用户功能
        try:
            body = json.loads(request.body)
            print(body)
            user = SkiUser.objects.get(UsersID=body.get("UserID"))
            user.UsersName = body.get("UserName")
            user.UsersPhoneNumber = body.get("UserPhone")
            user.MembershipType = body.get("MembershipType")
            user.UsersPassport = body.get("UserPassword")
            user.save()
            return JsonResponse({"success": True, "message": "用户信息更新成功"})
        except SkiUser.DoesNotExist:
            return JsonResponse({"success": False, "message": "用户不存在"})
        except Exception as e:
            return JsonResponse({"success": False, "message": {str(e)}})

    elif request.method == 'DELETE':
        # 处理删除用户功能
        try:
            body = json.loads(request.body)
            print(body)
            Users_ID=body.get("UserID")
            print(Users_ID)
            user = SkiUser.objects.get(UsersID=Users_ID)
            user.delete()
            return JsonResponse({"success": True, "message": "用户删除成功"})
        except SkiUser.DoesNotExist:
            return JsonResponse({"success": False, "message": "用户不存在"})
        except Exception as e:
            return JsonResponse({"success": False, "message": {str(e)}})




def operation_logs_view(request):
    logs = OperationLogs.objects.all().order_by('-operation_time')  # 假设我们按操作时间降序排列
    paginator = Paginator(logs, 10)  # 每页显示10条日志

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    return render(request, 'operation_logs.html', {'page_obj': page_obj})

def user_ski_info_view(request):
    # 获取视图中的所有数据
    user_ski_info_list = UserSkiInfo.objects.all()
    return render(request, 'manage_user_ski_info_view.html', {'user_ski_info_list': user_ski_info_list})

def statistics_view(request):
    # 获取数据库中的各类数据数量
    user_count = SkiUser.objects.count()  # 用户数量
    equipment_count = SkiEquipment.objects.count()  # 设备数量
    purchase_count = SkiPurchase.objects.count()  # 订单数量
    ski_trail_count = SkiTrail.objects.count()  # 雪道数量

    # 将统计信息传递到模板中
    context = {
        'user_count': user_count,
        'equipment_count': equipment_count,
        'purchase_count': purchase_count,
        'ski_trail_count': ski_trail_count,
    }

    return render(request, 'statistics.html', context)

