$('#tools_question_3').change(function () {
  var optionSelected = $(this).find("option:selected");
  var valueSelected  = optionSelected.val();
  var textSelected   = optionSelected.text();
  if (valueSelected == "prestation de service") {
    $('.middle').text("30 000");
  }
  if (valueSelected == "Vente de marchandises") {
    $('.middle').text("80 000");
  }
  if (valueSelected == "Mixte") {
    $('.middle').text("80 000");
  }
 });
