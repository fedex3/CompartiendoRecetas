document.addEventListener('DOMContentLoaded', function() {
  var userIconLink = document.querySelector('.user-icon-link');
  var userIcon = document.querySelector('#user_menu_logged_in .fa-user');
  var userMenu = document.getElementById('user_menu_logged_in_dropdown');

  userIconLink.addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    userMenu.classList.toggle('show');
  });

  userIcon.addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    userMenu.classList.toggle('show');
  });

  // Close the dropdown when clicking outside of it
  document.addEventListener('click', function(e) {
    if (!userMenu.contains(e.target) && e.target !== userIconLink) {
      userMenu.classList.remove('show');
    }
  });

  // Close the dropdown when the mouse leaves it
  userMenu.addEventListener('mouseleave', function() {
    userMenu.classList.remove('show');
  });
});