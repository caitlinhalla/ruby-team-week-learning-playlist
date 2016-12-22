$(document).ready(function() {
  $(".button-collapse").sideNav();
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })
  $('.tooltipped').tooltip({delay: 50});
  $('select').material_select();
});

function editMode() {
  $('.edit-mode').toggleClass('hidden')
};

function addMode() {
  $('.add-mode').toggleClass('hidden')
};

function tagMode() {
  $('.tag-mode').toggleClass('hidden')
};
