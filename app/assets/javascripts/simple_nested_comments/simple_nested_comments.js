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

document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".snc_click_to_show_comment_form").forEach(function (el) {
    el.addEventListener("click", function () {
      var id = el.dataset.sncCommentFormContainerId;
      var box = document.getElementById(id);
      if (!box) {
        return;
      }

      box.style.display = "";
      var input = box.querySelector('input[type="text"]');
      if (input) {
        input.focus();
      }
    });
  });

document.addEventListener("ajax:success", function (event) {
    var target = event.target;
    if (!target.matches(".new_nested_comment")) {
        return;
    }

    var detail = event.detail || [];
    var data = detail[0]; // HTML string
    var container = target.parentElement.querySelector(".snc_new_comments");
    if (container && typeof data === "string") {
        container.insertAdjacentHTML("beforeend", data);
    }

    var input = target.querySelector("#nested_comment_content");
    if (input) {
        input.value = "";
    }
});

document.addEventListener("ajax:error", function (event) {
    var target = event.target;
    if (!target.matches(".new_nested_comment")) {
        return;
    }

    var detail = event.detail || [];
    var xhr = detail[2];
    var data = detail[0];
    var html = (xhr && xhr.responseText) || (typeof data === "string" ? data : "");
    var container = target.parentElement.querySelector(".snc_new_comments");
    if (container && html) {
        container.insertAdjacentHTML("beforeend", html);
    }
  });
});
