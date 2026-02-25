document.addEventListener('DOMContentLoaded', function() {
    const orderForm = document.getElementById('orderForm');
    if (orderForm) {
        initOrderForm();
    }
});

function initOrderForm() {
    document.addEventListener('change', function(e) {
        if (e.target.name === 'product_id' || e.target.name === 'amount') {
            calculateTotal();
        }
    });
}
function addProduct() {
    const container = document.getElementById('products-container');
    if (!container) return;
    
    const newRow = document.createElement('div');
    newRow.className = 'product-item row mb-2';
    newRow.innerHTML = getProductRowHTML();
    container.appendChild(newRow);
}

/**
 * Удалить строку с товаром
 * @param {HTMLElement} btn - кнопка удаления
 */
function removeProduct(btn) {
    const row = btn.closest('.product-item');
    if (row) {
        row.remove();
        calculateTotal();
    }
}

function calculateTotal() {
    let total = 0;
    const productItems = document.querySelectorAll('.product-item');
    
    productItems.forEach(function(item) {
        const select = item.querySelector('select[name="product_id"]');
        const amountInput = item.querySelector('input[name="amount"]');
        
        if (select && amountInput) {
            const selectedOption = select.options[select.selectedIndex];
            const price = parseFloat(selectedOption.dataset.price || 0);
            const amount = parseInt(amountInput.value) || 0;
            const stock = parseInt(selectedOption.dataset.stock || 0);
            
            // Проверка количества
            if (amount > stock) {
                amountInput.classList.add('is-invalid');
            } else {
                amountInput.classList.remove('is-invalid');
            }
            
            total += price * amount;
        }
    });
    
    const totalElement = document.getElementById('total-amount');
    if (totalElement) {
        totalElement.textContent = total.toLocaleString('ru-RU');
    }
}

/**
 * Получить HTML строки товара
 * @returns {string}
 */
function getProductRowHTML() {
    return `
        <div class="col-md-8">
            <select name="product_id" class="form-control">
                <option value="">Выберите товар</option>
                <!-- Опции добавляются из шаблона -->
            </select>
        </div>
        <div class="col-md-3">
            <input type="number" name="amount" class="form-control" placeholder="Кол-во" min="1" value="1">
        </div>
        <div class="col-md-1">
            <button type="button" class="btn btn-danger btn-sm" onclick="removeProduct(this)">×</button>
        </div>
    `;
}

/**
 * Проверка формы перед отправкой
 * @returns {boolean}
 */
function validateOrderForm() {
    const productSelects = document.querySelectorAll('select[name="product_id"]');
    const amountInputs = document.querySelectorAll('input[name="amount"]');
    let hasProducts = false;
    let isValid = true;
    
    productSelects.forEach(function(select, index) {
        if (select.value) {
            hasProducts = true;
            const amount = parseInt(amountInputs[index]?.value) || 0;
            const stock = parseInt(select.options[select.selectedIndex]?.dataset.stock || 0);
            
            if (amount > stock) {
                isValid = false;
                amountInputs[index]?.classList.add('is-invalid');
            }
        }
    });
    
    if (!hasProducts) {
        alert('Необходимо выбрать хотя бы один товар');
        return false;
    }
    
    if (!isValid) {
        alert('Количество товара превышает доступное на складе');
        return false;
    }
    
    return true;
}
