// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

$( document ).ready(function(){

    // Click on the answer object shows the corresponding form
    $(".snc_click_to_show_comment_form" ).click(function() {
        var form_container = $("#" + $(this).data("snc-comment-form-container-id"));
        form_container.slideDown();
        // Put focus on comment input
        form_container.find("input[type=text]").focus();
    });

    $(".new_nested_comment").on("ajax:success", function (e, data, status, xhr) {
        $(this).parent().children(".snc_new_comments").append(xhr.responseText);
        $(this).find("#nested_comment_content").first().val('');
    }).on("ajax:error", function (e, xhr, status, error) {
        $(this).parent().children(".snc_new_comments").append(xhr.responseText);
    });

});
