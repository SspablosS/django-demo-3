from django.db import models
from django.contrib.auth.hashers import make_password, check_password


class Role(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100, unique=True)

    class Meta:
        db_table = 'roles'
        ordering = ['id']

    def __str__(self):
        return self.name


class User(models.Model):
    id = models.AutoField(primary_key=True)
    surname = models.CharField(max_length=100)
    name = models.CharField(max_length=100)
    patronymic = models.CharField(max_length=100)
    login = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=128)  # хешированный пароль
    user_role = models.ForeignKey(Role, on_delete=models.CASCADE, db_column='user_role')

    class Meta:
        db_table = 'users'
        ordering = ['id']

    def __str__(self):
        return f"{self.surname} {self.name} {self.patronymic}"

    def get_full_name(self):
        return f"{self.surname} {self.name} {self.patronymic}"

    def get_role_name(self):
        return self.user_role.name if self.user_role else None

    def set_password(self, raw_password):
        self.password = make_password(raw_password)

    def check_password(self, raw_password):
        return check_password(raw_password, self.password)


class PickUpPoint(models.Model):
    id = models.AutoField(primary_key=True)
    post_code = models.IntegerField()
    city = models.CharField(max_length=100)
    street = models.CharField(max_length=100)
    building = models.IntegerField()

    class Meta:
        db_table = 'pick_up_points'
        ordering = ['id']

    def __str__(self):
        return f"{self.city}, {self.street}, {self.building}"


class ProductUnit(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'product_units'
        ordering = ['id']

    def __str__(self):
        return self.name


class ProductProvider(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100, unique=True)

    class Meta:
        db_table = 'product_providers'
        ordering = ['id']

    def __str__(self):
        return self.name


class ProductProducer(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100, unique=True)

    class Meta:
        db_table = 'product_producers'
        ordering = ['id']

    def __str__(self):
        return self.name


class ProductCategory(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100, unique=True)

    class Meta:
        db_table = 'product_categories'
        ordering = ['id']

    def __str__(self):
        return self.name


class Product(models.Model):
    id = models.AutoField(primary_key=True)
    article = models.CharField(max_length=50, unique=True)
    name = models.CharField(max_length=200)
    unit = models.ForeignKey(ProductUnit, on_delete=models.CASCADE, db_column='unit_id')
    price = models.IntegerField()
    provider = models.ForeignKey(ProductProvider, on_delete=models.CASCADE, db_column='provider_id')
    producer = models.ForeignKey(ProductProducer, on_delete=models.CASCADE, db_column='producer_id')
    category = models.ForeignKey(ProductCategory, on_delete=models.CASCADE, db_column='category_id')
    discount = models.IntegerField(default=0)
    amount_in_stock = models.IntegerField(default=0)
    description = models.TextField()
    photo = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'products'
        ordering = ['id']

    def __str__(self):
        return f"{self.article} - {self.name}"

    def get_final_price(self):
        """Цена со скидкой"""
        if self.discount > 0:
            return int(self.price * (100 - self.discount) / 100)
        return self.price

    def has_large_discount(self):
        """Проверка: скидка больше 15%"""
        return self.discount > 15

    def is_out_of_stock(self):
        """Товара нет на складе"""
        return self.amount_in_stock == 0


class OrderStatus(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100, unique=True)

    class Meta:
        db_table = 'order_statuses'
        ordering = ['id']

    def __str__(self):
        return self.name


class Order(models.Model):
    id = models.AutoField(primary_key=True)
    date_creation = models.DateField()
    date_delivery = models.DateField()
    pick_up_point = models.ForeignKey(PickUpPoint, on_delete=models.CASCADE, db_column='pick_up_point_id')
    user = models.ForeignKey(User, on_delete=models.CASCADE, db_column='user_id')
    receipt_code = models.IntegerField()
    status = models.ForeignKey(OrderStatus, on_delete=models.CASCADE, db_column='status_id')

    class Meta:
        db_table = 'orders'
        ordering = ['-id']

    def __str__(self):
        return f"Заказ #{self.id} от {self.date_creation}"


class ProductInOrder(models.Model):
    id = models.AutoField(primary_key=True)
    order = models.ForeignKey(Order, on_delete=models.CASCADE, db_column='order_id')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, db_column='product_id')
    amount = models.IntegerField()

    class Meta:
        db_table = 'product_in_order'
        ordering = ['id']
        unique_together = ['order', 'product']

    def __str__(self):
        return f"{self.product.name} x {self.amount} в заказе #{self.order.id}"
