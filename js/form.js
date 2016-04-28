$(function (){
   // Wrap all Form Elements in a box-body div
   $('div.box form').each(function(){
      $(this).children().wrapAll('<div class="box-body"/>')
   });

   // Srap all Section Headers in a Box Header Div
   if( $('section.page form section h1').length > 0 ) {
      $('section.page form section h1').each(function(){
         $(this).replaceWith('<div class="box-header with-border"><h3 class="box-title">' + $(this).text() + '</h3></div>');
      });
   }

   // Add approprate bootstrap classes to form elements
   // $('section.content form .form-group input, section.content form .form-group textarea, section.content form .form-group select').addClass('form-control');
   // $('section.content form div.radio, section.content form div.checkbox').wrap('<div class="form-group"/>');
   // $('button[data-button-type="save"]').addClass('btn btn-info');
   // $('button[data-button-type="submit-page"]').addClass('btn btn-success');
   // $('button[data-button-type="previous-page"]').addClass('btn btn-warning');
   // $('label.field-label').addClass('control-label');
   // $('section.content section.box-footer').before($('<div class="clearfix"/>'));

});