// - Email the results to the teacher when user clicks 'submit to my teacher' button [done w/an error]
// - Ensure space consistency with other levels

$(document).ready(function(){
	/**
	 * Initiating variables and arrays
	 */
	var $chosen_word_value = $("#palabra").data("word-name");
	var $response;
	var $input;
	var $input_value;
	var $count = 3;
	var $semantic_map_responses = [];
	var $word_map_responses = [];
	var $definition_map_responses = [];
	var $sentence_responses = [];
	var $semantic_map_response_container;
	var $individual_semantic_map_response_container;
	var $individual_word_map_response_container;
	var $individual_definition_map_response_container;
	var $individual_sentence_response_container;
	var $semantic_map_input_value = "";
	var $level_3_score = 0;
	var $word_map_input_value = "";
	var $definition_map_input_value = "";
	var $sentence_input_value = "";
	var $valid_chosen_word = false;
	var $new_goodies_total = 0;

	// var $regex = /^[a-zA-Z]*$/; only letters and no spaces or numbers / && $regex.test($chosen_word_value)
	var $regex = /^[a-zA-Z .';-]+$/; // No numbers or special characters just letters and spaces

	$("#level_3_details").fadeIn();
	$("#semantic_map_form").fadeIn();
	// Update the activity name and instruction
	display_activity_instruction("Type three words similar to <strong>'" + $chosen_word_value + "'</strong>.");

	$(".game-three-start-circle").click(function(){
	});

	/**
	 * Start the progress made on learning this word
	 */

	progressBar(0);

	/**
	 * Handle the form validations, i.e. alphabetic, non-numeric, no spaces, for each Level 3 form, i.e. activity
	 */

	validate_input_values("semantic_map_form", "semantic_map_continue_button");
	validate_input_values("word_map_form", "word_map_continue_button");
	validate_input_values("definition_map_form", "definition_map_continue_button");
	validate_input_values("sentence_form", "sentence_continue_button");

	/**
	 * Handle the continue buttons
	 */

	$("#semantic_map_continue_button").click(function(){
		// Update the activity name and instruction
		display_activity_instruction("What words can be formed from <strong>'" + $chosen_word_value + "'</strong>?");

		// Display the next round of input fields and hide the previous one
		$("#semantic_map_form").hide();
		$("#word_map_form").show();

		// Hide the current button
		$("#semantic_map_continue_button").hide();

		// Display the Word Map button only if the values were previously completed, i.e. the user hit the back-button
		show_continue_button_if_activity_completed("word_map_form", "word_map_continue_button");

		$("#semantic_map_back_button").hide();
		$("#word_map_back_button").show();

		// Update the progress bar value
		progressBar(20);
	});

	$("#word_map_continue_button").click(function(){
		// Update the activity name and instruction
		display_activity_instruction("What do you think <strong>'" + $chosen_word_value + "'</strong> means?");

		// Display the next round of input fields and hide the previous one
		$("#word_map_form").hide();
		$("#definition_map_form").show();

		// Display the next button and hide the previous one
		$("#word_map_continue_button").hide();

		// Display the Word Map button only if the values were previously completed, i.e. the user hit the back-button
		show_continue_button_if_activity_completed("definition_map_form", "definition_map_continue_button");

		// Display the next button and hide the previous one
		$("#word_map_back_button").hide();
		$("#definition_map_back_button").show();

		// Update the progress bar value
		progressBar(40);
	});

	$("#definition_map_continue_button").click(function(){
		// Update the activity name and instruction
		display_activity_instruction("Create three sentences with <strong>'" + $chosen_word_value + "'</strong> in each one.");

		// Display the next round of input fields and hide the previous one
		$("#definition_map_form").hide();
		$("#sentence_form").show();

		// Hide the button
		$("#definition_map_continue_button").hide();

		// Display the Word Map button only if the values were previously completed, i.e. the user hit the back-button
		show_continue_button_if_activity_completed("sentence_form", "sentence_continue_button");

		// Display the previous button and hide the previous one
		$("#definition_map_back_button").hide();
		$("#sentence_back_button").show();

		// Update the progress bar value
		progressBar(60);
	});

	$("#sentence_continue_button").click(function(){
		// Ensure the semantic map array and container is empty before adding values
		$semantic_map_responses = [];
		$("#semantic_map_response_container").find("*").not(".review_title").remove();

		// Get the Semantic Map input values and add it to the semantic map array
		$("#semantic_map_form input[type=text]").map(function(){
			var $value = $(this).val();
			$semantic_map_responses.push($value);
			$("#semantic_map_responses").html($(this).val());
		}).get().join();

		// Print each value in the semantic map array on a separate line for review
		for (var i = 0; i < $semantic_map_responses.length; i++) {
			$individual_semantic_map_response_container = $("<span>");
			$("#semantic_map_response_container").append($individual_semantic_map_response_container,"<br>");
			$($individual_semantic_map_response_container).html((i+1) + ". " + $semantic_map_responses[i]);
		}

		//Ensure the word map array and container is empty before adding values
		$word_map_responses = [];
		$("#word_map_response_container").find("*").not(".review_title").remove();

		//Get the word map input values and add it to the word map array
		$("#word_map_form input[type=text]").map(function(){
			var $value = $(this).val();
			$word_map_responses.push($value);
			$("#word_map_responses").html($(this).val());
		}).get().join();

		// Print each value in the semantic map array on a separate line for review
		for (var i = 0; i < $word_map_responses.length; i++) {
			$individual_word_map_response_container = $("<span>");
			$("#word_map_response_container").append($individual_word_map_response_container,"<br>");
			$($individual_word_map_response_container).html((i+1) + ". " + $word_map_responses[i]);
		}

		//Ensure the definition map array and container is empty before adding values
		$definition_map_responses = [];
		$("#definition_map_response_container").find("*").not(".review_title").remove();

		//Get the definition map input values and add it to the definition map array
		$("#definition_map_form input[type=text]").map(function(){
			var $value = $(this).val();
			$definition_map_responses.push($value);
			$("#definition_map_responses").html($(this).val());
		}).get().join();

		// Print each value in the semantic map array on a separate line for review
		for (var i = 0; i < $definition_map_responses.length; i++) {
			$individual_definition_map_response_container = $("<span>");
			$("#definition_map_response_container").append($individual_definition_map_response_container,"<br>");
			$($individual_definition_map_response_container).html((i+1) + ". " + $definition_map_responses[i]);
		}

		//Ensure the sentence array and container is empty before adding values
		$sentence_responses = [];
		$("#sentence_response_container").find("*").not(".review_title").remove();

		//Get the sentence map input values and add it to the sentence array
		$("#sentence_form input[type=text]").map(function(){
			var $value = $(this).val();
			$sentence_responses.push($value);
			$("#sentence_responses").html($(this).val());
		}).get().join();

		// Print each value in the semantic map array on a separate line for review
		for (var i = 0; i < $sentence_responses.length; i++) {
			$individual_sentence_response_container = $("<span>");
			$("#sentence_response_container").append($individual_sentence_response_container,"<br>");
			$($individual_sentence_response_container).html((i+1) + ". " + $sentence_responses[i]);
		}

		// Update the activity name and instruction
		display_activity_instruction("Double-check and submit your work for <strong>'" + $chosen_word_value + "'</strong>!");

		// Display the next round of input fields and hide the previous one
		$("#sentence_form").hide();
		$("#review_level_3_container").show();

		// Display the next button and hide the previous one
		$("#sentence_continue_button").hide();
		$("#review_level_3_button").show();

		// Hide the plus and minus buttons
		$("#add_minus_buttons").hide();

		// Display the previous button and hide the previous one
		$("#sentence_back_button").hide();
		$("#review_level_3_back_button").show();

		// Update the progress made on learning this word
		progressBar(80);
	});

	$("#review_level_3_button").click(function(){

		$("#level_3_completed").show();

		$("#level_3_details, #goodies").hide();
		$("#review_level_3_back_button").hide();
		$("#review_level_3_button").hide();
		$("#review_level_3_container").hide();

		$("#goodies, #progress_bar_container").css("visibility","hidden");
		$("#all_levels_button").show();
		$("#level_congrats_text").append("<strong>'" + $chosen_word_value + "'</strong> ");
		$("#goodies_total").html($new_goodies_total);

		// Update the progress bar value
		progressBar(100);
	});

	/**
	 * Functions
	 */

	// Update user_word_game_level_status
	function update_jeopardy_status_as_complete(word_id) {
		var game_info = {
			"word_id": word_id
		};

		$.ajax({
			type: "PATCH",
			url: "/freestyle_game",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response);
			}
		});
	};

	$(function(){
		// Get the form
		var form = $("#freestyle-form");

		// Get the results div
		var formMessages = $("#results");

		// Set up an event listener for the contact form
		$(form).submit(function(event){
			// Stop the browser from submitting the form
			event.preventDefault();

			// Serialize the form data
			var formData = $(form).serialize();

			$.ajax({
				type: 'POST',
				url: $(form).attr('action'),
				data: formData
			}).done(function(response){
				// Make sure that the formMessages div has the 'success' class
				$(formMessages).removeClass('has-error').addClass('has-success');

				// Set the message text
				$(formMessages).text(response);

				// Clear the form
					// Not needed because it's already done elsewhere
			}).fail(function(data){
				// Make sure that the formMessages div has the 'error' class
				$(formMessages).removeClass('has-success').addClass('has-error');

				// Set the message text
				if (data.responseText !== '') {
					$(formMessages).text(data.responseText);
				} else {
					$(formMessages).text('Oops! An error occurred and your message could not be sent.');
				}
			});
		});
	});


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

	// Strip the functionality of the "enter" key because it oddly sends the form hit in an input
	$(window).keydown(function(event){
		if(event.keyCode == 13) {
			event.preventDefault();
			return false;
		}
	});

	// For each individual input field, validate what's being typed in and if all are completed correctly, enable the user to proceed
	function validate_input_values(form_name, continue_button_name) {
		var $form_name = "#"+form_name + "" + " *";
		var $continue_button_name = "#"+continue_button_name;
		var $input_valid = "#" + form_name + " input.valid";

		$($form_name).filter(':input').each(function(){


			$(this).on('input',function(){
				$input_value = $.trim($(this).val());
				// If the input is longer than two characters and does not contain a number or space, make the input green to show it's valid
				if($input_value.length > 2 && $regex.test($input_value)){
					$(this).removeClass("invalid").addClass("valid");
				} else {
					$(this).removeClass("valid").addClass("invalid");
				}

				// If all three inputs have the class "valid", display the continue button and vice versa if not
				if($($input_valid).length == 3){
					$($continue_button_name).fadeIn();
					boost_goodies(1800);
				} else {
					$($continue_button_name).fadeOut();
				}
			});
		});
	}

	// Display the next activity's continue button only if the values were previously completed, i.e. the user hit the back-button
	function show_continue_button_if_activity_completed(form_name, continue_button_name) {
		var $continue_button_name = "#"+continue_button_name;
		var $input_valid = "#" + form_name + " input.valid";

		// If all three inputs have the class "valid", display the continue button and vice versa if not
		if($($input_valid).length == 3){
			$($continue_button_name).fadeIn();
		} else {
			$($continue_button_name).fadeOut();
		}
	}

	//Change the activity name and specific directions depending on current state
	function display_activity_instruction( specific_instruction) {
		$(".freestyle-instructions").html(specific_instruction);
	}

	// Reset individual input values
	function reset_input_value(id_name) {
		$("#"+id_name).val(function (){
			return this.defaultValue;
		});
	};

	// Set the value for the progress bar
	function progressBar(value) {
		$('.game-progress-bar').css('width', value+'%').attr('aria-valuenow', value);
	}

	// Shortcut for retrieving an element's ID
	function _(x) {
		return document.getElementById(x);
	};
}); // end of document ready fn
