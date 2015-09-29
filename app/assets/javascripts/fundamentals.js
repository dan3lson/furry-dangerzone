$(document).ready(function(){
	/**
	 * Initiating variables and arrays
	 */

	// General
	var $chosen_word_value = $(".word-name").html();
	var $chosen_word_id = $(".palabra-id").html();
	var $styled_chosen_word_value = "";
	var $each_letter_span; // letters shown in the header
	var $regex = /^[a-zA-Z. ]+$/; // No numbers or special characters just letters and spaces; /^[a-zA-Z]*$/; is only letters and no spaces or numbers
	var $new_goodies_total = 0;
	// Spell the word
	var $word_being_spelled;
	var $chosen_word_substring;
	var $chosen_word_substring_array = [];
	if ($chosen_word_value != undefined) {
		var $chosen_word_each_letter_array = $chosen_word_value.split('');
	}
	// Fill in the blank
	var $each_life_span;
	var	$each_letter_fill_in_the_blank_div; // letters shown in the fill in the blanks activity
	var	$each_random_letter_fill_in_the_blank_array; // random letters shown in the fill in the blanks activity
	var $alphabet_array = "abcdefghijklmnopqrstuvwxyz".split('');
	var	$alphabet_random_letter;
	var $alphabet_random_letters_array = [];
	var $merged_letters_array = [];
	var $fill_in_the_blank_correctly_spelled_word = "";
	var $fill_in_the_blank_incorrect_count = 0;
	var $tapped_letter_div;
	var $tapped_letter;
	var $fill_in_the_blank_game_won = false;
	var $fill_in_the_blank_underscore_header = "";
	// Meanings, Synonyms, and / or Antonyms
	var $word_details_container;
	var $xml_similar_word = "";
	var $pronunciation_div;
	var $xml_part_of_speech_elements;
	var $part_of_speech_div;
	// Meanings
	var $xml_meaning = "";
	var $meaning_row;
	var $meaning_div;
	var $meaning_circle_div;
	var $meanings_container;
	var $meaning_pos_collapse_header = "";
	var	$meaning_circle_activity_boolean = false;
	// Synonyms
	var $synonym_row;
	var $synonym_circle_div;
	var $synonym_word_div;
	var $synonym_circle_activity_boolean = false;
	// Antonyms
	var $antonym_row;
	var $antonym_circle_div;
	var $antonym_word_div;
	var $antonym_circle_activity_boolean = false;
	// Synonyms / Antonyms Checkpoint
	var $syn_ant_row;
	var $syn_ant_circle_div;
	var $syn_ant_word_div;
	var $syn_ant_checkpoint_synonyms_array = [];
	var $syn_ant_checkpoint_antonyms_array = [];
	var $shuffled_syn_ant_array = [];
	var $shuffled_syn_ant_array_counter = 0;
	var $current_syn_ant_checkpoint_div;
	var $current_syn_ant_checkpoint_word = "";
	var $syn_ant_checkpoint_score_div;
	var $syn_ant_checkpoint_correct_score = 0;
	var $syn_ant_circle_activity_boolean = false;
	// Real World Exampels
	var $rwe_row;
	var $rwe_circle_div;
	var $rwe_source_div;
	var $rwe_collapse_header = "";
	var $rwe_container;
	var $rwe_circle_activity_boolean = false;

		// Update the instructions
		display_instruction("Type the word below:");

		// Dislay chosen word
		$("#chosen-word-header-container").html($chosen_word_value);

		// Start the first activity
		spell_chosen_word();

		/**
		 * Start the progress made on learning this word
		 */

		progressBar(0);
	$(".game-one-start-circle").click(function(){
	});

	/**
	 * Handle the continue buttons
	 */

	$("#spell_the_word_continue_button").click(function(event){
		// Hide the first activity
		$("#spell_the_word_form").hide();

		// Show and hide buttons
		hide_and_show_button("#restart_back_button, #spell_the_word_continue_button", "#fill_in_the_blank_back_button");

		// Update the activity name and instruction
		display_instruction("Tap the letters to spell the word correctly.");

		// Update the progress made
		progressBar(15);

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("1", 1);

		// Check if Fill in the blank activity was already won
		if ($fill_in_the_blank_game_won) {
			$alphabet_random_letters_array = [];
			$merged_letters_array = [];
			$("#fill_in_the_blank_container, #fill_in_the_blank_continue_button").show();
		} else {
			$alphabet_random_letters_array = [];
			$merged_letters_array = [];
			// Make sure the string containing the letters the user guesses to spell the word is empty before displaying what's typed
			$fill_in_the_blank_correctly_spelled_word = "";

			// Load the next activity
			start_fill_in_the_blank_checkpoint_activity();
		}
	});

	$("#fill_in_the_blank_continue_button").click(function(){

		// Show and hide buttons
		hide_and_show_button("#fill_in_the_blank_back_button, #fill_in_the_blank_continue_button, #fill_in_the_blank_container", "#pronunciation_back_button, #pronunciation_container");
		$("#chosen-word-header-container").hide();

		// Update the activity name and instruction
		display_instruction("Say <strong>'" + $chosen_word_value + "'</strong> aloud and then tap the mic.");

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("2", 2);

		// Update the progress made
		progressBar(30);
	});

	$("#pronunciation_image_button").click(function(){
		$("#pronunciation_continue_button").fadeIn();
	});

	$("#pronunciation_continue_button").click(function(){

		// Show and hide buttons
		$("#pronunciation_back_button, #pronunciation_container, #pronunciation_continue_button").hide();
		$("#meanings_back_button, #meanings_container").show();

		// Update the activity name and instruction
		$part_of_speech = $(".word-part-of-speech").html();
		display_instruction("As a(n) " + $part_of_speech + ", read the meaning(s) for <strong>'" + $chosen_word_value + "'</strong>.")

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("3", 3);

		// Update the progress made
		progressBar(45);

		// Start the next activity, i.e. Meanings, if not already started
		start_meanings_activity($chosen_word_value);

		// If all words have been clicked on, show the meanings continue button
		if ($meaning_circle_activity_boolean) {
			$("#meanings_continue_button").show();
		};
	});

	$("#meanings_continue_button").click(function(){
		// Show and hide buttons
		$("#meanings_back_button, #meanings_container, #meanings_continue_button").hide();

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("4", 4);

		if (!$("#synonym_no_results").hasClass("please-tap-continue")) {
			// Show and hide buttons
			$("#synonyms_back_button, #synonyms_container").show();

			// Update the activity name and instruction
			display_instruction("The words below are similar to " + "<strong>'" + $chosen_word_value + "'</strong>. Tap and view each one.");

			// Update the progress made
			progressBar(60);

			start_synonyms_activity($chosen_word_value);
		} else if ($("#synonym_no_results").hasClass("please-tap-continue") && !$("#antonym_no_results").hasClass("please-tap-continue")) {
			// Show and hide buttons
			$("#synonyms_back_button, #synonyms_continue_button, #synonyms_container").hide();
			$("#antonyms_back_button, #antonyms_container").show();

			// Update the activity name and instruction
			display_instruction("The words below are opposite to " + "<strong>'" + $chosen_word_value + "'</strong>. Tap and view each one.");

			// Update the progress made
			progressBar(75);

			update_user_word_game_level_status("5", 5);

			start_antonyms_activity($chosen_word_value);
		} else if ($("#synonym_no_results").hasClass("please-tap-continue") && $("#antonym_no_results").hasClass("please-tap-continue")) {
			// Show and hide buttons
			$("#real_world_examples_back_button, #real_world_examples_container").show();

			// Update the activity name and instruction
			display_instruction("Tap each source to see how <strong>'" + $chosen_word_value + "'</strong> has been used in everyday life.");

			// Update the user_word_game_level's status to complete
			update_user_word_game_level_status("5", 5);
			update_user_word_game_level_status("6", 6);
			update_user_word_game_level_status("7", 7);

			// Update the progress made
			progressBar(90);

			// Start the next activity, i.e. Real World Examples, if not already started
			start_real_world_examples_activity($chosen_word_value);
		}

		// If all words have been clicked on, show the synonyms continue button
		if ($synonym_circle_activity_boolean) {
			$("#synonyms_continue_button").show();
		};
	});

	$("#synonyms_continue_button").click(function(){
		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("5", 5);

		// Start the next activity --> if there are synonyms, but no antonyms
		if ($("#antonym_no_results").hasClass("please-tap-continue")) {
			// Show and hide buttons
			$("#syn_ant_checkpoint_back_button, #syn_ant_checkpoint_container").show();
			$("#synonyms_back_button, #synonyms_continue_button, #synonyms_container").hide();
			$("#antonyms_back_button, #antonyms_continue_button, #antonyms_container").hide();

			// Update the activity name and instruction
			display_instruction("Is <strong>'" + $chosen_word_value + "'</strong> a synonym or antonym to:");

			// Update the progress made
			progressBar(75);

			// Update the user_word_game_level's status to complete
			update_user_word_game_level_status("6", 6);

			start_syn_ant_checkpoint_activity($chosen_word_value);

		// Start the next activity --> if there there are antonyms
		} else {
			// Show and hide buttons
			$("#synonyms_back_button, #synonyms_continue_button, #synonyms_container").hide();
			$("#antonyms_back_button, #antonyms_container").show();

			// Update the activity name and instruction
			display_instruction("The words below are opposite to " + "<strong>'" + $chosen_word_value + "'</strong>. Tap and view each one.");

			// Update the progress made
			progressBar(75);

			start_antonyms_activity($chosen_word_value);
		}

		// If all words have been clicked on, show the antonyms continue button
		if ($antonym_circle_activity_boolean) {
			$("#antonyms_continue_button").show();
		};
	});

	$("#antonyms_continue_button").click(function(){
		// Show and hide buttons
		$("#syn_ant_checkpoint_back_button, #syn_ant_checkpoint_container").show();
		$("#antonyms_back_button, #antonyms_continue_button, #antonyms_container").hide();

		// Update the activity name and instruction
		display_instruction("Is <strong>'" + $chosen_word_value + "'</strong> a synonym or antonym to:");

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("6", 6);

		// Update the progress made
		progressBar(75);

		// Start the next activity, i.e. Syn / Ant checkpoint, if not already started
		if ($(".current_syn_ant_checkpoint_word")[0] == undefined) {
			start_syn_ant_checkpoint_activity($chosen_word_value);
		}

		// If the checkpoint has been completed, show the syn_ant continue button
		//
		if ($syn_ant_circle_activity_boolean) {
			$("#syn_ant_checkpoint_continue_button").show();
			// Display the number correct out of the total number of synonyms and antonyms available
			$("#syn_ant_checkpoint_score_div").html($syn_ant_checkpoint_correct_score + " / " + $shuffled_syn_ant_array.length).show();
		}
	});

	$("#syn_ant_checkpoint_continue_button").click(function(){

		// Show and hide buttons
		$("#syn_ant_checkpoint_back_button, #syn_ant_checkpoint_container, #syn_ant_checkpoint_continue_button, #syn_ant_checkpoint_score_div").hide();
		$("#real_world_examples_back_button, #real_world_examples_container").show();

		// Update the activity name and instruction
		display_instruction("Tap each source to see how <strong>'" + $chosen_word_value + "'</strong> has been used in everyday life.");

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("7", 7);

		// Update the progress made
		progressBar(90);

		// Start the next activity, i.e. Real World Examples, if not already started
		start_real_world_examples_activity($chosen_word_value);

		// If all words have been clicked on, show the real world examples container
		if ($rwe_circle_activity_boolean) {
			$("#real_world_examples_continue_button").show();
		}

	});

	$("#real_world_examples_continue_button").click(function(){

		// Show and hide buttons
		$("#real_world_examples_back_button, #real_world_examples_continue_button, #real_world_examples_container, #level_1_details").hide();
		$("#review_level_one_back_button, #review_level_one_continue_button, #review_level_one_container").fadeIn();

		// Update the user_word_game_level's status to complete
		update_user_word_game_level_status("8", 8);

		// Create the game_level's for Jeopardy
		var game_info = {
			"word_id": $chosen_word_id
		};

		$.ajax({
			type: "POST",
			url: "/jeopardy_game",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response);
			}
		});

		// Update the progress made
		progressBar(100);

		// Update user goodies
		update_user_points(10);
		boost_goodies(10);

		// Start the next activity, i.e. review level one
		start_review_level_one_activity($chosen_word_value);

		// Hide the exit btn and display the home btn
		$("#game-exit-btn").hide();
		$("#game-home-btn").show();
	});

	/**
	 * Starter Functions: Main ones that initiate each activity
	 */

	// Start Level 1 with the spelling activity
	function spell_chosen_word() {
		$("#spell_the_word").focus();

		$("#spell_the_word").on('input', function(){
			$word_being_spelled = $.trim($(this).val().toLowerCase());

			if ($word_being_spelled == $chosen_word_value) {
				$("#spell_the_word_continue_button").fadeIn();
			} else {
				$("#spell_the_word_continue_button").fadeOut();
			}
		});
	};

	// Start the fill in the blank activity
	function start_fill_in_the_blank_checkpoint_activity() {
		// Display the randomized letter container
		$("#fill_in_the_blank_container").show();

		// Create five random letters and add them into an array
		for (var i = 0; i < 3; i++) {
			$alphabet_random_letter = $alphabet_array[randomRange(26,0)];
			$alphabet_random_letters_array.push($alphabet_random_letter);
		}

		// Merge the chosen word array and the five random letters array and then shuffle the letters in them
		$merged_letters_array = $.merge($.merge([], $chosen_word_each_letter_array),$alphabet_random_letters_array);

		// Shuffle the merged array before displaying
		$merged_letters_array = shuffle_array($merged_letters_array);

		$.each($merged_letters_array, function(index, value){
			$each_letter_fill_in_the_blank_div = $("<div>", { class: "col-xs-4 col-sm-3 text-center fill_in_the_blank_letters pointer letter_" + value } );
			$("#fill_in_the_blank_container").append($each_letter_fill_in_the_blank_div);
			$($each_letter_fill_in_the_blank_div).append(value).html();
		});

		// If a letter is hovered in or out, change the background and text color
		$(".fill_in_the_blank_letters").hover(function(){
			$(this).addClass("fill_in_the_blank_letters_hover");
		}, function(){
			$(this).removeClass("fill_in_the_blank_letters_hover");
		});


		$(".fill_in_the_blank_letters").click(function(){
			$tapped_letter_div = $(this);
			$tapped_letter = $(this).text();

			// If the letter selected matches the letters, in order, of the chosen word array, change the background and text color
			for (var i = 0; i < $chosen_word_each_letter_array.length; i++) {
				var $first_letter = $chosen_word_each_letter_array[0];
			}

			// If the tapped letter is correct
			if ($first_letter == $tapped_letter) {
				// When the letter is clicked, make it invisible
				$(this).css("visibility", "hidden");

				$fill_in_the_blank_correctly_spelled_word += $tapped_letter;

				// Replace the underscore with the tapped letter
				$("#chosen-word-header-container").html($fill_in_the_blank_correctly_spelled_word);

				// Remove the first element in the chosen word letters array
				$chosen_word_each_letter_array.shift();

			// If the tapped letter is incorrect
			} else {
				$fill_in_the_blank_incorrect_count++;
			}

			if ($chosen_word_each_letter_array.length == 0) {
				$("#fill_in_the_blank_continue_button").fadeIn();
				$(".fill_in_the_blank_letters").hide();
				$fill_in_the_blank_game_won = true;
			} else {
				$("#fill_in_the_blank_continue_button").fadeOut();
			}

			if ($fill_in_the_blank_incorrect_count == 3) {
				// Hide the letters
				$(".fill_in_the_blank_letters").fadeOut();;

				// Show a message for them to look at the spelling again
				$("#fill_in_the_blank_game_over_message").fadeIn();

				$fill_in_the_blank_game_won = false;
			}
		});
	};

	// Start the meanings activity
	function start_meanings_activity(chosen_word_value) {
		$("#meanings_container, #meanings_continue_button").fadeIn();
		$meaning_circle_activity_boolean = true;
	}; // end of the start meanings activity function

	// Start the synonyms activity
	function start_synonyms_activity(chosen_word_value) {
		if ($("#synonym_no_results").hasClass("please-tap-continue")) {
			$("#synonyms_continue_button").fadeIn();
			$synonym_circle_activity_boolean = true;
		} else {
			// Click anywhere (row, circle, or word) to change element features
			$(".synonym_row").click(function(){
				// Fill in the circle
				$(this).children(":first").addClass("green-circle-background");
				// If all words have been clicked on, show the continue button
				if ($("#synonyms_container .green-circle-background").length == $(".synonym_row").length) {
					// scroll_to_bottom();
					$("#synonyms_continue_button").fadeIn();
					$synonym_circle_activity_boolean = true;
				};
			}); // end of the $synonym_row .click fn
		}
	}; // end of the start synonyms activity function

	// Start the antonyms activity
	function start_antonyms_activity(chosen_word_value) {
		if ($("#antonym_no_results").hasClass("please-tap-continue")) {
			$("#antonyms_continue_button").fadeIn();
			$antonym_circle_activity_boolean = true;
		} else {
			// Click anywhere (row, circle, or word) to change element features
			$(".antonym_row").click(function(){
				// Fill in the circle
				$(this).children(":first").addClass("green-circle-background");
				// If all words have been clicked on, show the continue button
				if ($("#antonyms_container .green-circle-background").length == $(".antonym_row").length) {
					$("#antonyms_continue_button").fadeIn();
					$antonym_circle_activity_boolean = true;
				};
			}); // end of the $antonym_row .click fn
		}
	}; // end of the start antonyms activity function

	// Start the synonyms / antonyms checkpoint activity
	function start_syn_ant_checkpoint_activity(chosen_word_value) {
		// Create a score counter:  0 / X
		$syn_ant_checkpoint_score_div = $("<div>", { id: "syn_ant_checkpoint_score_div", class: "pull-right" } );
		$($syn_ant_checkpoint_score_div).insertBefore("#syn_ant_checkpoint_container");

		// Find all of the synonyms for this word and add to the synonyms array
		$(".synonym_word_container").each(function(index){
			$syn_ant_checkpoint_synonyms_array.push($(this).html());
		});

		// Find all of the antonyms for this word and add to the antonyms array
		$(".antonym_word_container").each(function(index){
			$syn_ant_checkpoint_antonyms_array.push($(this).html());
		});

		// Display the number correct out of the total number of synonyms and antonyms available
		$("#syn_ant_checkpoint_score_div").html($syn_ant_checkpoint_correct_score + " / " + $shuffled_syn_ant_array.length).show();

		if (!$syn_ant_circle_activity_boolean) {

			// Merge the synonym and antonym arrays above and then randomize the order
			$shuffled_syn_ant_array = $.merge($.merge([], $syn_ant_checkpoint_synonyms_array),$syn_ant_checkpoint_antonyms_array);
			$shuffled_syn_ant_array = shuffle_array($shuffled_syn_ant_array);

			// Display the synonyms and antonyms for this word
			for (var i = 0; i < $shuffled_syn_ant_array.length; i++) {
				// Create a row for the circle and word itself
				$syn_ant_row = $("<div>", { class: "syn_ant_row" } );
				$syn_ant_circle_div = $("<div>", {class: "syn_ant_checkpoint_red_circle inline-block"} );
				$syn_ant_word_div = $("<div>", {class: "syn_ant_word_container lead inline-block"} );

				// Add the individual row to the syn_ants container
				$("#syn_ant_checkpoint_container").append($syn_ant_row);

				// Add the circle and word div to the syn_ant row
				$($syn_ant_row).append($syn_ant_circle_div, $syn_ant_word_div);
				// Hide the circle temporarily
				$($syn_ant_circle_div).hide();

				// Add the word itself to the syn_ant_word div so it can be displayed
				$($syn_ant_word_div).append($shuffled_syn_ant_array[i]);
			}

			// Hide all of the words except the first one
			$(".syn_ant_row").not(":first").hide();

			// Highlight the first word to start
			$(".syn_ant_word_container:first").addClass("current_syn_ant_checkpoint_word");

			// Create the synonym and antonym button
			$syn_ant_checkpoint_synonym_button_div = $("<div>", { class: "col-xs-6", id: "syn_ant_checkpoint_synonym_button_div" } );
			$syn_ant_checkpoint_antonym_button_div = $("<div>", { class: "col-xs-6", id: "syn_ant_checkpoint_antonym_button_div" } );
			$syn_ant_checkpoint_synonym_button = $("<button/>", { type: "button",
																	text: "synonym",
																	class: "btn btn-lg btn-info btn-block syn_ant_checkpoint_btns",
																	id: "syn_ant_checkpoint_synonym_button"
																}
												 );
			$syn_ant_checkpoint_antonym_button = $("<button/>", { type: "button",
																	text: "antonym",
																	class: "btn btn-lg btn-info btn-block syn_ant_checkpoint_btns",
																	id: "syn_ant_checkpoint_antonym_button"
																}
													);
			$("#syn_ant_checkpoint_container").append($syn_ant_checkpoint_synonym_button_div, $syn_ant_checkpoint_antonym_button_div)
			$($syn_ant_checkpoint_synonym_button_div).append($syn_ant_checkpoint_synonym_button);
			$($syn_ant_checkpoint_antonym_button_div).append($syn_ant_checkpoint_antonym_button);
		}

		// SYNONYM BUTTON: Check if the highlighted word is part of the synonym array.
		click_syn_or_ant_checkpoint_button($syn_ant_checkpoint_synonym_button,$syn_ant_checkpoint_synonyms_array);

		// ANTONYM BUTTON: Check if the highlighted word is part of the antonym array.
		click_syn_or_ant_checkpoint_button($syn_ant_checkpoint_antonym_button,$syn_ant_checkpoint_antonyms_array);

		//Checks if there are any synonyms or antonyms. If not, display a message and show the continue button
		$(".no_word_info").remove();
		if ($shuffled_syn_ant_array.length == 0) {
			$(".syn_ant_checkpoint_btns").hide();
			// var $no_word_info_container = $("<span>", {class: "no_word_info lead"} );
			// var $message = "&#9785; We don't have any synonyms or antonyms to do a checkpoint. Please tap continue.";
			// $("#syn_ant_checkpoint_container").append($no_word_info_container);
			// $($no_word_info_container).append($message);
			$("#syn-ant-no-results").fadeIn();
			$("#syn_ant_checkpoint_continue_button").fadeIn();
		}
	};

	// Start the real world examples activity
	function start_real_world_examples_activity(chosen_word_value) {
		if ($("#rwe_no_results").hasClass("please-tap-continue")) {
			$("#real_world_examples_continue_button").fadeIn();
			$rwe_circle_activity_boolean = true;
		} else {
			// Click anywhere (row, circle, or word) to change element features
			$(".rwe_row").click(function(){
				// Fill in the circle
				$(this).children(":first").addClass("green-circle-background");

				// If all words have been clicked on, show the continue button
				if ($("#real_world_examples_container .green-circle-background").length == $(".rwe_row").length) {
					$("#real_world_examples_continue_button").fadeIn();
					$rwe_circle_activity_boolean = true;
				};
			}); // end of the $rwe_row .click fn
		}
	};

	// Start the review level one activity
	function start_review_level_one_activity(chosen_word_value) {
		$("#review_level_one_back_button").hide();
		$("#goodies, #games-score, #progress_bar_container").css("visibility","hidden");
		$("#all_levels_button").show();
		$("#level_congrats_text").append("<strong>'" + $chosen_word_value + "'</strong> ");
		$("#goodies_total").html($new_goodies_total);
	};

	/**
	 * Helper Functions: Support ones that help each activity above
	 */

	// Update user_word_game_level_status
	function update_user_word_game_level_status(level_id, num) {
		var game_info = {
			"game_name": "Fundamentals",
			"level_id": level_id,
			"word_id": $chosen_word_id
		};

		$.ajax({
			type: "PATCH",
			url: "/user_word_game_level",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify(game_info),
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

	// Synonym, Antonym, Sentence Examples fn
	// If there isn't any info for the clicked word, display a sorry message
	function check_if_pos_is_empty(activity_container) {
		$(".no_word_info").remove();
		if ($xml_part_of_speech_elements.length == 0) {
			var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
			var $message = "&#9785; Aww man, there's no info for this word yet.";
			$(activity_container).append($no_word_info_container);
			$($no_word_info_container).append($message);
		}
	};

	// Synonym_Antonym Checkpoint Activity
	// Check if the current word is part of the (syn or ant) array.
	function click_syn_or_ant_checkpoint_button(syn_ant_checkpoint_name_button,syn_ant_checkpoint_names_array) {
		// SYNONYM BUTTON: Check if the current word is part of the synonym array.
		$(syn_ant_checkpoint_name_button).click(function(){

			// Capture the current word in the array
			$current_syn_ant_checkpoint_word = $shuffled_syn_ant_array[$shuffled_syn_ant_array_counter];

			// Check if the current word is a synonym
			if (syn_ant_checkpoint_names_array.indexOf($current_syn_ant_checkpoint_word) != -1) {
				$shuffled_syn_ant_array_counter++;

				// Put a checkmark in the circle
				$(".current_syn_ant_checkpoint_word")
					.prev()
					.html("&#10004;")
				;

				// Update and display the score
				$syn_ant_checkpoint_correct_score++;

				// Display the number correct out of the total number of synonyms and antonyms available
				$("#syn_ant_checkpoint_score_div").html($syn_ant_checkpoint_correct_score + " / " + $shuffled_syn_ant_array.length).show();
			} else {
				// Go to the next word
				$shuffled_syn_ant_array_counter++;

				// Put an X in the circle
				$(".current_syn_ant_checkpoint_word")
					.prev()
					.html("&#10006;")
				;
			}

			// Display the next word
			$(".current_syn_ant_checkpoint_word")
				.parent()
				.next()
				.fadeIn()
			;

			// Add the active class to the next word
			$(".current_syn_ant_checkpoint_word")
				.parent()
				.next()
				.children(":last")
				.addClass("current_syn_ant_checkpoint_word")
			;

			// Hide the previous word
			$(".current_syn_ant_checkpoint_word")
				.parent()
				.prev()
				.hide()
			;

			// Remove the active class from the previous word
			$(".current_syn_ant_checkpoint_word")
				.parent()
				.prev()
				.children(":last")
				.removeClass("current_syn_ant_checkpoint_word")
			;

			// Once all words have been clicked on, hide the synonym and antonym button
			if ($shuffled_syn_ant_array_counter == $shuffled_syn_ant_array.length) {
				// Show the circles and their results
				$(".syn_ant_checkpoint_red_circle").show();

				// Display the number correct out of the total number of synonyms and antonyms available
				$("#syn_ant_checkpoint_score_div").html($syn_ant_checkpoint_correct_score + " / " + $shuffled_syn_ant_array.length).show();

				// Hide the synonym and antonym buttons
				$(".syn_ant_checkpoint_btns").hide();

				// Remove the active class from the previous last
				$(".current_syn_ant_checkpoint_word").removeClass("current_syn_ant_checkpoint_word");

				// Show all words to serve as a review
				$(".syn_ant_row").fadeIn();

				// Show the continue button
				$("#syn_ant_checkpoint_continue_button").fadeIn();
			}

			// If all the syn_ant_rows are visible, update the boolean to true
			if ($(".syn_ant_row:visible").length == $shuffled_syn_ant_array.length) {
				$syn_ant_circle_activity_boolean = true;
			}
		}); // end of the syn_ant_checkpoint buttton fn
	}; // end of the click fn

	// Global fn
	// Increase the goodies per level
	function boost_goodies(level_multiplier) {
		$new_goodies_total += level_multiplier;
		$("#goodies").html($new_goodies_total);
	};

	// Global fn
	// Revert to previous goodie amount
	function reset_goodies(old_total) {
		new_goodies_total = old_total;
		$("#goodies").html(new_goodies_total);
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
		$(show).fadeIn();
	};

	// Global fn
	//Change the activity name and specific directions depending on current state
	function display_instruction(instruction) {
		$(".fundamentals-game-instructions").html(instruction);
	};

	// Global fn
	// Set the value for the progress bar
	function progressBar(value) {
		$('.game-progress-bar').css('width', value+'%').attr('aria-valuenow', value);
	};

	// Global fn
	// Get a random number between y and x
	function randomRange (x, y) {
		return Math.floor(Math.random()* (x-y) + y);
	};

	// Global fn
	// Scroll to the bottom of the page when user can continue
	function scroll_to_bottom () {
		$("html, body").animate({ scrollTop: $(document).height() }, "slow");
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
