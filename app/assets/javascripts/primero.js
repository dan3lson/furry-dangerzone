$(document).ready(function(){
	/**
	 * Initiating variables and arrays
	 */

	// General
	var $chosen_word_value = $(".word-name").html();
	var $styled_chosen_word_value = "";
	var $each_letter_span; // letters shown in the header
	var $regex = /^[a-zA-Z. ]+$/; // No numbers or special characters just letters and spaces; /^[a-zA-Z]*$/; is only letters and no spaces or numbers
	var $new_goodies_total = 0;
	// Spell the word
	var $word_being_spelled;
	var $chosen_word_substring;
	var $chosen_word_substring_array = [];
	var $chosen_word_each_letter_array = $chosen_word_value.split('');
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

	$("#level_1_details, #spell_the_word_form").show();

	// Show and hide buttons
	hide_and_show_button("#all_levels_button, #start_level_1_button", "#restart_back_button");

	// Update the activity name and instruction
	display_activity_instruction("Spelling","Type the word below:");

	// Dislay chosen word
	$("#chosen_word_header_container").html($chosen_word_value);

	// Start the first activity
	spell_chosen_word();

	/**
	 * Start the progress made on learning this word
	 */

	progressBar(0);

	/**
	 * Handle the continue buttons
	 */

	$("#spell_the_word_continue_button").click(function(){
		// Hide the first activity
		$("#spell_the_word_form").hide();

		// Show and hide buttons
		hide_and_show_button("#restart_back_button, #spell_the_word_continue_button", "#fill_in_the_blank_back_button");

		// Update the activity name and instruction
		display_activity_instruction("Checkpoint!","Spell the word in order.");

		// Update the progress made
		progressBar(15);

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
		$("#chosen_word_header_container").hide();

		// Update the activity name and instruction
		display_activity_instruction("Pronunciation","Say <strong>'" + $chosen_word_value + "'</strong> aloud and then hit the mic.");


		// Update the progress made
		progressBar(30);
	});

	$("#pronunciation_image_button").click(function(){
		$("#pronunciation_continue_button").show("fade");
		boost_goodies(900);
	});

	$("#pronunciation_continue_button").click(function(){

		// Show and hide buttons
		$("#pronunciation_back_button, #pronunciation_container, #pronunciation_continue_button").hide();
		$("#meanings_back_button, #meanings_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Meanings","<strong>'" + $chosen_word_value + "'</strong> can have different meanings depending on how you use it.");

		// Update the progress made
		progressBar(45);

		// Start the next activity, i.e. Meanings, if not already started
		if ($("#meanings_container").children().length == 0) {
			start_meanings_activity($chosen_word_value);
		};

		// If all words have been clicked on, show the meanings continue button
		if ($meaning_circle_activity_boolean) {
			$("#meanings_continue_button").show();
		};
	});

	$("#meanings_continue_button").click(function(){

		// Show and hide buttons
		$("#meanings_back_button, #meanings_container, #meanings_continue_button").hide();
		$("#synonyms_back_button, #synonyms_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Synonyms","The words below are similar to " + "<strong>'" + $chosen_word_value + "'</strong>.");

		// Update the progress made
		progressBar(60);

		// Start the next activity, i.e. Synonyms, if not already started
		if ($("#synonyms_container").children().length == 0) {
			start_synonyms_activity($chosen_word_value);
		};

		// If all words have been clicked on, show the synonyms continue button
		if ($synonym_circle_activity_boolean) {
			$("#synonyms_continue_button").show();
		};
	});

	$("#synonyms_continue_button").click(function(){

		// Show and hide buttons
		$("#synonyms_back_button, #synonyms_continue_button, #synonyms_container").hide();
		$("#antonyms_back_button, #antonyms_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Antonyms","The words below are opposite to " + "<strong>'" + $chosen_word_value + "'</strong>.");

		// Update the progress made
		progressBar(75);

		// Start the next activity, i.e. Synonyms, if not already started
		if ($("#antonyms_container").children().length == 0) {
			start_antonyms_activity($chosen_word_value);
		};

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
		display_activity_instruction("Checkpoint!","Is <strong>'" + $chosen_word_value + "'</strong> a synonym or antonym to:");

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
		$("#real_world_examples_back_button, #real_world_examples_continue_button, #real_world_examples_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Real-World Examples","See how <strong>'" + $chosen_word_value + "'</strong> has been used in everyday life.");

		// Update the progress made
		progressBar(90);

		// Start the next activity, i.e. Real World Examples, if not already started
		if ($("#real_world_examples_container").children().length == 0) {
			start_real_world_examples_activity($chosen_word_value);
		};

		// If all words have been clicked on, show the real world examples container
		if ($rwe_circle_activity_boolean) {
			$("#real_world_examples_continue_button").show();
		}

	});

	$("#real_world_examples_continue_button").click(function(){

		// Show and hide buttons
		$("#real_world_examples_back_button, #real_world_examples_continue_button, #real_world_examples_container, #level_1_details").hide();
		$("#review_level_one_back_button, #review_level_one_continue_button, #review_level_one_container").show("fade");

		// Update the progress made
		progressBar(100);

		// Start the next activity, i.e. review level one
		start_review_level_one_activity($chosen_word_value);

	});

	/**
	 * Handle the back buttons
	 */

	// If the user wants to start over with a different word
	$("#restart_back_button").click(function(){
		location.reload();
	})

	// If the user wants to return to the spell the word activity
	$("#fill_in_the_blank_back_button").click(function(){
		$("#spell_the_word_form").show();

		// Show and hide buttons
		hide_and_show_button("#fill_in_the_blank_container, #fill_in_the_blank_back_button, #fill_in_the_blank_continue_button, #fill_in_the_blank_game_over_message", "#spell_the_word_continue_button, #restart_back_button");

		// Empty the different letter arrays
		$alphabet_random_letters_array = [];
		$merged_letters_array = [];

		// Update the activity name and instruction
		display_activity_instruction("Spelling","Type the word below:");

		// If clicking back after losing or not doing anything
		if ($fill_in_the_blank_incorrect_count == 3 || !$fill_in_the_blank_game_won) {
			// Reset the array values back to normal
			$chosen_word_each_letter_array = [];
			for (var i = 0; i < $chosen_word_value.length; i++) {
				$chosen_word_each_letter_array.push($chosen_word_value[i]);
			}

			$("#chosen_word_header_container").html($chosen_word_value);

			$alphabet_random_letters_array = [];
			$merged_letters_array = [];

			// Empty the different letter arrays
			$(".fill_in_the_blank_letters").remove();

			// Reset the incorrect count
			$fill_in_the_blank_incorrect_count = 0;
		}

		// Return the progress back to 0
		progressBar(0);
	});

	// If the user wants to return to the fill in the blank activity
	$("#pronunciation_back_button").click(function(){
		// Show and hide buttons
		$("#pronunciation_back_button, #pronunciation_continue_button, #pronunciation_container").hide();
		$("#fill_in_the_blank_continue_button, #fill_in_the_blank_back_button, #fill_in_the_blank_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Checkpoint!","Spell the word in order.");

		// Return the progress back to 0
		progressBar(15);
	});

	// If the user wants to return to the pronunciation activity
	$("#meanings_back_button").click(function(){
		// Show and hide buttons
		$("#meanings_back_button, #meanings_continue_button, #meanings_container").hide();
		$("#pronunciation_back_button, #pronunciation_continue_button, #pronunciation_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Pronunciation","Say <strong>'" + $chosen_word_value + "'</strong> aloud and then hit the mic.");

		// Return the progress back to 0
		progressBar(30);
	});

	// If the user wants to return to the pronunciation activity
	$("#synonyms_back_button").click(function(){
		// Show and hide buttons
		$("#synonyms_back_button, #synonyms_continue_button, #synonyms_container").hide();
		$("#meanings_back_button, #meanings_continue_button, #meanings_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Meanings","<strong>'" + $chosen_word_value + "'</strong> can have different meanings depending on how you use it.");

		// Return the progress back to 0
		progressBar(30);
	});

	// If the user wants to return to the synonyms activity
	$("#antonyms_back_button").click(function(){

		// Show and hide buttons
		$("#synonyms_back_button, #synonyms_continue_button, #synonyms_container").show();
		$("#antonyms_back_button, #antonyms_continue_button, #antonyms_container").hide();

		// Update the activity name and instruction
		display_activity_instruction("Synonyms","The words below are similar to <strong>'" + $chosen_word_value + "'</strong>.");

		// Return the progress back to 0
		progressBar(45);
	});

	// If the user wants to return to the antonyms activity
	$("#syn_ant_checkpoint_back_button").click(function(){

		// Show and hide buttons
		$("#syn_ant_checkpoint_back_button, #syn_ant_checkpoint_continue_button, #syn_ant_checkpoint_container, #syn_ant_checkpoint_score_div").hide();
		$("#antonyms_back_button, #antonyms_continue_button, #antonyms_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Antonyms","The words below are opposite to <strong>'" + $chosen_word_value + "'</strong>.");

		// Return the progress back to 0
		progressBar(60);

	});

	// If the user wants to return to the synonyms / antonyms checkpoint activity
	$("#real_world_examples_back_button").click(function(){

		// Show and hide buttons
		$("#syn_ant_checkpoint_back_button, #syn_ant_checkpoint_continue_button, #syn_ant_checkpoint_container, #syn_ant_checkpoint_score_div").show();
		$("#real_world_examples_back_button, #real_world_examples_continue_button, #real_world_examples_container").hide();

		// Update the activity name and instruction
		display_activity_instruction("Checkpoint!","Is <strong>'" + $chosen_word_value + "'</strong> a synonym or antonym to:");

		// Return the progress back to 0
		progressBar(75);

		//Checks if there are any synonyms or antonyms. If not, display a message and show the continue button
		$(".no_word_info").remove();
		if ($shuffled_syn_ant_array.length == 0) {
			var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
			var $message = "&#9785; We don't have any synonyms or antonyms to do a checkpoint. Please tap continue.";
			$("#syn_ant_checkpoint_container").append($no_word_info_container);
			$($no_word_info_container).append($message);
			$("#syn_ant_checkpoint_continue_button").show("fade");
		}

	});

	// If the user wants to return to the real world examples activity
	$("#review_level_one_back_button").click(function(){

		// Show and hide buttons
		$("#review_level_one_back_button, #review_level_one_continue_button, #review_level_one_container").hide();
		$("#real_world_examples_back_button, #real_world_examples_continue_button, #real_world_examples_container").show();

		// Update the activity name and instruction
		display_activity_instruction("Real-World Examples","See how <strong>'" + $chosen_word_value + "'</strong> has been used in everyday life.");

		// Return the progress back to 0
		progressBar(90);

	});

	/**
	 * Starter Functions: Main ones that initiate each activity
	 */

	// Start Level 1 with the spelling activity
	function spell_chosen_word() {
		// Create an array of all the substrings leading up to the entire chosen word
		for (var i = 1; i < $chosen_word_value.length+1; i++) {
			$chosen_word_substring = $chosen_word_value.substr(0,i);
			$chosen_word_substring_array.push($chosen_word_substring);
		}

		$("#spell_the_word").on('input', function(){
			$word_being_spelled = $.trim($(this).val().toLowerCase());

			if ($word_being_spelled == $chosen_word_value) {
				$("#spell_the_word_continue_button").show("fade");
				boost_goodies(300);
			} else {
				$("#spell_the_word_continue_button").hide("fade");
				reset_goodies(0);
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
			$each_letter_fill_in_the_blank_div = $("<div>", {class: "col-xs-4 col-sm-3 text-center fill_in_the_blank_letters pointer"} );
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
				$("#chosen_word_header_container").html($fill_in_the_blank_correctly_spelled_word);

				// Remove the first element in the chosen word letters array
				$chosen_word_each_letter_array.shift();

			// If the tapped letter is incorrect
			} else {
				$fill_in_the_blank_incorrect_count++;
			}

			if ($chosen_word_each_letter_array.length == 0) {
				$("#fill_in_the_blank_continue_button").show("fade");
				$(".fill_in_the_blank_letters").hide();
				$fill_in_the_blank_game_won = true;
				boost_goodies(600);
			} else {
				$("#fill_in_the_blank_continue_button").hide("fade");
				reset_goodies(300);
			}

			if ($fill_in_the_blank_incorrect_count == 3) {
				// Hide the letters
				$(".fill_in_the_blank_letters").hide("fade");

				// Show a message for them to look at the spelling again
				$("#fill_in_the_blank_game_over_message").show("fade");

				$fill_in_the_blank_game_won = false;
			}
		});
	};

	// Start the meanings activity
	function start_meanings_activity(chosen_word_value) {
		for (var index = 0; index < 1; index++) {
			// Create a row for the circle and POSs
			$meaning_row = $("<div>", { class: "meaning_row pointer",
																	type: "button",
																	'data-toggle': "collapse",
																	'data-target': "#def"+index,
																	'aria-expanded': "false",
																	'aria-controls': index
																}
											);
			$meaning_circle_div = $("<div>", {class: "red_circle inline-block"} );
			$meaning_part_of_speech_div = $("<div>", { class: "meaning_pos_container lead pointer inline-block" } );
			// Add the individual row to the meanings container
			$("#meanings_container").append($meaning_row);
			// Add the circle and meaning div to the meaning row
			$($meaning_row).append($meaning_circle_div, $meaning_part_of_speech_div);
			// Add the part of speech to which the meaning will be under so it can be displayed
			$meaning_pos_collapse_header = $(".word-part-of-speech").html();
			$($meaning_part_of_speech_div).append("as a(n) "+"<span class='red'>"+$meaning_pos_collapse_header+"</span>"+"...");

			//Create the containter that displays the meanings, which is the collapsible-content
			$meanings_container = $("<div>", {class: "meanings_container well lead collapse", id: "def"+index} );
			$("#meanings_container").append($meanings_container);

			// meaning divs and text to display
			$meaning_div = $("<div>", {class: "meaning_container"} );
			$meanings_container.append($meaning_div);
			$meaning_div.append("&#8605; " + $(".word-definition").html());
			// end of xml_pos loop to get all defs
		} // end of the POS for loop

		// CODE BELOW IS OUTSIDE THE XML.FIND.EACH FUNCTION

		// Click anywhere (row, circle, or word) to change element features
		$(".meaning_row").click(function(){
			// Fill in the circle
			$(this).children(":first").addClass("red_circle_background");

			// If all words have been clicked on, show the continue button
			if ($("#meanings_container .red_circle_background").length == $(".meaning_row").length) {
				$("#meanings_continue_button").show("fade");
				$meaning_circle_activity_boolean = true;
				boost_goodies(1200);
			};
		}); // end of the $meaning_row .click fn

		//Checks if there are any meanings. If not, display a message and show the continue button
		$(".no_word_info").remove();
		if ($(".word-definition") == "") {
			var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
			var $message = "&#9785; We don't have any meanings to show. Please tap continue.";
			$("#meanings_container").append($no_word_info_container);
			$($no_word_info_container).append($message);
			$("#meanings_continue_button").show("fade");
		}
	}; // end of the start meanings activity function

	// Start the synonyms activity
	function start_synonyms_activity(chosen_word_value) {
		// Read the XML file
		$.ajax({
			type: "GET",
			url: "dictionary.xml",
			dataType: "xml",
			success: function (xml) {
				$(xml).find(chosen_word_value).children().find('synonym').each(function(index){
					// Get the actual word
					$xml_similar_word = $(this).text();
					// Create a row for the circle and word itself
					$synonym_row = $("<div>", {class: "synonym_row pointer", type: "button", 'data-toggle': "collapse", 'data-target': "#syn"+index, 'aria-expanded': "false", 'aria-controls': index } );
					$synonym_circle_div = $("<div>", {class: "red_circle inline-block"} );
					$synonym_word_div = $("<div>", {class: "synonym_word_container lead pointer inline-block"} );
					// Add the individual row to the synonyms container
					$("#synonyms_container").append($synonym_row);
					// Add the circle and word div to the synonym row
					$($synonym_row).append($synonym_circle_div, $synonym_word_div);
					// Add the word itself to the word div so it can be displayed
					$($synonym_word_div).append($xml_similar_word);

					// Create word details containter (inclues pro, pos, and meanings), which is the collapsible-content
					$word_details_container = $("<div>", {class: "word_details_container well lead collapse", id: "syn"+index} );
					$("#synonyms_container").append($word_details_container);

					$pronunciation_div = $("<div>", {class: "pronunciation_container inline-block lead"} );
					$($word_details_container).append($pronunciation_div);
					$xml_pronunciation = $(xml).find($xml_similar_word).children(":first-child").text();
					$($pronunciation_div).append($xml_pronunciation);

					// If there is info for the clicked word, remove any existing details and display the
					// Pronunciation, Part of speech, and Meaning(s)
					$xml_part_of_speech_elements = $(xml).find($xml_similar_word).children("part_of_speech");

					// If there isn't any info for the clicked word, display a sorry message [LOOK INTO THIS]
					for (var i = 0; i < $xml_part_of_speech_elements.length; i++) {
						// part of speech divs and text to display
						$part_of_speech_div = $("<div>", {class: "part_of_speech_container"} );
						$word_details_container.append($part_of_speech_div);
						$part_of_speech_div.append($($xml_part_of_speech_elements[i]).attr("type"));

						// meaning divs and text to display
						$meaning_div = $("<div>", {class: "meaning_container"} );
						$word_details_container.append($meaning_div);
						$meaning_div.append("&#8605; " + $($xml_part_of_speech_elements[i]).find("meaning").text());
					}
				}); //end of the original .each loop

				// CODE BELOW IS OUTSIDE THE XML.FIND.EACH FUNCTION


				// Click anywhere (row, circle, or word) to change element features
				$(".synonym_row").click(function(){
					// Fill in the circle
					$(this).children(":first").addClass("red_circle_background");
					// See if the synonym exists in the xml file to display its details
					if ($(xml).find($(this).children(":last").text()).length == 0) {

						$(this).next().children(":first").remove();
						var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
						var $message = "&#9785; Aww man, there's no info for this word yet.";
						if ($(this).next().find(".no_word_info").length < 1) {
							$(this).next().append($no_word_info_container);
							$($no_word_info_container).append($message);
						}
					}

					// If all words have been clicked on, show the continue button
					if ($("#synonyms_container .red_circle_background").length == $(".synonym_row").length) {
						$("#synonyms_continue_button").show("fade");
						$synonym_circle_activity_boolean = true;
						boost_goodies(1500);
					};
				}); // end of the $synonym_row .click fn

				//Checks if there are any synonyms. If not, display a message and show the continue button
				$(".no_word_info").remove();
				if ($(xml).find($chosen_word_value).children().find('synonym').length == 0) {
					var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
					var $message = "&#9785; We don't have any synonyms to show. Please tap continue.";
					$("#synonyms_container").append($no_word_info_container);
					$($no_word_info_container).append($message);
					$("#synonyms_continue_button").show("fade");
				}
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	}; // end of the start synonyms activity function

	// Start the antonyms activity
	function start_antonyms_activity(chosen_word_value) {
		// Read the XML file
		$.ajax({
			type: "GET",
			url: "dictionary.xml",
			dataType: "xml",
			success: function (xml) {
				$(xml).find(chosen_word_value).children().find('antonym').each(function(index){
					// Get the actual word
					$xml_similar_word = $(this).text();
					// Create a row for the circle and word itself
					$antonym_row = $("<div>", {class: "antonym_row pointer", type: "button", 'data-toggle': "collapse", 'data-target': "#ant"+index, 'aria-expanded': "false", 'aria-controls': index } );
					$antonym_circle_div = $("<div>", {class: "red_circle inline-block"} );
					$antonym_word_div = $("<div>", {class: "antonym_word_container lead pointer inline-block"} );
					// Add the individual row to the antonyms container
					$("#antonyms_container").append($antonym_row);
					// Add the circle and word div to the antonym row
					$($antonym_row).append($antonym_circle_div, $antonym_word_div);
					// Add the word itself to the word div so it can be displayed
					$($antonym_word_div).append($xml_similar_word);

					// Create word details containter (inclues pro, pos, and meanings), which is the collapsible-content
					$word_details_container = $("<div>", {class: "word_details_container well lead collapse", id: "ant"+index} );
					$("#antonyms_container").append($word_details_container);

					$pronunciation_div = $("<div>", {class: "pronunciation_container inline-block lead"} );
					$($word_details_container).append($pronunciation_div);
					$xml_pronunciation = $(xml).find($xml_similar_word).children(":first-child").text();
					$($pronunciation_div).append($xml_pronunciation);

					// If there is info for the clicked word, remove any existing details and display the
					// Pronunciation, Part of speech, and Meaning(s)
					$xml_part_of_speech_elements = $(xml).find($xml_similar_word).children("part_of_speech");

					// If there isn't any info for the clicked word, display a sorry message [LOOK INTO THIS]
					for (var i = 0; i < $xml_part_of_speech_elements.length; i++) {
						// part of speech divs and text to display
						$part_of_speech_div = $("<div>", {class: "part_of_speech_container"} );
						$word_details_container.append($part_of_speech_div);
						$part_of_speech_div.append($($xml_part_of_speech_elements[i]).attr("type"));

						// meaning divs and text to display
						$meaning_div = $("<div>", {class: "meaning_container"} );
						$word_details_container.append($meaning_div);
						$meaning_div.append("&#8605; " + $($xml_part_of_speech_elements[i]).find("meaning").text());
					}
				}); //end of the original .each loop

				// CODE BELOW IS OUTSIDE THE XML.FIND.EACH FUNCTION

				// Click anywhere (row, circle, or word) to change element features
				$(".antonym_row").click(function(){
					// Fill in the circle
					$(this).children(":first").addClass("red_circle_background");
					// See if the antonym exists in the xml file to display its details
					if ($(xml).find($(this).children(":last").text()).length == 0) {

						$(this).next().children(":first").remove();
						var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
						var $message = "&#9785; Aww man, there's no info for this word yet.";
						if ($(this).next().find(".no_word_info").length < 1) {
							$(this).next().append($no_word_info_container);
							$($no_word_info_container).append($message);
						}
					}

					// If all words have been clicked on, show the continue button
					if ($("#antonyms_container .red_circle_background").length == $(".antonym_row").length) {
						$("#antonyms_continue_button").show("fade");
						$antonym_circle_activity_boolean = true;
						boost_goodies(1800);
					};
				}); // end of the $antonym_row .click fn

				//Checks if there are any antonyms. If not, display a message and show the continue button
				$(".no_word_info").remove();
				if ($(xml).find($chosen_word_value).children().find('antonym').length == 0) {
					var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
					var $message = "&#9785; We don't have any antonyms to show. Please tap continue.";
					$("#antonyms_container").append($no_word_info_container);
					$($no_word_info_container).append($message);
					$("#antonyms_continue_button").show("fade");
				}
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	}; // end of the start antonyms activity function

	// Start the synonyms / antonyms checkpoint activity
	function start_syn_ant_checkpoint_activity(chosen_word_value) {

		// Read the XML file
		$.ajax({
			type: "GET",
			url: "dictionary.xml",
			dataType: "xml",
			success: function (xml) {

				// Create a score counter:  0 / X
				$syn_ant_checkpoint_score_div = $("<div>", { id: "syn_ant_checkpoint_score_div", align: "right" } );
				$($syn_ant_checkpoint_score_div).insertBefore("#syn_ant_checkpoint_container");

				// Find all of the synonyms for this word and add to the antonym array
				$(xml).find(chosen_word_value).children().find('synonym').each(function(index){
					$syn_ant_checkpoint_synonyms_array.push($(this).text());
				});

				// Find all of the antonyms for this word and add to the antonym array
				$(xml).find(chosen_word_value).children().find('antonym').each(function(index){
					$syn_ant_checkpoint_antonyms_array.push($(this).text());
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
																		  class: "btn btn-lg btn-danger btn-block syn_ant_checkpoint_btns",
																		  id: "syn_ant_checkpoint_synonym_button"
																	  }
														 );
					$syn_ant_checkpoint_antonym_button = $("<button/>", { type: "button",
																		  text: "antonym",
																		  class: "btn btn-lg btn-danger btn-block syn_ant_checkpoint_btns",
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
					var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
					var $message = "&#9785; We don't have any synonyms or antonyms to do a checkpoint. Please tap continue.";
					$("#syn_ant_checkpoint_container").append($no_word_info_container);
					$($no_word_info_container).append($message);
					$("#syn_ant_checkpoint_continue_button").show("fade");
					boost_goodies(2100);
				}
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	};

	// Start the real world examples activity
	function start_real_world_examples_activity(chosen_word_value) {
		// Read the XML file
		$.ajax({
			type: "GET",
			url: "dictionary.xml",
			dataType: "xml",
			success: function (xml) {

				// Find how mnay Real World examples there are and create a row for each one
				$xml_part_of_speech_elements = $(xml).find(chosen_word_value).find("sentence[type='real world example']");
				for (var index = 0; index < $xml_part_of_speech_elements.length; index++) {
					// Create a row for the circle and rwe
					$rwe_row = $("<div>", {class: "rwe_row pointer", type: "button", 'data-toggle': "collapse", 'data-target': "#rwe"+index, 'aria-expanded': "false", 'aria-controls': index } );
					$rwe_circle_div = $("<div>", {class: "red_circle inline-block"} );
					$rwe_source_div = $("<div>", {class: "rwe_source_container lead pointer inline-block"} );
					// Add the individual row to the rwe container
					$("#real_world_examples_container").append($rwe_row);
					// Add the circle and rwe div to the rwe row
					$($rwe_row).append($rwe_circle_div, $rwe_source_div);
					// Add the rwe to which the meaning will be under so it can be displayed
					$rwe_collapse_header = $($xml_part_of_speech_elements[index]).attr("source");
					$($rwe_source_div).append($rwe_collapse_header);

					//Create the containter that displays the rwe, which is the collapsible-content
					$rwe_container = $("<div>", {class: "rwe_container well lead collapse", id: "rwe"+index} );
					$("#real_world_examples_container").append($rwe_container);

					// rwe divs and text to display
		            $($xml_part_of_speech_elements[index]).each(function() {
						$rwe_div = $("<div>", {class: "rwe_content_container"} );
						$rwe_container.append($rwe_div);
						$rwe_div.append("&#9997; " + $(this).text());
					}); // end of xml_pos loop to get all rwe
				} // end of the POS for loop

				// CODE BELOW IS OUTSIDE THE XML.FIND.EACH FUNCTION

				// Click anywhere (row, circle, or word) to change element features
				$(".rwe_row").click(function(){
					// Fill in the circle
					$(this).children(":first").addClass("red_circle_background");

					// If all words have been clicked on, show the continue button
					if ($("#real_world_examples_container .red_circle_background").length == $(".rwe_row").length) {
						$("#rwe_continue_button").show("fade");
						$rwe_circle_activity_boolean = true;
						boost_goodies(2400);
					};
				}); // end of the $meaning_row .click fn

				//Checks if there are any meanings. If not, display a message and show the continue button
				$(".no_word_info").remove();
				if ($(xml).find($chosen_word_value).children().find("sentence[type='real world example']").length == 0) {
					var $no_word_info_container = $("<div>", {class: "no_word_info lead text-danger"} );
					var $message = "&#9785; We don't have any real world examples to show. Please tap continue.";
					$("#rwe_content_container").append($no_word_info_container);
					$($no_word_info_container).append($message);
					$("#real_world_examples_continue_button").show("fade");
				}
			} // end of the success parameter in the ajax fn
		}); // end of the ajax function
	};

	// Start the review level one activity
	function start_review_level_one_activity(chosen_word_value) {
		$("#review_level_one_back_button").hide();
		$("#goodies, #progress_bar_container").css("visibility","hidden");
		$("#all_levels_button").show();
		$("#level_congrats_text").append("<strong>'" + $chosen_word_value + "'</strong> ");
		$("#goodies_total").html($new_goodies_total);
	};

	/**
	 * Helper Functions: Support ones that help each activity above
	 */

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
				.show("fade")
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
				$(".syn_ant_row").show("fade");

				// Show the continue button
				$("#syn_ant_checkpoint_continue_button").show("fade");

				boost_goodies(2400);
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
	function randomRange (x,y) {
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
