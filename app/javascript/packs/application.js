// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('./nested-forms/addFields')
require('./nested-forms/removeFields')
require("select2")
require("trix")
require("@rails/actiontext")
import 'bootstrap'
//import 'application.scss'
import "@fortawesome/fontawesome-free/js/all";

(function ($) {
  "use strict";

  $(function() {
	
    $(document).on({
      mouseover: function(event) {
        $(this).find('.far').addClass('star-over');
        $(this).prevAll().find('.far').addClass('star-over');
      },
      mouseleave: function(event) {
        $(this).find('.far').removeClass('star-over');
        $(this).prevAll().find('.far').removeClass('star-over');
      }
    }, '.rate');
  
  
    $(document).on('click', '.rate', function() {
      if ( !$(this).find('.star').hasClass('rate-active') ) {
        $(this).siblings().find('.star').addClass('far').removeClass('fas rate-active');
        $(this).find('.star').addClass('rate-active fas').removeClass('far star-over');
        $(this).prevAll().find('.star').addClass('fas').removeClass('far star-over');
      } else {
        console.log('has');
      }
    });
    
  });
  
  /* When the user scrolls down, hide the navbar. When the user scrolls up, show the navbar */
  var prevScrollpos = window.pageYOffset;
  window.onscroll = function() {
    var currentScrollPos = window.pageYOffset;
    if (prevScrollpos > currentScrollPos) {
      document.getElementById("navbarCollapse").style.top = "0";
    } else {
      document.getElementById("navbarCollapse").style.top = "-50px";
    }
    prevScrollpos = currentScrollPos;
  }   

  $(document).on('turbolinks:load', function () {

    $("#country").select2({
      allowClear: true,
      theme: "bootstrap"
    });
    $("#province").select2({
      allowClear: true,
      theme: "bootstrap"
    });
    $("#city").select2({
      allowClear: true,
      theme: "bootstrap"
    });

    var country
    $(document.body).on("change", "#country", function () {
      $("#province").empty();
      $("#city").empty();
      country = this.value;
      const provinceSelect = document.getElementById('province');

      var url = '/province';
      var data = {
        country: country
      };

      $.getJSON(url, data, function (data, status) {
        if (status == 200 || status == 'success') {
          $("#province").select2({
            placeholder: "please select an option...",
            data: data,
            theme: "bootstrap",
            allowClear: true
          })
        }
      });
    });
    $(document.body).on("change", "#province", function () {
      $("#city").empty();
      var province = this.value;
      const provinceSelect = document.getElementById('city');

      var url = '/city';
      var data = {
        country: country,
        province: province
      };

      $.getJSON(url, data, function (data, status) {
        if (status == 200 || status == 'success') {
          $("#city").select2({
            placeholder: "please select an option...",
            data: data,
            theme: "bootstrap",
            allowClear: true
          })
        }
      });
    });

  });
  
}(jQuery));



$( document ).on('ready turbolinks:load', function() {
  var google_analytics_id = document.getElementById("google_analytics_id").innerText
  gtag('config', google_analytics_id, {'page_path': window.location.pathname});

  $('.nav-item a[href="#intro"]').on('click', function () {
    document.getElementById("myTabContent").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    gtag('config', google_analytics_id, {'page_path': window.location.pathname + '#intro'});
  });
  $('.nav-item a[href="#products-and-services"]').on('click', function () {
    document.getElementById("myTabContent").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    gtag('config', google_analytics_id, {'page_path': window.location.pathname + '#products-and-services'});
  });
  $('.nav-item a[href="#videos"]').on('click', function () {
    document.getElementById("myTabContent").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    gtag('config', google_analytics_id, {'page_path': window.location.pathname + '#videos'});
  });
  $('.nav-item a[href="#photos"]').on('click', function () {
    document.getElementById("myTabContent").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    gtag('config', google_analytics_id, {'page_path': window.location.pathname + '#photos'});
  });
  $('.nav-item a[href="#about"]').on('click', function () {
    document.getElementById("myTabContent").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    gtag('config', google_analytics_id, {'page_path': window.location.pathname + '#about'});
  });
  $('.nav-item a[href="#contact"]').on('click', function () {
    document.getElementById("myTabContent").scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
    gtag('config', google_analytics_id, {'page_path': window.location.pathname + '#contact'});
  });
  $(".trix-content a").click(function(e) {
    $(this).attr("target","_blank");
  });

  $('[data-toggle="popover"]').popover();
})





// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")

