document.addEventListener('DOMContentLoaded', function(){
  let elem = document.getElementById('recipe_ingredients')
  elem.addEventListener("input", debounce(searchFunction, 1000));
  

  function searchFunction(){
    let searchQuery = this.value
    let options = {
      method: 'GET',      
      headers: {}
    };
    let url = `/ingredients?by_q=${searchQuery}`
  
  
  
    fetch(url, options)
    .then(response => response.json())
    .then(data => {
      let list = document.getElementById('ingredients_list')
      list.innerHTML = ""
      data.forEach(element => {
        list.innerHTML += `<p>${element}</p>`;
      });
    })
  }
});

function debounce(fn, delay) {
  var timeout;

  return function () {
      var context = this,
          args = arguments;

      clearTimeout(timeout);
      timeout = setTimeout(function () {
          fn.apply(context, args);
      }, delay || 250);
  };
}