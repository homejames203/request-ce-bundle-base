$(function(){
	setInterval(
	  function(){
	    $.get("../" + bundle.kappSlug() + "?partial=taskActivity&submission_id=" + K('submission').id, function( data ) {
			$('#submissionActivity').html(data).fadeIn();
		});
	  }, 5000);
});


