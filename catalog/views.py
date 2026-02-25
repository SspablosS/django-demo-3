from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.hashers import check_password
from django.db.models import Q
from django.contrib import messages
from django.core.paginator import Paginator
import datetime
from .models import User, Role, Product, Order, ProductInOrder, OrderStatus
from .forms import LoginForm, ProductForm, OrderForm


def get_user_role(request):
    """Получить роль текущего пользователя"""
    if not hasattr(request, 'current_user') or request.current_user is None:
        return None
    return request.current_user.get_role_name() if request.current_user else None


def login_view(request):
    """Окно входа"""
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            login = form.cleaned_data['login']
            password = form.cleaned_data['password']
            
            try:
                user = User.objects.get(login=login)
                # Пароли в БД хранятся в открытом виде согласно заданию
                if user.password == password or check_password(password, user.password):
                    request.current_user = user
                    request.session['user_id'] = user.id
                    messages.success(request, f'Добро пожаловать, {user.get_full_name()}!')
                    return redirect('product_list')
                else:
                    messages.error(request, 'Неверный логин или пароль')
            except User.DoesNotExist:
                messages.error(request, 'Неверный логин или пароль')
    else:
        form = LoginForm()
    
    return render(request, 'catalog/login.html', {'form': form})


def logout_view(request):
    """Выход из системы"""
    if 'user_id' in request.session:
        del request.session['user_id']
    request.current_user = None
    messages.info(request, 'Вы вышли из системы')
    return redirect('login')


def guest_enter(request):
    """Вход в роли гостя"""
    request.current_user = None
    if 'user_id' in request.session:
        del request.session['user_id']
    return redirect('product_list')


def product_list(request):
    """Список товаров с фильтрацией, сортировкой и поиском"""
    role = get_user_role(request)
    
    products = Product.objects.select_related(
        'unit', 'provider', 'producer', 'category'
    ).all()
    
    if role in ['Менеджер', 'Администратор']:
        search_query = request.GET.get('search', '')
        if search_query:
            products = products.filter(
                Q(name__icontains=search_query) |
                Q(article__icontains=search_query) |
                Q(description__icontains=search_query) |
                Q(producer__name__icontains=search_query) |
                Q(provider__name__icontains=search_query) |
                Q(category__name__icontains=search_query)
            )
        
        provider_filter = request.GET.get('provider', '')
        if provider_filter:
            products = products.filter(provider_id=provider_filter)
        
        sort_by = request.GET.get('sort', '')
        if sort_by == 'stock_asc':
            products = products.order_by('amount_in_stock')
        elif sort_by == 'stock_desc':
            products = products.order_by('-amount_in_stock')
    
    paginator = Paginator(products, 10)
    page_number = request.GET.get('page', 1)
    page_obj = paginator.get_page(page_number)
    
    providers = Product.objects.values_list('provider', 'provider__name').distinct()
    
    context = {
        'page_obj': page_obj,
        'role': role,
        'current_user': request.current_user,
        'providers': providers,
        'search_query': request.GET.get('search', ''),
        'selected_provider': request.GET.get('provider', ''),
        'selected_sort': request.GET.get('sort', ''),
    }
    
    return render(request, 'catalog/product_list.html', context)


def product_detail(request, product_id):
    """Детальный просмотр товара"""
    product = get_object_or_404(
        Product.objects.select_related('unit', 'provider', 'producer', 'category'),
        id=product_id
    )
    role = get_user_role(request)
    
    context = {
        'product': product,
        'role': role,
        'current_user': request.current_user,
    }
    
    return render(request, 'catalog/product_detail.html', context)


def product_create(request):
    """Добавление товара (только администратор)"""
    role = get_user_role(request)
    
    if role != 'Администратор':
        messages.error(request, 'Доступ запрещён. Только администратор может добавлять товары.')
        return redirect('product_list')
    
    if request.method == 'POST':
        form = ProductForm(request.POST)
        if form.is_valid():
            product = form.save()
            messages.success(request, f'Товар "{product.name}" успешно добавлен.')
            return redirect('product_list')
        else:
            messages.error(request, 'Ошибка при добавлении товара. Проверьте данные.')
    else:
        form = ProductForm()
    
    context = {
        'form': form,
        'role': role,
        'current_user': request.current_user,
        'title': 'Добавить товар',
    }
    
    return render(request, 'catalog/product_form.html', context)


def product_edit(request, product_id):
    """Редактирование товара (только администратор)"""
    role = get_user_role(request)
    
    if role != 'Администратор':
        messages.error(request, 'Доступ запрещён. Только администратор может редактировать товары.')
        return redirect('product_list')
    
    product = get_object_or_404(Product, id=product_id)
    
    if request.method == 'POST':
        form = ProductForm(request.POST, instance=product)
        if form.is_valid():
            product = form.save()
            messages.success(request, f'Товар "{product.name}" успешно обновлён.')
            return redirect('product_list')
        else:
            messages.error(request, 'Ошибка при обновлении товара. Проверьте данные.')
    else:
        form = ProductForm(instance=product)
    
    context = {
        'form': form,
        'role': role,
        'current_user': request.current_user,
        'product': product,
        'title': 'Редактировать товар',
    }
    
    return render(request, 'catalog/product_form.html', context)


def product_delete(request, product_id):
    """Удаление товара (только администратор)"""
    role = get_user_role(request)
    
    if role != 'Администратор':
        messages.error(request, 'Доступ запрещён. Только администратор может удалять товары.')
        return redirect('product_list')
    
    product = get_object_or_404(Product, id=product_id)
    
    in_orders = ProductInOrder.objects.filter(product=product).exists()
    if in_orders:
        messages.error(
            request, 
            f'Нельзя удалить товар "{product.name}", так как он присутствует в заказах.'
        )
        return redirect('product_list')
    
    if request.method == 'POST':
        product_name = product.name
        product.delete()
        messages.success(request, f'Товар "{product_name}" успешно удалён.')
        return redirect('product_list')
    
    context = {
        'product': product,
        'role': role,
        'current_user': request.current_user,
    }
    
    return render(request, 'catalog/product_confirm_delete.html', context)


def order_list(request):
    """Список заказов (менеджер и администратор)"""
    role = get_user_role(request)

    if role not in ['Менеджер', 'Администратор']:
        messages.error(request, 'Доступ запрещён.')
        return redirect('product_list')

    orders = Order.objects.select_related(
        'pick_up_point', 'user', 'status'
    ).prefetch_related('productinorder_set__product').all()

    # Фильтрация по статусу (для менеджера и администратора)
    status_filter = request.GET.get('status', '')
    if status_filter:
        orders = orders.filter(status_id=status_filter)

    # Поиск по номеру заказа и ФИО клиента
    search_query = request.GET.get('search', '')
    if search_query:
        orders = orders.filter(
            Q(id__icontains=search_query) |
            Q(user__surname__icontains=search_query) |
            Q(user__name__icontains=search_query) |
            Q(user__patronymic__icontains=search_query)
        )

    # Получаем список статусов для фильтра
    statuses = OrderStatus.objects.all()

    context = {
        'orders': orders,
        'role': role,
        'current_user': request.current_user,
        'statuses': statuses,
        'selected_status': status_filter,
        'search_query': search_query,
    }

    return render(request, 'catalog/order_list.html', context)


def order_detail(request, order_id):
    """Детальный просмотр заказа"""
    role = get_user_role(request)

    if role not in ['Менеджер', 'Администратор']:
        messages.error(request, 'Доступ запрещён.')
        return redirect('product_list')

    order = get_object_or_404(
        Order.objects.select_related('pick_up_point', 'user', 'status'),
        id=order_id
    )
    order_items = ProductInOrder.objects.filter(order=order).select_related('product')

    # Расчёт общей суммы
    total_amount = sum(item.product.get_final_price() * item.amount for item in order_items)

    context = {
        'order': order,
        'order_items': order_items,
        'total_amount': total_amount,
        'role': role,
        'current_user': request.current_user,
    }

    return render(request, 'catalog/order_detail.html', context)


def order_create(request):
    """Создание заказа (только администратор)"""
    role = get_user_role(request)

    if role != 'Администратор':
        messages.error(request, 'Доступ запрещён. Только администратор может создавать заказы.')
        return redirect('order_list')

    if request.method == 'POST':
        form = OrderForm(request.POST)
        if form.is_valid():
            order = form.save(commit=False)
            order.date_creation = datetime.date.today()
            
            # Получаем товары из сессии или POST
            product_ids = request.POST.getlist('product_id')
            amounts = request.POST.getlist('amount')
            
            if not product_ids:
                messages.error(request, 'Необходимо выбрать хотя бы один товар')
                return render(request, 'catalog/order_form.html', {'form': form, 'role': role, 'current_user': request.current_user, 'title': 'Создать заказ', 'products': Product.objects.all()})
            
            # Проверка количества товаров на складе
            for pid, amt in zip(product_ids, amounts):
                if pid and amt:
                    product = Product.objects.get(id=int(pid))
                    if int(amt) > product.amount_in_stock:
                        messages.error(request, f'Товар "{product.name}" недоступен в количестве {amt} шт. (на складе: {product.amount_in_stock})')
                        return render(request, 'catalog/order_form.html', {'form': form, 'role': role, 'current_user': request.current_user, 'title': 'Создать заказ', 'products': Product.objects.all()})
            
            order.save()
            
            # Добавляем товары в заказ
            for pid, amt in zip(product_ids, amounts):
                if pid and amt:
                    product = Product.objects.get(id=int(pid))
                    ProductInOrder.objects.create(order=order, product=product, amount=int(amt))
                    # Резервируем товар (уменьшаем количество на складе)
                    product.amount_in_stock -= int(amt)
                    product.save()
            
            messages.success(request, f'Заказ #{order.id} успешно создан.')
            return redirect('order_list')
        else:
            messages.error(request, 'Ошибка при создании заказа. Проверьте данные.')
    else:
        form = OrderForm(initial={'date_delivery': datetime.date.today()})
    
    context = {
        'form': form,
        'role': role,
        'current_user': request.current_user,
        'title': 'Создать заказ',
        'products': Product.objects.all(),
    }
    
    return render(request, 'catalog/order_form.html', context)


def order_edit(request, order_id):
    """Редактирование заказа (только администратор)"""
    role = get_user_role(request)

    if role != 'Администратор':
        messages.error(request, 'Доступ запрещён. Только администратор может редактировать заказы.')
        return redirect('order_list')

    order = get_object_or_404(Order, id=order_id)
    
    if request.method == 'POST':
        form = OrderForm(request.POST, instance=order)
        if form.is_valid():
            order = form.save(commit=False)
            
            # Получаем товары из POST
            product_ids = request.POST.getlist('product_id')
            amounts = request.POST.getlist('amount')
            
            # Удаляем старые товары из заказа (возвращаем на склад)
            old_items = ProductInOrder.objects.filter(order=order)
            for item in old_items:
                item.product.amount_in_stock += item.amount
                item.product.save()
            old_items.delete()
            
            # Добавляем новые товары
            for pid, amt in zip(product_ids, amounts):
                if pid and amt:
                    product = Product.objects.get(id=int(pid))
                    if int(amt) > product.amount_in_stock:
                        messages.error(request, f'Товар "{product.name}" недоступен в количестве {amt} шт.')
                        return redirect('order_edit', order_id=order_id)
                    ProductInOrder.objects.create(order=order, product=product, amount=int(amt))
                    product.amount_in_stock -= int(amt)
                    product.save()
            
            order.save()
            messages.success(request, f'Заказ #{order.id} успешно обновлён.')
            return redirect('order_list')
        else:
            messages.error(request, 'Ошибка при обновлении заказа.')
    else:
        form = OrderForm(instance=order)
    
    order_items = ProductInOrder.objects.filter(order=order)
    
    context = {
        'form': form,
        'role': role,
        'current_user': request.current_user,
        'title': 'Редактировать заказ',
        'order': order,
        'order_items': order_items,
        'products': Product.objects.all(),
    }
    
    return render(request, 'catalog/order_form.html', context)


def order_delete(request, order_id):
    """Удаление заказа (только администратор)"""
    role = get_user_role(request)

    if role != 'Администратор':
        messages.error(request, 'Доступ запрещён.')
        return redirect('order_list')

    order = get_object_or_404(Order, id=order_id)
    
    # Проверка статуса — нельзя удалить доставленный заказ
    if order.status.name == 'Доставлен':
        messages.error(request, 'Нельзя удалить доставленный заказ.')
        return redirect('order_list')
    
    if request.method == 'POST':
        # Возвращаем товары на склад
        order_items = ProductInOrder.objects.filter(order=order)
        for item in order_items:
            item.product.amount_in_stock += item.amount
            item.product.save()
        order_items.delete()
        
        order_id = order.id
        order.delete()
        messages.success(request, f'Заказ #{order_id} успешно удалён.')
        return redirect('order_list')
    
    context = {
        'order': order,
        'role': role,
        'current_user': request.current_user,
    }
    
    return render(request, 'catalog/order_confirm_delete.html', context)


def order_change_status(request, order_id, status_id):
    """Изменение статуса заказа"""
    role = get_user_role(request)

    if role not in ['Менеджер', 'Администратор']:
        messages.error(request, 'Доступ запрещён.')
        return redirect('order_list')

    order = get_object_or_404(Order, id=order_id)
    new_status = get_object_or_404(OrderStatus, id=status_id)
    
    old_status = order.status.name
    
    # Если статус меняется на "Доставлен" — списываем товары
    if new_status.name == 'Доставлен' and old_status != 'Доставлен':
        # Товары уже зарезервированы, просто подтверждаем
        pass
    # Если статус меняется на "Отменен" — возвращаем товары
    elif new_status.name == 'Отменен' and old_status != 'Отменен':
        order_items = ProductInOrder.objects.filter(order=order)
        for item in order_items:
            item.product.amount_in_stock += item.amount
            item.product.save()
    
    order.status = new_status
    order.save()
    
    messages.success(request, f'Статус заказа #{order.id} изменён на "{new_status.name}".')
    return redirect('order_list')


def middleware(get_response):
    """Мидлварь для добавления текущего пользователя в request"""
    def middleware_func(request):
        user_id = request.session.get('user_id')
        if user_id:
            try:
                request.current_user = User.objects.get(id=user_id)
            except User.DoesNotExist:
                request.current_user = None
                if 'user_id' in request.session:
                    del request.session['user_id']
        else:
            request.current_user = None

        response = get_response(request)
        return response
    return middleware_func
