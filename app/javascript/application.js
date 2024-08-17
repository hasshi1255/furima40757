// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require items

document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const taxElement = document.getElementById('add-tax-price');
  const profitElement = document.getElementById('profit');

  const calculateFeeAndProfit = () => {
    const price = parseInt(priceInput.value, 10) || 0;
    if (price < 300 || price > 9_999_999) {
      taxElement.textContent = '—'; // If price is out of range
      profitElement.textContent = '—'; // If price is out of range
      return;
    }

    const fee = Math.floor(price * 0.1);
    const profit = Math.floor(price - fee);

    taxElement.textContent = fee.toLocaleString();
    profitElement.textContent = profit.toLocaleString();
  };

  priceInput.addEventListener('input', calculateFeeAndProfit);
});