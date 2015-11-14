$(document).ready(function(){

	/**
	 * Initiating variables and arrays
	 */

	var $chosen_word_id = $(".palabra").data("word-id");
	var $chosen_words_array = [
		"#chosen_word_one_div",
		"#chosen_word_two_div",
		"#chosen_word_three_div",
		"#chosen_word_four_div"
	];
	var $counter = 0;
	var $correct_word_proggress_bar_without_pbc_class = "";
	var $time_game_started;

	// Start the main activity
	$(".jeopardy-begin-game").click(function(){
		$(".jeopardy-pregame").hide();
		$("#activity_name").fadeIn();
		load_game_info();
		$time_game_started = new Date();
	});

	/**
	 * Starter Functions: Main ones that initiate each activity
	 */

	function load_game_info() {
		$.ajax({
			type: "GET",
			url: "/jeopardy?word_id=" + $chosen_word_id,
			dataType: "json",
			success: function (response) {
				var $chosen_word = response.word_names[0];
				var $chosen_word_id = response.word_ids[0];
				var $second_word = response.word_names[1];
				var $second_word_id = response.word_ids[1];
				var $third_word = response.word_names[2];
				var $third_word_id = response.word_ids[2];
				var $fourth_word = response.word_names[3];
				var $fourth_word_id = response.word_ids[3];
				var $jeopardy_lineup_names = response.jeopardy_lineup_names;
				var $attributes_array = response.attributes_array;
				var $attribute_values = response.attribute_values;

				start_game_2($chosen_word, $second_word, $third_word, $fourth_word, $chosen_word_id, $second_word_id, $third_word_id, $fourth_word_id, $jeopardy_lineup_names, $attributes_array, $attribute_values)
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	}; // end of start game 2 fn

	function start_game_2(w1, w2, w3, w4, w1_id, w2_id, w3_id, w4_id, lineup_names, attributes_array, attribute_values) {

		// Display the text for the remaining three buttons
		update_button_text("#chosen_word_one_btn", w1);
		update_button_text("#chosen_word_two_btn", w2);
		update_button_text("#chosen_word_three_btn", w3);
		update_button_text("#chosen_word_four_btn", w4);

		var $current_word = lineup_names[$counter];

		// Update the activity name and instruction
		display_activity_instruction(attributes_array[$counter], attribute_values[$counter]);

		answer_the_question("#chosen_word_one_btn", "#chosen_word_one_progress_bars_div .progress-bar-custom:first");
		answer_the_question("#chosen_word_two_btn", "#chosen_word_two_progress_bars_div .progress-bar-custom:first");
		answer_the_question("#chosen_word_three_btn", "#chosen_word_three_progress_bars_div .progress-bar-custom:first");
		answer_the_question("#chosen_word_four_btn", "#chosen_word_four_progress_bars_div .progress-bar-custom:first");

		// Handles what happens when user answers correctly and incorrectly
		function answer_the_question(button_id_name, first_mini_progress_bar_without_pbc_class) {
			$(button_id_name).click(function(){
				// If the user's guess is correct
				if ($(this).text() == lineup_names[$counter]) {
					$(first_mini_progress_bar_without_pbc_class).children().first().html("&#10084;").css("color", "#fff");
					$(first_mini_progress_bar_without_pbc_class).removeClass("progress-bar-custom").addClass("progress-bar-success");
				// If the user's guess is incorrect
				} else {
					$correct_word_proggress_bar_without_pbc_class = "#" +
							$("button:contains('"+lineup_names[$counter]+"')")
							.next()
							.attr("id")
							+ " .progress-bar-custom:first"
						;
					$($correct_word_proggress_bar_without_pbc_class).html("&#10006;").css("color", "#ccc").css("background", "#fff");
					$($correct_word_proggress_bar_without_pbc_class).removeClass("progress-bar-custom").addClass("progress-bar-danger");
				}

				// Increase the counter
				$counter++;

				display_activity_instruction(attributes_array[$counter], attribute_values[$counter]);

				// When the game is over, display "complete" message
				if ($counter == 20) {
					$("#chosen_word_one_btn").prop("disabled",true);
					$("#chosen_word_two_btn").prop("disabled",true);
					$("#chosen_word_three_btn").prop("disabled",true);
					$("#chosen_word_four_btn").prop("disabled",true);

					display_activity_instruction("Ready for the results?", "3...2...1...");

					setTimeout(function(){
						// Hide the exit btn and display the home btn
						$("#game-exit-btn").hide();
						$("#game-home-btn").show();

						$("#level_2_container").hide();
						$("#review_level_two_container").fadeIn();

						display_level_2_results(
							"#chosen_word_one_progress_bars_div",
							"#level_two_results_first_circle",
							"#level_two_results_first_word",
							w1,
							w1_id
						);

						display_level_2_results(
							"#chosen_word_two_progress_bars_div",
							"#level_two_results_second_circle",
							"#level_two_results_second_word",
							w2,
							w2_id
						);

						display_level_2_results(
							"#chosen_word_three_progress_bars_div",
							"#level_two_results_third_circle",
							"#level_two_results_third_word",
							w3,
							w3_id
						);

						display_level_2_results(
							"#chosen_word_four_progress_bars_div",
							"#level_two_results_fourth_circle",
							"#level_two_results_fourth_word",
							w4,
							w4_id
						);

					}, 3000);
				}
			});
		}; // end of answer the question fn
	};

	/**
	 * Helper Functions: Support ones that help each activity above
	 */

	// Update user_word status
	function update_jeopardy_status_as_complete(word_id) {
		var game_info = {
			"game_name": "Jeopardy",
			"word_id": word_id
		};

		$.ajax({
			type: "PATCH",
			url: "/jeopardy_game",
			dataType: "json",
			data: game_info,
			success: function(response) {
			 console.log(response.errors);
			}
		});
	};

	function reset_uw_fund_status_from_1_to_0(word_id) {
		var game_info = {
			"word_id": word_id
		};

		$.ajax({
			type: "DELETE",
			url: "/jeopardy_game",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response.errors);
			}
		});
	};

	// Update the game_stat num_played for this word
	function update_num_played(word_id) {
		var game_info = {
			"word_id": word_id,
			"game_name": "Jeopardy",
			"time_spent_in_min": ((new Date() - $time_game_started) / 1000 ) / 60
		};

		$.ajax({
			type: "PATCH",
			url: "/game_stat",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response.errors);
			}
		});
	};

	// Update the game_stat jeop_result for this word
	function update_jeopardy_result(word_id, result) {
		var game_info = {
			"word_id": word_id,
			"game_name": "Jeopardy",
			"result": result
		};

		$.ajax({
			type: "PATCH",
			url: "/jeopardy_result",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response.errors);
			}
		});
	};


	// Update user_word status
	function update_user_points(num) {
		 $.ajax({
			 type: "PATCH",
			 url: "/user_points",
			 dataType: "json",
			 data: { "points": num }
		 })
		 .done(function(response) {
			 console.log(response.errors)
		 });
	 };

	// Display which words move up or down
	function display_level_2_results(
		chosen_word_num_progress_bars_div,
		level_two_results_num_circle,
		level_two_results_num_word,
		word_name,
		word_id
		) {
		if ($(chosen_word_num_progress_bars_div + " .progress-bar-success").length > 2) {
			// update game_levels 9-28 as complete for this (user_)word
			update_jeopardy_status_as_complete(word_id);

			// update num_played
			update_num_played(word_id);

			// Update jeopardy game result
			update_jeopardy_result(word_id, "won");

			// award goodies
			update_user_points(4);

			$(level_two_results_num_circle).html("&#8593;");
			$(level_two_results_num_word).html(
				"<strong>'" + word_name +
				"'</strong> " +
				"is now ready for Freestyle!"
			);
		}
		else {
			// update num_played
			update_num_played(word_id);

			update_jeopardy_result(word_id, "lost");

			reset_uw_fund_status_from_1_to_0(word_id);

			$(level_two_results_num_circle).html("&#8595;");
			$(level_two_results_num_word).html(
				"<strong>'" + word_name +
				"'</strong> " +
				"returns to the Fundamentals."
			);
		}
	};

	// Computes the goodies
	function get_goodies() {
		$('.progress-bar-success').each(function(){
			$all_the_goodies += parseInt($(this).text());
			$("#goodies_total").html($all_the_goodies);
		});
	};

	// Display the button-text for the chosen words
	function update_button_text(chosen_word_num_btn, name) {
		$(chosen_word_num_btn).text(name);
	};

	// Global fns

	//Change the activity name and specific directions depending on current state
	function display_activity_instruction(activity_name, specific_instruction) {
		$("#activity_name").html(activity_name);
		$("#jeopardy-specific-instruction").html(specific_instruction);
	};

	// Set the value for the progress bar
	function progressBar(value) {
		$('.progress-bar').css('width', value+'%').attr('aria-valuenow', value);
	};

	// Shuffle an array's contents
	function shuffle_array(array) {
		var m = array.length, t, i;
		// While there remain elements to shuffle…
		while (m) {
			// Pick a remaining element…
			i = Math.floor(Math.random() * m--);
			// And swap it with the current element.
			t = array[m];
			array[m] = array[i];
			array[i] = t;
		}
		return array;
	};

	// Shortcut for retrieving an element's ID
	function _(x) {
		return document.getElementById(x);
	};
}); // end of document ready fn
