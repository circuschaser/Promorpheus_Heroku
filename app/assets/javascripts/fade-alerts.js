$(document).ready(function(){

  function fadeAlert(){
    $('.alert-temp').removeClass('in');
    $('.alert-greet').removeClass('in');
    $('.alert-udel').removeClass('in');
  }

  function removeAlert(){
    $('.alert-temp').remove();
    $('.alert-greet').remove();
    $('.alert-udel').remove();
  }

  window.setTimeout(fadeAlert,5000);
  window.setTimeout(removeAlert,6000);

});