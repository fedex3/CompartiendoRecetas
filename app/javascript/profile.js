
function toggleVisibilityDetailEdit() {
  var editor = document.getElementById("edit_profile_detail");
  if (editor.style.display === "none") {
    editor.style.display = "block";
    document.getElementById("user_detail_editor").focus()
  } else {
    editor.style.display = "none";
  }
  var paragraph = document.getElementById("profile-detail-to-hide");
  if (paragraph.style.display === "none") {
    paragraph.style.display = "block";
  } else {
    paragraph.style.display = "none";
  }
} 
