$(document).on("turbolinks:load", function() {
  var selectizeCallback = null;

  $(".category-modal").on("hide.bs.modal", function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selecitzeCallback = null;
    }

    $("#new_prod_namelist").trigger("reset");
    $.rails.enableFormElements($("#new_prod_namelist"));
  });

  $("#new_prod_namelist").on("submit", function(e) {
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: function(response) {
        selectizeCallback({value: response.id, text: response.pname});
        selectizeCallback = null;

        $(".category-modal").modal('toggle');
      }
    });
  });

  $(".new_product .selectize").selectize({
    plugins: ['remove_button'],
    delimiter: ',',
    persist: false
  });

  $(".new_product .selectize").change( function(){
    pname_box(this);
  });
  function pname_box(o){
    var str = $(':selected', o).text();
    $('.new_product input.p_pname').val(str)
  }

});
