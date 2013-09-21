$(document).ready(function() {
  $("#setlist_info").hide();
  $("#newtrack").hide();

// edit setlist info
	$(document).on("click","#editset",function() {
    $("#newtrack").slideUp(250);
    $("#setlist_info").delay(250).slideToggle(400);
  });

	$(document).on("click","#save_editset",function() {
    $("#setlist_info").hide();
  });

// add setlist track
	$(document).on("click","#new",function() {
    $("#setlist_info").slideUp(250);
    $("#newtrack").delay(250).slideToggle(250);
  });

	$(document).on("click","#save_addtrack",function() {
    $("#newtrack").hide();
  });

});