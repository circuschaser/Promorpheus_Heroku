//= require jquery
//= require jquery.ui.sortable
//= require jquery.ui.datepicker

//= require jquery_ujs
//= require bootstrap
//= require_tree .
//
//= require cocoon

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};


$(document).ready(function() {
  function addMega() {
    $(this).addClass("hovering");
  }

  function removeMega() {
    $(this).removeClass("hovering");
  }

  var megaConfig = {
    interval: 300,
    sensitivity: 4,
    over: addMega,
    timeout: 300,
    out: removeMega
  };

  $("div.megamenu").hoverIntent(megaConfig);
  
  $("#accordion").accordion();
  $('#tabs').tabs();
  $("button, input:submit, a.button").button();
  
});
