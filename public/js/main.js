$(document).ready(function() {
  $(".button-collapse").sideNav();
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })

  $('select').material_select();
});

function editMode() {
  $('.edit-mode').toggleClass('hidden');
}
