
$(document).on("turbolinks:load", function() {
  $(".selectize ").selectize({
  });

  $(".new_product").change(function(){
    pname_box(this);
  });

  function pname_box(o){
    var str = $('.item', o).text();
    $('.new_product input.p_pname').val(str)
  }
});
