window.addEventListener('load', () => {
  const input = document.getElementById("item-price")
  const tax = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")
  
  input.addEventListener("input", () => {
    const inputValue = input.value
    const taxValue = Math.floor(inputValue * 0.1)
    const profitValue = Math.floor(inputValue - taxValue)
    tax.innerHTML = taxValue
    profit.innerHTML = profitValue
  })
});
