$(document).ready(function() {
  $(".button-collapse").sideNav();
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })
});

function editMode() {
  $('.edit-mode').toggleClass('hidden');
}
