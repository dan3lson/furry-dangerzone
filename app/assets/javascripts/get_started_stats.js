$(document).ready(function() {
	$(".gs-tracker").click(function() {
		update_get_started_stat(this.id)
	});

	function update_get_started_stat(this_id) {
		var $get_started_update_request = $.ajax({
			type: "PUT",
			url: "/get_started_stats?attribute=" + this_id,
			dataType: "json"
		});

		$get_started_update_request.done(function(response) {
			console.log(response.errors);
		});
	}
});
