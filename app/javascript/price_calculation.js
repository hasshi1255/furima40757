function calculatePrice() {
  const priceInput = document.getElementById('item-price');

  priceInput.addEventListener("input", () => {
  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

    const price = priceInput.value;
  
      const tax = Math.floor(price * 0.1); // 10%の販売手数料
      const profit = price - tax;
      addTaxDom.innerHTML = tax; // 税を表示
      profitDom.innerHTML = profit; // 利益を表示
    })
}
window.addEventListener("turbo:load", calculatePrice);
window.addEventListener("turbo:render", calculatePrice);