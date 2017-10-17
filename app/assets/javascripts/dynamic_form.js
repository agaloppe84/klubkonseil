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
 });
