$(document).ready(function() {
$('.datepicker').pickadate({
  selectMonths: true,
  selectYears: 15
})
});

function editMode() {
  $('.edit-mode').toggleClass('hidden');
}
