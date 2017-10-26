$('#custom-checkbox-q3 input').change(function () {
  var optionSelected = $(this).val();
  if (optionSelected == "Prestation de service") {
    $('#dyn-middle').text("30 000 €");
  }
  if (optionSelected == "Vente de marchandises") {
    $('#dyn-middle').text("80 000 €");
  }
  if (optionSelected == "Mixte") {
    $('#dyn-middle').text("80 000 €");
  }
  $('.dynamic-info-text').text("Nature de votre activité");
});

$('#custom-checkbox-q1 input').change(function () {
  var optionSelected = $(this).val();
  var contentText = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat corporis illo consectetur eius quis delectus ipsam accusamus, ab veniam dolores nesciunt quo dignissimos quod, molestias! Ab ipsa non nobis, perferendis!"
  $('.dynamic-info-text').text("Seul ou plusieurs");
  $('.dynamic-content').text(contentText)
});

$('#custom-checkbox-q2 input').change(function () {
  var optionSelected = $(this).val();
  $('.dynamic-info-text').text("Votre profession");
});

$('#custom-checkbox-q4 input').change(function () {
  var optionSelected = $(this).val();
  $('.dynamic-info-text').text("Votre chiffre d'affaires");
});

$('#custom-checkbox-q5 input').change(function () {
  var optionSelected = $(this).val();
  $('.dynamic-info-text').text("Les risques");
});

$('#custom-checkbox-q6 input').change(function () {
  var optionSelected = $(this).val();
  $('.dynamic-info-text').text("Le RSI");
});

$('#custom-checkbox-q7 input').change(function () {
  var optionSelected = $(this).val();
  $('.dynamic-info-text').text("Sécurité");
});


$(document).ready (function() {
  setTimeout(function() {
    $('.alert').fadeOut('fast');
  }, 4000);
});
