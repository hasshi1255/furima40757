document.addEventListener('turbo:load', () => {
  // 初期ロード時の処理
  calculatePrice();

  // 価格入力時のイベントリスナーを設定
  const priceInput = document.getElementById('item-price');
  if (priceInput) {
    priceInput.addEventListener('input', calculatePrice);
  }
});

document.addEventListener('turbo:render', () => {
  // ページがレンダリングされた後の処理
  calculatePrice();

  const priceInput = document.getElementById('item-price');
  if (priceInput) {
    priceInput.addEventListener('input', calculatePrice);
  }
});

function calculatePrice() {
  const priceInput = document.getElementById('item-price');
  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  if (priceInput && addTaxDom && profitDom) {
    const price = parseInt(priceInput.value);
    if (!isNaN(price)) {
      const tax = Math.floor(price * 0.1); // 10%の販売手数料
      const profit = price - tax;
      addTaxDom.innerHTML = tax.toLocaleString(); // 税を表示
      profitDom.innerHTML = profit.toLocaleString(); // 利益を表示
    } else {
      addTaxDom.innerHTML = '0';
      profitDom.innerHTML = '0';
    }
  }
}