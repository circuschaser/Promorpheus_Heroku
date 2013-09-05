$(document).ready(function() {
    // $("#newsong").hide();

    // composer
    $("#composer a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#composer').bind('cocoon:after-insert',
         function() {
           $("#composer_from_list").hide();
           $("#composer a.add_fields").hide();
         });
    $('#composer').bind("cocoon:after-remove",
         function() {
           $("#composer_from_list").show();
           $("#composer a.add_fields").show();
         });

    // album
    $("#album a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#album').bind('cocoon:after-insert',
         function() {
           $("#album_from_list").hide();
           $("#album a.add_fields").hide();
         });
    $('#album').bind("cocoon:after-remove",
         function() {
           $("#album_from_list").show();
           $("#album a.add_fields").show();
         });

    // genre
    $("#genre a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#genre').bind('cocoon:after-insert',
         function() {
           $("#genre_from_list").hide();
           $("#genre a.add_fields").hide();
         });
    $('#genre').bind("cocoon:after-remove",
         function() {
           $("#genre_from_list").show();
           $("#genre a.add_fields").show();
         });

    // add to setlist
    // $("#assign_<%= song.id %>").hide();


    // $(document).on("click","#addtrack",function() {
    //   $("#assign_<%= song.id %>").slideToggle(250);
    // });

    // $(document).on("click","#save_addtrack",function() {
    //   $("#assign_<%= song.id %>").hide();
    // });


});




