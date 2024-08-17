document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const feeDisplay = document.getElementById('add-tax-price');
  const profitDisplay = document.getElementById('profit');

  if (priceInput && feeDisplay && profitDisplay) {
    priceInput.addEventListener('input', () => {
      const price = parseFloat(priceInput.value);
      if (!isNaN(price) && price >= 300) {
        const fee = Math.floor(price * 0.1);
        const profit = Math.floor(price - fee);

        feeDisplay.textContent = `¥${fee}`;
        profitDisplay.textContent = `¥${profit}`;
      } else {
        feeDisplay.textContent = '¥0';
        profitDisplay.textContent = '¥0';
      }
    });
  }
});