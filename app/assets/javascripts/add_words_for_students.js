$(document).ready(function() {
	$(".select-class-container").click(function() {
		$("#awfs-step-1-container").hide();
		$("#awfs-step-2-container").show();

		var $class_name = $(this).find("h4").text();

		var $usernames_request = $.ajax({
		  method: "GET",
		  url: "/school/student_words.json?selection=" + $class_name
		});

		$usernames_request.done(function(data) {
		  data["student_usernames"].forEach(function(username) {
				var $student = add_bubble("stu-bubble", username, "user", "plus-sign",
					username);

				$("#available-students").append($student);
		  })
		});
	});

	$("#available-students").on("click", ".stu-bubble", function(){
		$("#num-students-added").html(num_classes(".glyphicon-remove-circle") + 1);

		$("#selected-students").append($(this));

		$(this).addClass("selected-stu");
		$(this.lastChild).removeClass("glyphicon-plus-sign");
		$(this.lastChild).addClass("glyphicon-remove-circle");

		var $current_num = $("#num-students-added").html();
		display_next_btn("#select-stu-cont-btn", $current_num);
	});

	$("#select-all").click(function() {
		$(this).fadeOut("fast");
		$(".stu-bubble").each(function(index) {
			$("#selected-students").append($(this));

			$(this).addClass("selected-stu");
			$(this.lastChild).removeClass("glyphicon-plus-sign");
			$(this.lastChild).addClass("glyphicon-remove-circle hover");
		});

		var $current_num = num_classes(".glyphicon-remove-circle")
		$("#num-students-added").html($current_num );

		display_next_btn("#select-stu-cont-btn", $current_num);
	});

	$("#step-2-selected-container").on("click", ".selected-stu", function() {
		$current_num = $("#num-students-added").html();
		$("#num-students-added").html($current_num - 1);

		$("#available-students").append($(this));
		$(this.lastChild).removeClass("glyphicon-remove-circle");
		$(this.lastChild).addClass("glyphicon-plus-sign");

		display_next_btn("#select-stu-cont-btn", $current_num - 1);
	});

	$("#select-stu-cont-btn").click(function() {
		$("#awfs-step-2-container").hide();
		$("#awfs-step-3-container").show();
	});

	$(".search-results-container").on("click", ".awfs-select-word-btn", function(){
		$(".search-results-container").hide();

		var $index = 0;
		var $word_id = $(this).data('word-id');
		var $word_name = $(this).data('word-name');

		var $current_num = num_classes(".teacher-selected-word") + 1;
		$("#num-words-selected").html($current_num);

		var $word = add_bubble("teacher-selected-word", $word_name, "book",
			"remove-circle", $word_id
		);

		$("#selected-words").append($word);
		$("#selected-words-ids").append($word_id + ",");

		display_next_btn("#select-words-finish-btn", $current_num);
	});

	$("#teacher-words").on("click", ".teacher-selected-word", function() {
		$current_num = num_classes(".teacher-selected-word") - 1
		$("#num-words-selected").html($current_num);
		var $current_word_ids = $("#selected-words-ids").html();
		var $id = $current_word_ids.split(",")[$(this).index()];
		var $updated_word_ids = $current_word_ids.replace($id + ",", "");
		$("#selected-words-ids").html($updated_word_ids);
		$(this).remove();
		display_next_btn("#select-words-finish-btn", $current_num);
	});

	$("#select-words-finish-btn").click(function() {
		$("#awfs-step-2-container").hide();
		$("#awfs-step-3-container").hide();
		$("#awfs-review-container").show("fade");
		send_to_rails();
	});

	function add_bubble(container_class, display_name, glyph_1, glyph_2, id) {
		return "<span class='tag lead pointer hover " + container_class + "' id='" +
			container_class + "-" + id + "'>" +
			"<span class='glyphicon glyphicon-" + glyph_1 + "'" +
			"aria-hidden='true'" + "data-username='" + display_name + "'></span>" +
			"\xa0" + "\xa0" + display_name + "\xa0" + "\xa0" +	"\xa0" +
			"<span class='dark-gray glyphicon glyphicon-" + glyph_2 + "'" +
			"aria-hidden='true'></span>" +
		"</span>";
	}

	function display_next_btn(button, current_num) {
		if (current_num > 0) {
			$(button).fadeIn();
		} else {
			$(button).fadeOut();
		}
	}

	function num_classes(class_name) {
		return $(class_name).length;
	}

	function send_to_rails() {
		var $selected_students = $("#selected-students .glyphicon-user").map(
			function() { return $(this).data("username"); }
		).get();

		var $selected_words_ids = $("#selected-words-ids").html();

		var myLeksi_info = {
			"usernames": $selected_students,
			"word_ids": $selected_words_ids
		};

		$.ajax({
			type: "PATCH",
			url: "/school/add_words_for_student",
			dataType: "json",
			data: myLeksi_info,
			success: function(response) {
				display_results(
					response.num_words,
					response.num_students,
					response.num_warnings,
					response.num_successes,
					response.num_errors,
					response.warnings,
					response.successes,
					response.errors
				);
			}
		});
	}

	function display_results(num_words, num_stu, num_warnings, num_successes,
		num_errors, warnings, successes, errors
	) {
		$("#awfs-review-container h4").append(
			"<small> Students (" + num_stu + ") " + "Words (" + num_words +
			")</small>"
		);
		$(".total").html(num_words * num_stu);

		$.each(successes, function(index, value) {
			$("#success-result").append(value, "<hr>");
		});
		$("#num-successes").html(num_successes);


		$.each(warnings, function(index, value) {
			$("#warning-result").append(value, "<hr>");
		});
		$("#num-warnings").html(num_warnings);

		$.each(errors, function(index, value) {
			$("#error-result").append(value, "<hr>");
		});
		$("#num-errors").html(num_errors);
	}
});
