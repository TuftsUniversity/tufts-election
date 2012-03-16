$(function() {
console.log("YO");

  $('h3.contract').each(function() {
         var original_text = $(this).html();
         var closed_text = $(this).attr('data-closed-text');
         $(this).next("dl").each(function(){
             var f_content = $(this);
//             $(f_content).prev('h3').addClass('twiddle');
             // find all f_content's that don't have any span descendants with a class of "selected"
             f_content.hide();

             // attach the toggle behavior to the h3 tag
             $('h3', f_content.parent()).click(function(){
                 // toggle the content
                 $(this).toggleClass('twiddle-open');
                 if ($(this).hasClass('twiddle-open')) {
                   $(this).html(closed_text)
                 } else {
                   $(this).html(original_text)
                 }
                 $(f_content).slideToggle();
             });
         });
     });
});
 
