$(document).ready(function(){

	/**
	 * Initiating variables and arrays
	 */

	// General
	var $chosen_word_value;
	var $each_letter_span; // letters shown in the header
	var $regex = /^[a-zA-Z. ]+$/; // No numbers or special characters just letters and spaces; /^[a-zA-Z]*$/; is only letters and no spaces or numbers
	var $first_word = $("#chosen_word_one").val();
	var $second_word = $("#chosen_word_two").val();
	var $third_word = $("#chosen_word_three").val();
	var $fourth_word = $("#chosen_word_four").val();
	var $chosen_words_array = ["#chosen_word_one_div","#chosen_word_two_div","#chosen_word_three_div","#chosen_word_four_div"];
	var $words_array_five_each = [];
	var $question_type_array = ["synonym", "antonym", "sentence", "meaning"];
	var $current_word_counter = 0;
	var $correct_word_proggress_bar_without_pbc_class = "";

	// Start the first activity
	start_level_2();

	/**
	 * Handle the back buttons
	 */

	// If the user wants to start over with a different word
	$("#restart_back_button").click(function(){
		location.reload();
	})

	/**
	 * Starter Functions: Main ones that initiate each activity
	 */

	// Start level 2 activity
	function start_level_2() {
		// After four words are typed, update the button to display the text
		update_button_text("#chosen_word_one_btn","#chosen_word_one");
		update_button_text("#chosen_word_two_btn","#chosen_word_two");
		update_button_text("#chosen_word_three_btn","#chosen_word_three");
		update_button_text("#chosen_word_four_btn","#chosen_word_four");

		// Have a simple fade effect for the buttons when they're first displayed
		for (var i = 0; i < 4; i++) {
			$($chosen_words_array[i]).fadeIn();
		}

		// Create an array that holds four instances of the word/button names
		for (var i = 0; i < 5; i++) {
			words_array_five_each_push("#chosen_word_one");
			words_array_five_each_push("#chosen_word_two");
			words_array_five_each_push("#chosen_word_three");
			words_array_five_each_push("#chosen_word_four");
		}

		// Shuffle the array so the order of word-questions is random
		shuffle_array($words_array_five_each);

		// Randomly select what question-type to display, i.e. syn, ant, sent, TBD, TBD
		shuffle_array($question_type_array);

		// Read the XML file
		$.ajax({
			type: "GET",
			url: "dictionary.xml",
			dataType: "xml",
			success: function (xml) {
				console.log("Current word in the 20-word array (before clicked):",$words_array_five_each[$current_word_counter]);
				console.log("Randomly chosen question type (before clicked):",$question_type_array[$current_word_counter]);
				console.log("Question Types (before click):",$question_type_array);
				console.log("****************");

				$(xml).find($words_array_five_each[$current_word_counter]).children().find($question_type_array[0]).each(function(){
					// Update the activity name and instruction
					// This only displays the last item, which is OKAY for now... =D =/
					display_activity_instruction($question_type_array[0], $(this).text());
				});

				answer_the_question("#chosen_word_one_btn","#chosen_word_one_progress_bars_div .progress-bar-custom:first");
				answer_the_question("#chosen_word_two_btn","#chosen_word_two_progress_bars_div .progress-bar-custom:first");
				answer_the_question("#chosen_word_three_btn","#chosen_word_three_progress_bars_div .progress-bar-custom:first");
				answer_the_question("#chosen_word_four_btn","#chosen_word_four_progress_bars_div .progress-bar-custom:first");

				// answer_the_question("#chosen_word_one_btn","#chosen_word_one_progress_bars_div div:not(.progress-bar-success):first");
				// answer_the_question("#chosen_word_two_btn","#chosen_word_two_progress_bars_div div:not(.progress-bar-success):first");
				// answer_the_question("#chosen_word_three_btn","#chosen_word_three_progress_bars_div div:not(.progress-bar-success):first");
				// answer_the_question("#chosen_word_four_btn","#chosen_word_four_progress_bars_div div:not(.progress-bar-success):first");

				// Handles what happens when user answers correctly and incorrectly
				function answer_the_question(button_id_name, first_mini_progress_bar_without_pbc_class) {
					$(button_id_name).click(function(){
						if ($(this).text() == $words_array_five_each[$current_word_counter]) {
							// Update the nth mini progress bar for that word
							$(first_mini_progress_bar_without_pbc_class).removeClass("progress-bar-custom").addClass("progress-bar-success");
						}

						// Find the id of the correct word to update the nth progress bar as incorrect /
						if ($(this).text() != $words_array_five_each[$current_word_counter]) {
							$correct_word_proggress_bar_without_pbc_class = "#" +
									$("button:contains('"+$words_array_five_each[$current_word_counter]+"')")
									.next()
									.attr("id")
									+ " .progress-bar-custom:first"
								;
							$($correct_word_proggress_bar_without_pbc_class).removeClass("progress-bar-custom").addClass("progress-bar-danger");
						}

						// Total up the goodies
						get_goodies();

						// Shuffle the question types
						shuffle_array($question_type_array);
						// Increase the counter
						$current_word_counter++;
						console.log("Current word in the 20-word array (after clicked):",$words_array_five_each[$current_word_counter]);
						console.log("Randomly chosen question type (after clicked):",$question_type_array[0]);
						console.log("Question Types (after clicked):",$question_type_array[0]);
						console.log("Counter (after btn is clicked):",$current_word_counter);
						console.log("****************");
						display_activity_instruction(
							$question_type_array[0],
							$(xml).find($words_array_five_each[$current_word_counter]).children().find($question_type_array[0]+":first").text()
						);

						// When the game is over, display "complete" message
						if ($current_word_counter == 20) {
							$("#chosen_word_one_btn").prop("disabled",true);
							$("#chosen_word_two_btn").prop("disabled",true);
							$("#chosen_word_three_btn").prop("disabled",true);
							$("#chosen_word_four_btn").prop("disabled",true);
							display_activity_instruction("Ready for the results?", "3...2...1...");
							setTimeout(function(){
								$("#level_2_container").hide();
								$("#review_level_two_container").show();

								display_level_2_results(
									"#chosen_word_one_progress_bars_div",
									"#level_two_results_first_circle",
									"#level_two_results_first_word",
									$first_word
								);

								display_level_2_results(
									"#chosen_word_two_progress_bars_div",
									"#level_two_results_second_circle",
									"#level_two_results_second_word",
									$second_word
								);

								display_level_2_results(
									"#chosen_word_three_progress_bars_div",
									"#level_two_results_third_circle",
									"#level_two_results_third_word",
									$third_word
								);

								display_level_2_results(
									"#chosen_word_four_progress_bars_div",
									"#level_two_results_fourth_circle",
									"#level_two_results_fourth_word",
									$fourth_word
								);

							}, 3000);
						}
					});
				}; // end of answer the question fn
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	}; // end of start level 2 fn


	/**
	 * Helper Functions: Support ones that help each activity above
	 */

	// Display which words move up or down
	function display_level_2_results(
		chosen_word_num_progress_bars_div,
		level_two_results_num_circle,
		level_two_results_num_word,
		word_num
		) {
		if ($(chosen_word_num_progress_bars_div + " .progress-bar-success").length > 2) {
			$(level_two_results_num_circle).html("&#8593;");
			$(level_two_results_num_word).html(
																				"<strong>'" + word_num +
																				"'</strong> " +
																				"moves up to Level 3!"
																				);
		}
		else {
			$(level_two_results_num_circle).html("&#8595;");
			$(level_two_results_num_word).html(
																				"<strong>'" + word_num +
																				"'</strong> " +
																				"returns to Level 1."
																				);
		}
	};

	// Computes the goodies
	function get_goodies() {
		var $all_the_goodies = 0;
		$('.progress-bar-success').each(function(){
			$all_the_goodies += parseInt($(this).text());
			$("#goodies_total").html($all_the_goodies);
		});
	};

	// Find the text value of an input
	function words_array_five_each_push(chosen_word_num) {
		$words_array_five_each.push($(chosen_word_num).val());
	};

	// Display the button-text for the chosen words
	function update_button_text(chosen_word_num_btn, chosen_word_num) {
		$(chosen_word_num_btn).text($(chosen_word_num).val());
	};

	// Global fn
	// Reset individual input values
	function reset_input_value(id_name) {
		$("#"+id_name).val(function (){
			return this.defaultValue;
		});
	};

	// Global fn
	// Hide and show elements
	function hide_and_show_button(hide, show) {
		$(hide).hide();
		$(show).show();
	};

	// Global fn
	//Change the activity name and specific directions depending on current state
	function display_activity_instruction(activity_name, specific_instruction) {
		$("#activity_name").html(activity_name);
		$("#specific_instruction").html(specific_instruction);
	};

	// Global fn
	// Set the value for the progress bar
	function progressBar(value) {
		$('.progress-bar').css('width', value+'%').attr('aria-valuenow', value);
	};

	// Global fn
	// Get a random number between y and x
	function randomRange (x, y) {
		return Math.floor(Math.random()* (x-y) + y);
	};

	// Global fn
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

	// Global fn
	// Shortcut for retrieving an element's ID
	function _(x) {
		return document.getElementById(x);
	};
}); // end of document ready fn
