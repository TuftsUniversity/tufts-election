// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.browser
//= require jquery_ujs
// Used by blacklight_range_limit
//= require  'blacklight_range_limit'
//
// Required by Blacklight
//= require blacklight/blacklight
//= require_tree .

//= require blacklight/core

$(document).ready(function () {
    $('a.accordian-toggle').click(function () {
        if ($('a.accordian-toggle').hasClass('collapsed')) {
            $('a.accordian-toggle').html('Less information');
        }
        else {
            $('a.accordian-toggle').html('View more information');
        }
    });
});
