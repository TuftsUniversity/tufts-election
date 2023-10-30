//= require jquery3
//= require rails-ujs
//
// Required by Blacklight
//= require popper
// Twitter Typeahead for autocomplete
//= require twitter/typeahead
//= require bootstrap
//= require blacklight/blacklight

// temp
//= require blacklight_range_limit
//= require_tree .
//
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


