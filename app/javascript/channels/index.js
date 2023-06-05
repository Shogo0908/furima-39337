// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");
    const fee = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = fee; // 販売手数料（10%）の計算

    const profitNumber = document.getElementById("profit");
    profitNumber.innerHTML = (inputValue - fee); // 販売利益の計算
  });
});