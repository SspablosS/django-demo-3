from django import forms
from .models import User, Product, Order, ProductInOrder
from django.core.exceptions import ValidationError
import datetime


class LoginForm(forms.Form):
    login = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Логин'
        })
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={
            'class': 'form-control',
            'placeholder': 'Пароль'
        })
    )


class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['article', 'name', 'unit', 'price', 'provider', 'producer', 
                  'category', 'discount', 'amount_in_stock', 'description', 'photo']
        widgets = {
            'article': forms.TextInput(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'unit': forms.Select(attrs={'class': 'form-control'}),
            'price': forms.NumberInput(attrs={'class': 'form-control', 'min': '0'}),
            'provider': forms.Select(attrs={'class': 'form-control'}),
            'producer': forms.Select(attrs={'class': 'form-control'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
            'discount': forms.NumberInput(attrs={'class': 'form-control', 'min': '0', 'max': '100'}),
            'amount_in_stock': forms.NumberInput(attrs={'class': 'form-control', 'min': '0'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'photo': forms.TextInput(attrs={'class': 'form-control'}),
        }

    def clean_price(self):
        price = self.cleaned_data.get('price')
        if price < 0:
            raise ValidationError('Цена не может быть отрицательной')
        return price

    def clean_discount(self):
        discount = self.cleaned_data.get('discount')
        if discount < 0 or discount > 100:
            raise ValidationError('Скидка должна быть от 0 до 100')
        return discount

    def clean_amount_in_stock(self):
        amount = self.cleaned_data.get('amount_in_stock')
        if amount < 0:
            raise ValidationError('Количество не может быть отрицательным')
        return amount


class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = ['user', 'pick_up_point', 'date_delivery', 'status', 'receipt_code']
        widgets = {
            'user': forms.Select(attrs={'class': 'form-control'}),
            'pick_up_point': forms.Select(attrs={'class': 'form-control'}),
            'date_delivery': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'status': forms.Select(attrs={'class': 'form-control'}),
            'receipt_code': forms.NumberInput(attrs={'class': 'form-control'}),
        }

    def clean_date_delivery(self):
        date_delivery = self.cleaned_data.get('date_delivery')
        if date_delivery and date_delivery < datetime.date.today():
            raise ValidationError('Дата доставки не может быть в прошлом')
        return date_delivery

    def clean_receipt_code(self):
        code = self.cleaned_data.get('receipt_code')
        if code and code < 100:
            raise ValidationError('Код получения должен быть не менее 100')
        return code


class ProductInOrderForm(forms.Form):
    product_id = forms.ModelChoiceField(
        queryset=Product.objects.all(),
        widget=forms.Select(attrs={'class': 'form-control product-select'})
    )
    amount = forms.IntegerField(
        min_value=1,
        widget=forms.NumberInput(attrs={'class': 'form-control', 'min': '1', 'value': '1'})
    )
