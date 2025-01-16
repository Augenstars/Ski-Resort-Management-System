from django.db import models

class SkiUser(models.Model):
    UsersID = models.CharField(max_length=20, primary_key=True)  # 用户唯一ID
    UsersName = models.CharField(max_length=15)  # 用户名称
    UsersPhoneNumber = models.CharField(max_length=20)  # 用户手机号
    MembershipType = models.CharField(max_length=20)  # 会员类型
    RegistrationTime = models.DateTimeField(auto_now=True)  # 注册时间，自动更新
    UsersPassport = models.CharField(max_length=255)  # 用户密码

    class Meta:
        db_table = 'ski_users'
        managed = False

class SkiTrail(models.Model):
    SkiName = models.CharField(max_length=255, primary_key=True, verbose_name="滑雪道名称")  # 滑雪道名称
    Difficulty = models.CharField(max_length=20, verbose_name="难度等级")  # 难度等级
    SkiDegree = models.FloatField(verbose_name="坡度")  # 坡度
    SkiLength = models.FloatField(verbose_name="长度")  # 长度
    SkiStatus = models.CharField(max_length=255, verbose_name="滑雪道状态")  # 状态

    class Meta:
        db_table = "ski_trail"
        managed = False  

class SkiTicket(models.Model):
    TicketsID = models.CharField(max_length=20, primary_key=True)
    UsersID = models.ForeignKey(SkiUser, to_field='UsersID', on_delete=models.CASCADE, db_column = 'UsersID')
    TicketsType = models.CharField(max_length=200)
    TicketsPrice = models.DecimalField(max_digits=10, decimal_places=2)
    TicketsStartTime = models.DateTimeField(auto_now=True)
    TicketsEndTime = models.DateTimeField()

    class Meta:
        db_table = "ski_tickets"
        managed = False  

class SkiRental(models.Model):
    RentalID = models.CharField(max_length=20,primary_key=True)
    EquipmentID = models.CharField(max_length=50)
    UsersID = models.ForeignKey(SkiUser, null=True, to_field='UsersID', blank=True, on_delete=models.CASCADE, db_column='UsersID')
    RentalStartTime = models.DateTimeField(null=True, blank=True)
    RentalEndTime = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "ski_rental"
        managed = False 

class SkiPurchase(models.Model):
    PurchaseID = models.CharField(max_length=20, primary_key=True)
    UsersID = models.ForeignKey(SkiUser, on_delete=models.CASCADE, db_column='UsersID')
    TicketsID = models.ForeignKey(SkiTicket, on_delete=models.CASCADE, db_column='TicketsID')
    PurchaseTime = models.DateTimeField(auto_now=True)
    PurchaseCost = models.CharField(max_length=20)
    BankcardID = models.CharField(max_length=20)

    class Meta:
        db_table = "ski_purchase"
        managed = False  

class SkiManager(models.Model):
    ManagerID = models.CharField(max_length=20, primary_key=True, verbose_name="管理者ID")
    Passport = models.CharField(max_length=20, verbose_name="管理者登录密码")

    class Meta:
        db_table = "ski_manager"
        managed = False  

class SkiEquipment(models.Model):
    EquipmentID = models.CharField(max_length=50, primary_key=True, verbose_name="设备ID")
    EquipmentName = models.CharField(max_length=20, verbose_name="设备名称")
    EquipmentStatus = models.CharField(max_length=20, verbose_name="设备状态")
    EquipmentStartime = models.DateTimeField(null=True, blank=True, verbose_name="设备开始时间")
    EquipmentEndtime = models.DateTimeField(null=True, blank=True, verbose_name="设备结束时间")

    class Meta:
        db_table = "ski_equipment"

class OperationLogs(models.Model):
    table_name = models.CharField(max_length=255, null=True, blank=True, verbose_name="表名")
    operation_type = models.CharField(max_length=50, null=True, blank=True, verbose_name="操作类型")
    operation_time = models.DateTimeField(auto_now_add=True, verbose_name="操作时间")
    description = models.TextField(null=True, blank=True, verbose_name="描述")

    class Meta:
        db_table = "operation_logs"
        managed = False  


class UserSkiInfo(models.Model):
    UsersID = models.CharField(max_length=20, primary_key=True, verbose_name="用户ID")
    UsersName = models.CharField(max_length=15, verbose_name="用户名称")
    TicketsID = models.CharField(max_length=20, null=True, blank=True, verbose_name="雪票ID")
    PurchaseID = models.CharField(max_length=20, null=True, blank=True, verbose_name="购买记录ID")
    EquipmentID = models.CharField(max_length=10, null=True, blank=True, verbose_name="设备ID")

    class Meta:
        managed = False  # 表示这是一个数据库视图，Django 不会尝试迁移它
        db_table = 'user_ski_info'  # 与视图名称保持一致
        verbose_name = "用户滑雪信息视图"
        verbose_name_plural = "用户滑雪信息视图"
