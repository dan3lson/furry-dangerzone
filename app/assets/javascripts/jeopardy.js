$(document).ready(function(){

	/**
	 * Initiating variables and arrays
	 */

	var $chosen_word_id = $(".hidden").text();
	var $chosen_words_array = ["#chosen_word_one_div","#chosen_word_two_div","#chosen_word_three_div","#chosen_word_four_div"];
	var $counter = 0;
	var $correct_word_proggress_bar_without_pbc_class = "";

	// Start the main activity
	start_level_2();

	/**
	 * Starter Functions: Main ones that initiate each activity
	 */

	// Start level 2 activity
	function start_level_2() {
		// Get the details of all words
		$.ajax({
			type: "GET",
			url: "/jeopardy_game_words?word_id=" + $chosen_word_id,
			dataType: "json",
			success: function (response) {
				var $chosen_word = response.word_names[0]
				var $chosen_word_id = response.word_ids[0]
				var $second_word = response.word_names[1]
				var $second_word_id = response.word_ids[1]
				var $third_word = response.word_names[2]
				var $third_word_id = response.word_ids[2]
				var $fourth_word = response.word_names[3]
				var $fourth_word_id = response.word_ids[3]
				var $jeopardy_lineup_names = response.jeopardy_lineup_names
				var $attributes_array = response.attributes_array;
				var $attribute_values = response.attribute_values

				// Display the text for the remaining three buttons
				update_button_text("#chosen_word_one_btn", $chosen_word);
				update_button_text("#chosen_word_two_btn", $second_word);
				update_button_text("#chosen_word_three_btn", $third_word);
				update_button_text("#chosen_word_four_btn", $fourth_word);

				console.log("****************");
				console.log("Question Types (before click):", $attributes_array);
				console.log("Word Order (before click):", $jeopardy_lineup_names);
				console.log("Current word in the 20-word array (before clicked):", $jeopardy_lineup_names[$counter]);
				console.log("Randomly chosen question type (before clicked):", $attributes_array[$counter]);
				console.log("****************");

				var $current_word = $jeopardy_lineup_names[$counter]

				// Update the activity name and instruction
				display_activity_instruction($attributes_array[$counter], $attribute_values[$counter]);

				answer_the_question("#chosen_word_one_btn", "#chosen_word_one_progress_bars_div .progress-bar-custom:first");
				answer_the_question("#chosen_word_two_btn", "#chosen_word_two_progress_bars_div .progress-bar-custom:first");
				answer_the_question("#chosen_word_three_btn", "#chosen_word_three_progress_bars_div .progress-bar-custom:first");
				answer_the_question("#chosen_word_four_btn", "#chosen_word_four_progress_bars_div .progress-bar-custom:first");

				// Handles what happens when user answers correctly and incorrectly
				function answer_the_question(button_id_name, first_mini_progress_bar_without_pbc_class) {
					$(button_id_name).click(function(){
						// If the user's guess is correct
						if ($(this).text() == $jeopardy_lineup_names[$counter]) {
							$(first_mini_progress_bar_without_pbc_class).children().first().html("&#10084;").css("color", "#fff");
							$(first_mini_progress_bar_without_pbc_class).removeClass("progress-bar-custom").addClass("progress-bar-success");
						// If the user's guess is incorrect
						} else {
							$correct_word_proggress_bar_without_pbc_class = "#" +
									$("button:contains('"+$jeopardy_lineup_names[$counter]+"')")
									.next()
									.attr("id")
									+ " .progress-bar-custom:first"
								;
							$($correct_word_proggress_bar_without_pbc_class).html("&#10006;").css("color", "#ccc").css("background", "#fff");
							$($correct_word_proggress_bar_without_pbc_class).removeClass("progress-bar-custom").addClass("progress-bar-danger");
						}

						// Increase the counter
						$counter++;

						console.log("Current word in the 20-word array (after clicked):", $jeopardy_lineup_names[$counter]);
						console.log("Randomly chosen question type (after clicked):", $attributes_array[0]);
						console.log("Question Types (after clicked):", $attribute_values[0]);
						console.log("Counter (after btn is clicked):", $counter);
						console.log("****************");

						display_activity_instruction($attributes_array[$counter], $attribute_values[$counter]);

						// When the game is over, display "complete" message
						if ($counter == 20) {
							$("#chosen_word_one_btn").prop("disabled",true);
							$("#chosen_word_two_btn").prop("disabled",true);
							$("#chosen_word_three_btn").prop("disabled",true);
							$("#chosen_word_four_btn").prop("disabled",true);

							display_activity_instruction("Ready for the results?", "3...2...1...");

							setTimeout(function(){
								$("#level_2_container").hide();
								$("#review_level_two_container").fadeIn();

								display_level_2_results(
									"#chosen_word_one_progress_bars_div",
									"#level_two_results_first_circle",
									"#level_two_results_first_word",
									$chosen_word,
									$chosen_word_id
								);

								display_level_2_results(
									"#chosen_word_two_progress_bars_div",
									"#level_two_results_second_circle",
									"#level_two_results_second_word",
									$second_word,
									$second_word_id
								);

								display_level_2_results(
									"#chosen_word_three_progress_bars_div",
									"#level_two_results_third_circle",
									"#level_two_results_third_word",
									$third_word,
									$third_word_id
								);

								display_level_2_results(
									"#chosen_word_four_progress_bars_div",
									"#level_two_results_fourth_circle",
									"#level_two_results_fourth_word",
									$fourth_word,
									$fourth_word_id
								);

							}, 3000);
						}
					});
				}; // end of answer the question fn
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	}; // end of start game 2 fn


	/**
	 * Helper Functions: Support ones that help each activity above
	 */

	// Update user_word_game_level_status
	function update_jeopardy_user_word_game_status(word_id) {
		var game_info = {
			"game_name": "Jeopardy",
			"word_id": word_id
	 };

	 $.ajax({
		 type: "PATCH",
		 url: "/jeopardy_user_word_game_level",
		 dataType: "json",
		 data: game_info,
		 success: function(response) {
			 console.log(response);
		 }
	 });
	};

	// Create the Freestyle game for this word
	function create_freestyle_user_word_game(word_id) {
		var game_info = {
			"word_id": $chosen_word_id
		};

		$.ajax({
			type: "POST",
			url: "/user_word_game_level_create_freestyle",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response);
			}
		});
	};

	// Update user_word_game_level_status
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
			// ajax route to update game_levels 9-28 for this word
			update_jeopardy_user_word_game_status(word_id);

			create_freestyle_user_word_game(word_id);

			$(level_two_results_num_circle).html("&#8593;");
			$(level_two_results_num_word).html(
																				"<strong>'" + word_name +
																				"'</strong> " +
																				"is now ready for Freestyle!"
																				);
		}
		else {
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
		$("#specific_instruction").html(specific_instruction);
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
