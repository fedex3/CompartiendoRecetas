// Add event listener to input field
document.getElementById('recipe_ingredients').addEventListener("input", debounce(searchIngredients, 1000));

// Search for ingredients based on input value
function searchIngredients() {
    let searchQuery = document.getElementById('recipe_ingredients').value;
    fetch(`/ingredients?by_q=${searchQuery}`)
    .then(response => response.json())
    .then(data => displayIngredients(data));
}

// Display the list of ingredients
function displayIngredients(ingredients) {
    let list = document.getElementById('ingredients_list');
    list.innerHTML = "";
    if (ingredients.length > 0) {
        ingredients.forEach(ingredient => {
            list.innerHTML += `<li class="ingredient-element" data-id="${ingredient[1]}" onclick="addIngredientToList(this)">${capitalize(ingredient[0].toLowerCase())}</li>`;
        });
    } else {
        list.innerHTML += '<p>No pudimos encontrar ese ingrediente</p><p onclick="addIngredientToDataBase()">¿Queres agregarlo a nuestra base de datos de ingredientes?</p>';
    }
}

// Add selected ingredient to the list
function addIngredientToList(ingredient) {
    if (!checkIngredientWasntAddedBefore(ingredient)) {
        let addedIngredientsList = document.getElementById('added-ingredients-list');
        let idsList = document.getElementById('recipe_ingredients_ids');
        idsList.value += `${ingredient.dataset.id},`;
        addedIngredientsList.innerHTML += `<li data-idadded="${ingredient.dataset.id}">${ingredient.innerText}<span onclick="removeIngredientFromList(this)">x</span></li>`;
    }
}

// Check if ingredient was already added to the list
function checkIngredientWasntAddedBefore(ingredient) {
    let addedIngredients = document.querySelectorAll('#added-ingredients-list li');
    return Array.from(addedIngredients).some(addedIngredient => addedIngredient.dataset.idadded == ingredient.dataset.id);
}

// Remove ingredient from the list
function removeIngredientFromList(button) {
    button.parentNode.outerHTML = '';
}

// Add ingredient to the database
function addIngredientToDataBase() {
  let ingredient = document.getElementById('recipe_ingredients').value;
  let list = document.getElementById('ingredients_list');
  list.innerHTML = '<div class="spinner"></div>'; // Display loading spinner
  fetch(`/ingredients/new?query=${ingredient}`)
  .then(response => response.json())
  .then(data => {
      list.innerHTML = ""; // Remove loading spinner
      if (data.length > 0) {
          if (data[0] == "false") {
              list.innerHTML += `${ingredient} no es considerado un ingrediente o una comida`;
          } else {
              list.innerHTML += `Ingrediente agregado a nuestra base de datos\nDanos unos segundos mientras la actualizamos`;
              setTimeout(searchIngredients, 1000);
          }
      } else {
          list.innerHTML += '<p>No devolvió data el fetch</p>';
      }
  })
  .catch(error => {
    console.error('Hubo un problema con el fetch:', error);
    list.innerHTML += '<p>Tuvimos un problema con este servicio. Por favor, volvé a intentarlo más tarde</p>';
  });
}

// Debounce function
function debounce(fn, delay) {
    let timeout;
    return function () {
        let context = this, args = arguments;
        clearTimeout(timeout);
        timeout = setTimeout(function () {
            fn.apply(context, args);
        }, delay || 250);
    };
}

function capitalize(string)
{
    return string && string[0].toUpperCase() + string.slice(1);
}