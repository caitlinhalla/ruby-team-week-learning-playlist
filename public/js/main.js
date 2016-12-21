$(document).ready(function() {
$('.datepicker').pickadate({
  selectMonths: true,
  selectYears: 15
})
$('select').material_select();
});

function editMode() {
  $('.edit-mode').toggleClass('hidden');
}
