from django import forms
from .models import User, Product


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
