$(document).ready(function() {
	// General
	var $chosen_word_id = $(".palabra-id").html();
	var $regex = /^[a-zA-Z. ]+$/;
	var $new_goodies_total = 0;
  var $time_game_started;
	// Spell the word
	var $word_being_spelled;
	var $chosen_word_substring;
	var $chosen_word_substring_array = [];
	// Fill in the blank
	var $each_life_span;
	var	$each_letter_div;
	var	$each_random_letter_fill_in_the_blank_array;
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
	// Meanings
	var $meanings_container;
	// Meanings Checkpoint
	var countdown_id;
	var meanings_score = 0;
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
	// Real World Examples
	var $rwe_row;
	var $rwe_circle_div;
	var $rwe_source_div;
	var $rwe_collapse_header = "";
	var $rwe_container;
	var $rwe_circle_activity_boolean = false;

	if ($chosen_word_id != undefined) {
		set_the_stage();
	}

	function get_game_words() {
		return $.get(
			"/fundamentals?word_id=" + $chosen_word_id, function() {}, "json"
		);
	};

  function set_the_stage() {
		get_game_words().done(function(response) {
			var words = response.words;
			var chosen_word = words[0];
			var chosen_word_name = chosen_word.name

			start_activity(chosen_word_name);
			fill_in_the_blank_back_button(chosen_word);
			spell_the_word_continue_button(chosen_word);
			fill_in_the_blank_continue_button(chosen_word);
			meanings_continue_button(words);
			meanings_checkpoint_continue_button(chosen_word_name);
			synonyms_continue_button(chosen_word_name);
			antonyms_continue_button(chosen_word_name);
			syn_ant_checkpoint_continue_button(chosen_word_name);
			real_world_examples_continue_button(chosen_word_name);
		});
  }

  function start_activity(chosen_word_name) {
    if ($("#game-started-bool").hasClass("begin-timer")) {
			$("#progress_bar_container").hide().fadeIn();
			$("#level_1_details").hide().fadeIn();
			$("#spell_the_word_form").hide().fadeIn();

      display_instruction("Type this word:");

      $("#chosen-word-header-container").html(chosen_word_name);

      spell_chosen_word(chosen_word_name);

      update_progress_bar(0);

      $time_game_started = new Date();
    }
  }

  function fill_in_the_blank_back_button(word) {
		var chosen_word_name = word.name;
		var chosen_word_letters = chosen_word_name.split('');

    $("#fill_in_the_blank_back_button").click(function() {
      $("#spell_the_word_form").show();
      $(".checkpoint-image").hide();
      $("#fill_in_the_blank_container").hide();
      $("#fill_in_the_blank_back_button").hide();
      $("#fill_in_the_blank_continue_button").hide();
      $("#fill_in_the_blank_game_over_message").hide();
      $("#spell_the_word_continue_button").fadeIn();
      $("#restart_back_button").fadeIn();

      $alphabet_random_letters_array = [];
      $merged_letters_array = [];

      display_instruction("Type the word below:");

      if ($fill_in_the_blank_incorrect_count == 3) {
        chosen_word_letters = [];

        for (var i = 0; i < $chosen_word_name.length; i++) {
          chosen_word_letters.push(chosen_word_name[i]);
	      }

    		$("#chosen_word_header_container").html(chosen_word_name);

    		$alphabet_random_letters_array = [];
    		$merged_letters_array = [];

    		$(".fitb-letter").remove();
    		$fill_in_the_blank_incorrect_count = 0;
      }

      update_progress_bar(0);
   });
  }

  /***
	*
	*
	* CONTINUE BUTTONS
	*
	*
	***/

  function spell_the_word_continue_button(word) {
    $("#spell_the_word_continue_button").click(function(event) {
			var chosen_word_name = word.name;
			var chosen_word_letters = chosen_word_name.split('');

      $("#spell_the_word_form").hide();
      $(".checkpoint-image").show();
      $("#restart_back_button").hide();
      $("#spell_the_word_continue_button").hide();
      $("#fill_in_the_blank_back_button").fadeIn();

      display_instruction("Tap the letters to spell this word:");

      update_progress_bar(15);

      if ($fill_in_the_blank_game_won) {
        $alphabet_random_letters_array = [];
        $merged_letters_array = [];
        $("#fill_in_the_blank_container").show();
        $("#fill_in_the_blank_continue_button").show();
      } else {
        $alphabet_random_letters_array = [];
        $merged_letters_array = [];
        $fill_in_the_blank_correctly_spelled_word = "";

        start_fill_in_the_blank_checkpoint_activity(chosen_word_letters);
      }
    });
  }

  function fill_in_the_blank_continue_button(word) {
    $("#fill_in_the_blank_continue_button").click(function() {
			var part_of_speech = $("#word-part-of-speech").html();

      $(".checkpoint-image").hide();
      $("#fill_in_the_blank_back_button").hide();
      $("#fill_in_the_blank_continue_button").hide();
      $("#fill_in_the_blank_container").hide();
      $("#pronunciation_back_button").show();
      $("#pronunciation_container").show();
      $("#chosen-word-header-container").hide();
      $("#meanings_back_button, #meanings_container").show();

			display_instruction(
				"As a(n) " + part_of_speech +
        ", read the meaning(s) for <strong>'" + word.name +
        "'</strong>."
      )

      update_progress_bar(45);

      start_meanings_activity();
    });
  }

  function meanings_continue_button(words) {
    $("#meanings_continue_button").click(function() {
      $("#meanings_back_button").hide();
      $("#meanings_container").hide();
      $("#meanings_continue_button").hide();

			start_meanings_checkpoint_activity(words);
    });
  }

	function meanings_checkpoint_continue_button(chosen_word_name) {
		$("#meanings_checkpoint_continue_button").click(function () {
			$("#meanings-checkpoint-container").hide();
			$("#meanings_checkpoint_continue_button").hide();

			if (!$("#synonym_no_results").hasClass("please-tap-continue")) {
				$("#synonyms_back_button").show();
				$("#synonyms_container").show();

				display_instruction(
					"The words below are similar to " +
					"<strong>'" +
					chosen_word_name +
					"'</strong>. Tap and view each one."
				);

				update_progress_bar(60);

				start_synonyms_activity(chosen_word_name);
			} else if (
				$("#synonym_no_results").hasClass("please-tap-continue") &&
				!$("#antonym_no_results").hasClass("please-tap-continue")
			) {

				$("#synonyms_back_button").hide();
				$("#synonyms_continue_button").hide();
				$("#synonyms_container").hide();
				$("#antonyms_container").show();
				$("#antonyms_back_button").show();

				display_instruction(
					"The words below are opposite to " + "<strong>'" +
					chosen_word_name + "'</strong>. Tap and view each one."
				);

				update_progress_bar(75);

				start_antonyms_activity(chosen_word_name);
			}	else if (
				$("#synonym_no_results").hasClass("please-tap-continue") &&
				$("#antonym_no_results").hasClass("please-tap-continue") &&
				$("#rwe_no_results").hasClass("please-tap-continue")
			) {
				$("#real_world_examples_back_button").hide();
				$("#real_world_examples_continue_button").hide();
				$("#real_world_examples_container").hide();
				$("#level_1_details").hide();
				$("#review_level_one_back_button").fadeIn();
				$("#review_level_one_continue_button").fadeIn();
				$("#review_level_one_container").fadeIn();

				update_user_word_games_completed();

				update_progress_bar(100);

				update_user_points(10);
				boost_goodies(3);

				update_num_played();

				start_review_level_one_activity(chosen_word_name);
			} else if (
				$("#synonym_no_results").hasClass("please-tap-continue") &&
				$("#antonym_no_results").hasClass("please-tap-continue")
			) {

				$("#real_world_examples_back_button").show();
				$("#real_world_examples_container").show();

				display_instruction(
					"Tap each source to see how <strong>'" +
					chosen_word_name +
					"'</strong> has been used in everyday life."
				);

				update_progress_bar(90);

				start_real_world_examples_activity(chosen_word_name);
			}
		});
	}

  function synonyms_continue_button(chosen_word_name) {
    $("#synonyms_continue_button").click(function(){
      // Start the next activity --> if there are synonyms, but no antonyms
      if ($("#antonym_no_results").hasClass("please-tap-continue")) {
        $("#syn_ant_checkpoint_back_button").show();
        $("#syn_ant_checkpoint_container").show();
				$(".checkpoint-image").show();
        $("#synonyms_continue_button").hide();
        $("#synonyms_container").hide();

        display_instruction(
					"Is <strong>'" +
					chosen_word_name +
          "'</strong> a synonym or antonym to:"
        );

        update_progress_bar(75);

        start_syn_ant_checkpoint_activity();

        // Start the next activity --> if there there are antonyms
      } else {
        $("#synonyms_back_button").hide();
        $("#synonyms_continue_button").hide();
        $("#synonyms_container").hide();
        $("#antonyms_back_button").show();
        $("#antonyms_container").show();

        display_instruction(
					"The words below are opposite to <strong>'" +
          chosen_word_name +
					"'</strong>. Tap and view each one."
        );

        update_progress_bar(75);

        start_antonyms_activity(chosen_word_name);
      }
    });
  }

  function antonyms_continue_button(chosen_word_name) {
    $("#antonyms_continue_button").click(function(){
      $("#syn_ant_checkpoint_back_button").show();
      $("#syn_ant_checkpoint_container").show();
			$(".checkpoint-image").show();
      $("#antonyms_continue_button").hide();
      $("#antonyms_container").hide();

      display_instruction(
				"Is <strong>'" +
				chosen_word_name +
        "'</strong> a synonym or antonym to:"
      );

      update_progress_bar(75);

			start_syn_ant_checkpoint_activity();
    });
  }

  function syn_ant_checkpoint_continue_button(chosen_word_name) {
    $("#syn_ant_checkpoint_continue_button").click(function(){
      $(".checkpoint-image").hide();
      $("#syn_ant_checkpoint_back_button").hide();
      $("#syn_ant_checkpoint_container").hide();
      $("#syn_ant_checkpoint_continue_button").hide();
      $("#syn_ant_checkpoint_score_div").hide();
      $("#real_world_examples_back_button").show();
      $("#real_world_examples_container").show();

      display_instruction(
				"Tap each source to see how <strong>'" +
        chosen_word_name +
				"'</strong> has been used in everyday life."
      );

      update_progress_bar(90);

      // If all words have been clicked on, show the RWE container
      if ($("#rwe_no_results").hasClass("please-tap-continue")) {
        $("#real_world_examples_back_button").hide();
        $("#real_world_examples_continue_button").hide();
        $("#real_world_examples_container").hide();
        $("#level_1_details").hide();
        $("#review_level_one_back_button").fadeIn();
        $("#review_level_one_continue_button").fadeIn();
        $("#review_level_one_container").fadeIn();

        update_user_word_games_completed();

        update_num_played();
        update_progress_bar(100);
        update_user_points(10);
        boost_goodies(10);

        start_review_level_one_activity(chosen_word_name);
      } else {
        start_real_world_examples_activity(chosen_word_name);
      }
    });
  }

  function real_world_examples_continue_button(chosen_word_name) {
    $("#real_world_examples_continue_button").click(function(){
      $("#real_world_examples_back_button").hide();
      $("#real_world_examples_continue_button").hide();
      $("#real_world_examples_container").hide();
      $("#level_1_details").hide();
      $("#review_level_one_back_button").fadeIn();
      $("#review_level_one_continue_button").fadeIn();
      $("#review_level_one_container").fadeIn();

			start_review_level_one_activity(chosen_word_name);
      update_user_word_games_completed();
      update_num_played();
      update_progress_bar(100);
      update_user_points(10);
    });
  }

	/***
	*
	*
	* FUNCTIONS FOR THE ACTIVITIES
	*
	*
	***/

	function spell_chosen_word(word) {
		$("#spell_the_word").focus();
		$("#spell_the_word").on('input', function(){
			$word_being_spelled = $.trim($(this).val().toLowerCase());

			if ($word_being_spelled == word) {
				$("#spell_the_word_continue_button").fadeIn();
			} else {
				$("#spell_the_word_continue_button").fadeOut();
			}
		});
	};

	function start_fill_in_the_blank_checkpoint_activity(chosen_word_letters) {
		$("#fill_in_the_blank_container").show();

		for (var i = 0; i < 3; i++) {
			$alphabet_random_letter = $alphabet_array[randomRange(26, 0)];
			$alphabet_random_letters_array.push($alphabet_random_letter);
		}

		$merged_letters_array = $.merge($.merge([], chosen_word_letters),
      $alphabet_random_letters_array
    );

		$merged_letters_array = shuffle_array($merged_letters_array);

		$.each($merged_letters_array, function(index, value){
			$each_letter_div = $("<div>", { class:
				"col-xs-4 col-sm-3 text-center " +
				"fitb-letter pointer letter_" +
				value
			});
			$("#fill_in_the_blank_container").append($each_letter_div);
			$($each_letter_div).append(value).html();
		});

		$(".fitb-letter").click(function() {
			$tapped_letter_div = $(this);
			$tapped_letter = $(this).text();

			// If the letter selected matches the letters, in order, of the chosen
			// word array, change the background and text color
			for (var i = 0; i < chosen_word_letters.length; i++) {
				var $first_letter = chosen_word_letters[0];
			}

			// If the tapped letter is correct
			if ($first_letter == $tapped_letter) {
				$tapped_letter_div.addClass("fitb-letter-correct animated tada");
				unbind_elem($tapped_letter_div).removeClass("pointer");

				$fill_in_the_blank_correctly_spelled_word += $tapped_letter;

				// Replace the underscore with the tapped letter
				$("#chosen-word-header-container").html(
          $fill_in_the_blank_correctly_spelled_word
        );

				chosen_word_letters.shift();

			// If the tapped letter is incorrect
			} else {
				$tapped_letter_div.addClass("animated shake");
				$fill_in_the_blank_incorrect_count++;
			}

			if (chosen_word_letters.length == 0) {
				unbind_elem(".fitb-letter");
				$(".fitb-letter").removeClass("pointer").addClass("fitb-letter-done");
				$("#fill_in_the_blank_continue_button").fadeIn();
				$fill_in_the_blank_game_won = true;
			} else {
				$("#fill_in_the_blank_continue_button").fadeOut();
			}

			if ($fill_in_the_blank_incorrect_count == 3) {
				$(".fitb-letter").fadeOut();
				$(".checkpoint-image").empty();
				$("#fill_in_the_blank_game_over_message").fadeIn();
				$fill_in_the_blank_game_won = false;
			}
		});
	};

	function start_meanings_activity() {
		$("#meanings_container, #meanings_continue_button").fadeIn();
	};

	function start_meanings_checkpoint_activity(words) {
		var chosen_word = words[0];
		var chosen_word_name = chosen_word.name;
		var dummy_words = words.slice(1, 4);
		var chosen_word_definitions = array_of_attributes(chosen_word.definition);
		var dummy_definitions = $.map(dummy_words, function(w) {
			return array_of_attributes(w.definition)
		}).slice(0, 2);
		var merged_definitions = $.merge(
			$.merge([], chosen_word_definitions),
			dummy_definitions
		);
		var shuffled_definitions = shuffle_array(merged_definitions);
		// The repeat must do with this, but I've tried making it global and still
		// the same result. Tried post and pre -fix incrememnts, too.
		var counter = 0;
		var num_definitions = shuffled_definitions.length;
		var seconds = meanings_chkpt_seconds();

		display_instruction(
			"Is the meaning below for <strong>'" +
			chosen_word_name +
			"'</strong>?"
		);
		display_timer($("#meanings-checkpoint-container"), seconds);
		create_yes_or_no_def_checkpoint_panel(shuffled_definitions[counter]);

		var $well = $(".def-chkpt-panel")[0];

		start_timer_countdown(
			seconds,
			counter,
			$well,
			chosen_word_definitions,
			shuffled_definitions
		);

		// perhaps remove this event handler outside this fn
		// perhaps remove counter and pop definitions
		$(".def-chkpt-btn").click(function() {
			var answer = $.trim($(this).text());
			var definition = $($well).text();

			counter++;

			clearInterval(countdown_id);

			check_answer(answer, chosen_word_definitions, definition, tally_score);

			if (counter != num_definitions) {
				start_timer_countdown(
					meanings_chkpt_seconds(),
					counter,
					$well,
					chosen_word_definitions,
					shuffled_definitions
				);
				display_next_meaning(counter, $well, shuffled_definitions);
			}

			if (counter == num_definitions) {
				var $m_c_c = $("#meanings-checkpoint-container");

				clearInterval(countdown_id);
				$(".def-chkpt-btn").css("background", "lightgray");
				$(".def-chkpt-btn").css("border-color", "lightgray");
				$(".def-chkpt-btn").prop("disabled", "true");
				$m_c_c.css("color", "#E0E0E0");
				$m_c_c.find("i").css("color", "#F2F2F2");
				$("#timer_container").css("color", "#E0E0E0");
				$("#meanings_checkpoint_continue_button").fadeIn();
			}
		});
	};

	function start_synonyms_activity() {
		if ($("#synonym_no_results").hasClass("please-tap-continue")) {
			$("#synonyms_continue_button").fadeIn();
			$synonym_circle_activity_boolean = true;
		} else {
			// Click anywhere (row, circle, or word) to change element features
			$(".synonym_row").click(function(){
				// Fill in the circle
				$(this).children(":first").addClass("green-circle-background");
				// If all words have been clicked on, show the continue button
				if ($("#synonyms_container .green-circle-background").length ==
            $(".synonym_row").length
          ) {
					// scroll_to_bottom();
					$("#synonyms_continue_button").fadeIn();
					$synonym_circle_activity_boolean = true;
				};
			}); // end of the $synonym_row .click fn
		}
	}; // end of the start synonyms activity function

	function start_antonyms_activity() {
		if ($("#antonym_no_results").hasClass("please-tap-continue")) {
			$("#antonyms_continue_button").fadeIn();
			$antonym_circle_activity_boolean = true;
		} else {
			// Click anywhere (row, circle, or word) to change element features
			$(".antonym_row").click(function(){
				// Fill in the circle
				$(this).children(":first").addClass("green-circle-background");
				// If all words have been clicked on, show the continue button
				if ($("#antonyms_container .green-circle-background").length ==
            $(".antonym_row").length
        ) {
					$("#antonyms_continue_button").fadeIn();
					$antonym_circle_activity_boolean = true;
				};
			}); // end of the $antonym_row .click fn
		}
	}; // end of the start antonyms activity function

	function start_syn_ant_checkpoint_activity() {
		// Create a score counter:  0 / X
		$syn_ant_checkpoint_score_div = $("<div>", {
			id: "syn_ant_checkpoint_score_div",
			class: "pull-right" }
		);
		$($syn_ant_checkpoint_score_div).insertBefore(
			"#syn_ant_checkpoint_container"
		);

		// Find all of the synonyms for this word and add to the synonyms array
		$(".synonym_word_container").each(function(index){
			$syn_ant_checkpoint_synonyms_array.push($(this).html());
		});

		// Find all of the antonyms for this word and add to the antonyms array
		$(".antonym_word_container").each(function(index){
			$syn_ant_checkpoint_antonyms_array.push($(this).html());
		});

		// Display the number correct out of the total number of synonyms and
		// antonyms available
		$("#syn_ant_checkpoint_score_div").html(
			$syn_ant_checkpoint_correct_score +
			" / " +
			$shuffled_syn_ant_array.length
		).show();

		// Merge the synonym and antonym arrays above and then randomize the order
		$shuffled_syn_ant_array = $.merge($.merge(
			[], $syn_ant_checkpoint_synonyms_array
		), $syn_ant_checkpoint_antonyms_array);
		$shuffled_syn_ant_array = shuffle_array($shuffled_syn_ant_array);

		// Display the synonyms and antonyms for this word
		for (var i = 0; i < $shuffled_syn_ant_array.length; i++) {
			// Create a row for the circle and word itself
			$syn_ant_row = $("<div>", { class: "syn_ant_row" } );
			$syn_ant_circle_div = $("<div>", {
				class: "syn_ant_checkpoint_red_circle inline-block"
			});
			$syn_ant_word_div = $("<div>", {
				class: "syn_ant_word_container lead inline-block"
			});

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
		$(".syn_ant_word_container:first").addClass(
			"current_syn_ant_checkpoint_word"
		);

		// Create the synonym and antonym button
		$syn_ant_checkpoint_synonym_button_div = $("<div>", {
			class: "col-xs-6",
			id: "syn_ant_checkpoint_synonym_button_div"
		});

		$syn_ant_checkpoint_antonym_button_div = $("<div>", {
			class: "col-xs-6",
			id: "syn_ant_checkpoint_antonym_button_div"
		});

		$syn_ant_checkpoint_synonym_button = $("<button/>", {
			type: "button",
			text: "SYNONYM",
			class: "btn btn-lg btn-info btn-block syn_ant_checkpoint_btns",
			id: "syn_ant_checkpoint_synonym_button"
		});

		$syn_ant_checkpoint_antonym_button = $("<button/>", {
			type: "button",
			text: "ANTONYM",
			class: "btn btn-lg btn-info btn-block syn_ant_checkpoint_btns",
			id: "syn_ant_checkpoint_antonym_button"
		});

		$("#syn_ant_checkpoint_container").append(
			$syn_ant_checkpoint_synonym_button_div,
			$syn_ant_checkpoint_antonym_button_div
		);

		$($syn_ant_checkpoint_synonym_button_div).append(
			$syn_ant_checkpoint_synonym_button
		);

		$($syn_ant_checkpoint_antonym_button_div).append(
			$syn_ant_checkpoint_antonym_button
		);

		// SYNONYM BUTTON: Check if highlighted word is part of the synonym array.
		click_syn_or_ant_checkpoint_button(
			$syn_ant_checkpoint_synonym_button,
			$syn_ant_checkpoint_synonyms_array
		);

		// ANTONYM BUTTON: Check if highlighted word is part of the antonym array.
		click_syn_or_ant_checkpoint_button(
			$syn_ant_checkpoint_antonym_button,
			$syn_ant_checkpoint_antonyms_array
		);

		//Checks if there are any synonyms or antonyms. If not, display a message
		// and show the continue button
		$(".no_word_info").remove();

		if ($shuffled_syn_ant_array.length == 0) {
			$(".syn_ant_checkpoint_btns").hide();
			$("#syn-ant-no-results").fadeIn();
			$("#syn_ant_checkpoint_continue_button").fadeIn();
		}
	};

	function start_real_world_examples_activity() {
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

	function start_review_level_one_activity(chosen_word_name) {
		$("#goodies, #games-score, #progress_bar_container").css(
			"visibility", "hidden"
		);
		$("#all_levels_button").show();
		$("#level_congrats_text").append(
			"<strong>'" + chosen_word_name + "'</strong> "
		);
		$("#goodies_total").html($new_goodies_total);
	};

	/**
	*
	*
	* HELPER FUNCTIONS
	*
	*
	**/

	function display_timer(selector, seconds) {
		var timer_container = create_elem("div", "center", "timer-container");
		var timer_content = create_elem("span", null, "countdown");
		var fa_clock = create_elem("i", "fa fa-clock-o");

		timer_content.append(seconds);
		timer_container.append(fa_clock);
		timer_container.append(timer_content);
		selector.append(timer_container);
		$("#timer-container").css("font-size", "58px");
	}

	function start_timer_countdown(
		seconds,
		counter,
		location,
		chosen_word_definitions,
		shuffled_definitions
	) {
		console.log("Counter (start_timer_countdown) ->", counter);

		var num_definitions = shuffled_definitions.length;

		clearInterval(countdown_id);

		if (counter != num_definitions) {
			counter++;
		}

		countdown_id = setInterval(function() {
			seconds--;

			$("#countdown").html(seconds);

			if (seconds == 0) {
				clearInterval(countdown_id);

				if (counter != num_definitions) {
					start_timer_countdown(
						meanings_chkpt_seconds(),
						counter,
						location,
						chosen_word_definitions,
						shuffled_definitions
					);
					display_next_meaning(counter, location, shuffled_definitions);
				}

				if (counter == num_definitions) {
					clearInterval(countdown_id);

					if (seconds == 0) {
						unbind_elem(".def-chkpt-btn").removeClass("pointer");
						$("#meanings_checkpoint_continue_button").fadeIn();
					}
				}
			}
		}, 1000);
	}

	function meanings_chkpt_seconds() {
		return 6;
	}

	function display_next_meaning(counter, location, shuffled_definitions) {
		$(location).html(shuffled_definitions[counter]);
		$(location).removeClass("animated bounceInRight")
												.hide()
											  .show()
										    .addClass("animated bounceInRight");
	}

	function check_answer(answer, definitions, definition, callback) {
		if (answer == "YES") {
			if (definitions.indexOf(definition) != -1) callback(true);
		} else {
			if (definitions.indexOf(definition) == -1) callback(true);
		}
	}

	function tally_score(correct) {
		if (correct) meanings_score++;
		console.log("Score ->", meanings_score);
		return meanings_score;
	}

	function create_yes_or_no_def_checkpoint_panel(definition) {
		// buttons need type="button"?
		var well = create_elem("div", "well def-chkpt-panel");
		$("#meanings-checkpoint-container").append(well);
		var yes_no_container = create_elem("div", "row center");
		$("#meanings-checkpoint-container").append(yes_no_container);
		var yes_container = create_elem("div", "col-xs-6");
		var no_container = create_elem("div", "col-xs-6");
		var yes_button = create_elem(
			"button",
			"btn btn-lg btn-info btn-block def-chkpt-btn"
		);
		var no_button = create_elem(
			"button",
			"btn btn-lg btn-info btn-block def-chkpt-btn"
		);
		var yes_emoji = create_elem(
			"i",
			"fa fa-thumbs-up"
		);
		var no_emoji = create_elem(
			"i",
			"fa fa-thumbs-down"
		);

		well.append(definition);

		yes_button.append(yes_emoji);
		yes_button.append("&nbsp; YES");
		yes_container.append(yes_button);

		no_button.append(no_emoji);
		no_button.append("&nbsp; NO");
		no_container.append(no_button);

		yes_no_container.append(yes_container);
		yes_no_container.append(no_container);
	}

	function unbind_elem(selector) {
		return $(selector).unbind();
	}

	function create_elem(elem, elem_class, elem_id) {
		elem_class = elem_class ||  null;
		elem_id = elem_id || null;

		return $("<" + elem + ">", { class: elem_class, id: elem_id });
	}

	function array_of_attributes(string) {
		return string.split('***');
	}

	function update_user_word_games_completed() {
		var game_info = { "word_id": $chosen_word_id };

		$.ajax({
			type: "PATCH",
			url: "/user_word",
			dataType: "json",
			data: game_info,
			success: function(response) {
				console.log(response.errors);
			}
		});
	};

  function update_num_played() {
    var game_info = {
      "word_id": $chosen_word_id,
      "game_name": "Fundamentals",
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

	// Synonym_Antonym Checkpoint Activity
	// Check if the current word is part of the (syn or ant) array.
	function click_syn_or_ant_checkpoint_button(
		syn_ant_checkpoint_name_button,
		syn_ant_checkpoint_names_array
	) {
		// SYNONYM BUTTON: Check if the current word is part of the synonym array.
		$(syn_ant_checkpoint_name_button).click(function() {
			// Capture the current word in the array
			$current_syn_ant_checkpoint_word = $shuffled_syn_ant_array[
				$shuffled_syn_ant_array_counter
			];

			// Check if the current word is a synonym
			if (syn_ant_checkpoint_names_array.indexOf(
				$current_syn_ant_checkpoint_word) != -1
			) {
				$shuffled_syn_ant_array_counter++;

				// Put a checkmark in the circle
				$(".current_syn_ant_checkpoint_word").prev().html("&#10004;");

				// Update and display the score
				$syn_ant_checkpoint_correct_score++;

				// Display the number correct out of the total number of synonyms and
				// antonyms available
				$("#syn_ant_checkpoint_score_div").html(
					$syn_ant_checkpoint_correct_score +
					" / " +
					$shuffled_syn_ant_array.length
				).show();
			} else {
				// Go to the next word
				$shuffled_syn_ant_array_counter++;

				// Put an X in the circle
				$(".current_syn_ant_checkpoint_word").prev().html("&#10006;")
				;
			}

			// Display the next word
			$(".current_syn_ant_checkpoint_word").parent().next().fadeIn();

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

			// Once all words have been clicked on, hide the synonym and
			// antonym button
			if ($shuffled_syn_ant_array_counter == $shuffled_syn_ant_array.length) {
				// Show the circles and their results
				$(".syn_ant_checkpoint_red_circle").show();

				// Display the number correct out of the total number of synonyms and
				// antonyms available
				$("#syn_ant_checkpoint_score_div").html(
					$syn_ant_checkpoint_correct_score +
					" / " +
					$shuffled_syn_ant_array.length
				).show();

				// Hide the synonym and antonym buttons
				$(".syn_ant_checkpoint_btns").hide();

				// Remove the active class from the previous last
				$(".current_syn_ant_checkpoint_word").removeClass(
					"current_syn_ant_checkpoint_word"
				);

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

	function boost_goodies(level_multiplier) {
		$new_goodies_total += level_multiplier;
		$("#goodies").html($new_goodies_total);
	};

	function reset_goodies(old_total) {
		new_goodies_total = old_total;
		$("#goodies").html(new_goodies_total);
	};

	function reset_input_value(id_name) {
		$("#" + id_name).val(function() {
			return this.defaultValue;
		});
	};

	function display_instruction(instruction) {
		$(".fundamentals-game-instructions").html(instruction);
	};

	function update_progress_bar(value) {
		$('.game-progress-bar').css('width', value + '%').attr(
			'aria-valuenow', value
		);
	};

	function randomRange (x, y) {
		return Math.floor(Math.random()* (x-y) + y);
	};

	function scroll_to_bottom() {
		$("html, body").animate({ scrollTop: $(document).height() }, "slow");
	};

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
}); // end of document ready fn
