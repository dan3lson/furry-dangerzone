$(document).ready(function() {
	// General
	var $chosenWordID = $(".palabra-id").html();
	var $chosenWordHeaderContainer = $("#chosen-word-header-container");
	var $regex = /^[a-zA-Z. ]+$/;
	var newPointsTotal = 0;
  var $timeGameStarted;
	var $scoreboardTimer = $(".scoreboard-timer");
	var checkmark = "✓";
	var $points = $(".scoreboard-points");
	const $arrowDanger = $(".fa-arrow-down.text-danger");
	const $arrowSuccess = $(".fa-arrow-up.text-success");
	// Spell by Clicking Letters
	var $alphabets = "abcdefghijklmnopqrstuvwxyz".split('');
	var	$randomAlphabet;
	var $alphabetRandLetters = [];
	var $mergedLettersArray = [];
	var $spellByClickingLettersDiv = $("#spell-by-clicking-letters-div");
	// Pronunciation
	var $pronunciationSpans = $("#pronunciation-spans");
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

	if ($chosenWordID != undefined) {
		setTheStage();
	}

  /***
	*
	*
	* CONTINUE BUTTONS
	*
	*
	***/

  function spellTheWordContinueBtn(word) {
    $("#spell-the-word-continue-btn").click(function(event) {
			var chosenWordName = word.name;
			var chosenWordLetters = chosenWordName.split('');
      $("#spell-by-typing-form").hide();
      $(".checkpoint-image").show();
      $("#spell-the-word-continue-btn").hide();
      giveDirections(
				"Tap the letters to spell that same word, whose definition is <mark>" +
				word.definition + "</mark>."
			);
      updateProgressBar(12);
			addPoints(100);
			flashPointsUpdate($arrowSuccess);
			spellByClickingLetters(chosenWordLetters);
    });
  }

  function fillInTheBlankContinueBtn(word) {
    $("#fill-in-the-blank-continue-btn").click(function() {
			var numSyllables = word.phonetic_spelling.split("·").length;
      $("#fill-in-the-blank-continue-btn").hide();
      $spellByClickingLettersDiv.hide();
      $pronunciationSpans.show();
			giveDirections(
				"<mark>This word has " + numSyllables + " syllable(s).</mark> Click " +
				"the volume button to hear its pronunciation."
      );
      updateProgressBar(25);
			addPoints(150);
			flashPointsUpdate($arrowSuccess);
      startPronunciationActivity(word);
    });
  }

  function pronunciationContinueBtn(words) {
		const $pronunciationContinueBtn = $("#pronunciation-continue-btn");
		const targetWord = words[0];

    $pronunciationContinueBtn.click(function() {
      $pronunciationSpans.hide();
      $pronunciationContinueBtn.hide();
			addPoints(200);
			flashPointsUpdate($arrowSuccess);
			updateProgressBar(37);
			$chosenWordHeaderContainer.html(targetWord.name)
																.removeClass("text-success");

			getMeaningAlts(targetWord.id).done(function(response) {
				if (response.length) {
					startMeaningAltsActivity(words, response);
				} else {
					startExampleNonExamplesActivity(targetWord, response);
				}
			})
    });
  }

	function meaningAltsContinueBtn(targetWord) {
		$("#meaning-alts-continue-btn").click(function () {
			$("#meaning-alts-div").hide();
			$("#meaning-alts-continue-btn").hide();
			addPoints(325);
			flashPointsUpdate($arrowSuccess);
			updateProgressBar(50);

			getExampleNonExamples(targetWord.id).done(function(response) {
			  startExampleNonExamplesActivity(targetWord, response);
			});

			// if (!$("#synonym_no_results").hasClass("please-tap-continue")) {
			// 	$("#synonyms_back_button").show();
			// 	$("#synonyms_container").show();
			// 	giveDirections(
			// 		"The words below are similar to " +
			// 		"<strong>'" +
			// 		chosenWordName +
			// 		"'</strong>. Tap and view each one."
			// 	);
			// 	updateProgressBar(60);
			// 	start_synonyms_activity(chosenWordName);
			// } else if (
			// 	$("#synonym_no_results").hasClass("please-tap-continue") &&
			// 	!$("#antonym_no_results").hasClass("please-tap-continue")
			// ) {
			// 	$("#synonyms_back_button").hide();
			// 	$("#synonyms-cont-btn").hide();
			// 	$("#synonyms_container").hide();
			// 	$("#antonyms_container").show();
			// 	$("#antonyms_back_button").show();
			// 	giveDirections(
			// 		"The words below are opposite to " + "<strong>'" +
			// 		chosenWordName + "'</strong>. Tap and view each one."
			// 	);
			// 	updateProgressBar(75);
			// 	start_antonyms_activity(chosenWordName);
			// }	else if (
			// 	$("#synonym_no_results").hasClass("please-tap-continue") &&
			// 	$("#antonym_no_results").hasClass("please-tap-continue") &&
			// 	$("#rwe_no_results").hasClass("please-tap-continue")
			// ) {
			// 	$("#real_world_examples_back_button").hide();
			// 	$("#real_world_examples_continue_button").hide();
			// 	$("#real_world_examples_container").hide();
			// 	$("#directions").hide();
			// 	$("#review_level_one_back_button").fadeIn();
			// 	$("#review_level_one_continue_button").fadeIn();
			// 	$("#review_level_one_container").fadeIn();
			// 	update_user_word_games_completed();
			// 	updateProgressBar(100);
			// 	updateUserPoints(10);
			// 	addPoints(3);
			// 	update_num_played();
			// 	start_review_level_one_activity(chosenWordName);
			// } else if (
			// 	$("#synonym_no_results").hasClass("please-tap-continue") &&
			// 	$("#antonym_no_results").hasClass("please-tap-continue")
			// ) {
			// 	$("#real_world_examples_back_button").show();
			// 	$("#real_world_examples_container").show();
			// 	giveDirections(
			// 		"Tap each source to see how <strong>'" +
			// 		chosenWordName +
			// 		"'</strong> has been used in everyday life."
			// 	);
			// 	updateProgressBar(90);
			// 	start_real_world_examples_activity(chosenWordName);
			// }
		});
	}

	function exampleNonExamplesContinueBtn(targetWord) {
		$("#ex-non-ex-continue-btn").click(function () {
			$("#meaning-alts-div").hide();
			startExampleNonExamplesActivity(targetWord);
		});
	}

  function synonyms-cont-btn(chosenWordName) {
    $("#synonyms-cont-btn").click(function(){
      // Start the next activity --> if there are synonyms, but no antonyms
      if ($("#antonym_no_results").hasClass("please-tap-continue")) {
        $("#syn_ant_checkpoint_back_button").show();
        $("#syn_ant_checkpoint_container").show();
				$(".checkpoint-image").show();
        $("#synonyms-cont-btn").hide();
        $("#synonyms_container").hide();

        giveDirections(
					"Is <strong>'" +
					chosenWordName +
          "'</strong> a synonym or antonym to:"
        );

        updateProgressBar(75);

        start_syn_ant_checkpoint_activity();

        // Start the next activity --> if there there are antonyms
      } else {
        $("#synonyms_back_button").hide();
        $("#synonyms-cont-btn").hide();
        $("#synonyms_container").hide();
        $("#antonyms_back_button").show();
        $("#antonyms_container").show();

        giveDirections(
					"The words below are opposite to <strong>'" +
          chosenWordName +
					"'</strong>. Tap and view each one."
        );

        updateProgressBar(75);

        start_antonyms_activity(chosenWordName);
      }
    });
  }

  function antonyms_continue_button(chosenWordName) {
    $("#antonyms_continue_button").click(function(){
      $("#syn_ant_checkpoint_back_button").show();
      $("#syn_ant_checkpoint_container").show();
			$(".checkpoint-image").show();
      $("#antonyms_continue_button").hide();
      $("#antonyms_container").hide();

      giveDirections(
				"Is <strong>'" +
				chosenWordName +
        "'</strong> a synonym or antonym to:"
      );

      updateProgressBar(75);

			start_syn_ant_checkpoint_activity();
    });
  }

  function syn_ant_checkpoint_continue_button(chosenWordName) {
    $("#syn_ant_checkpoint_continue_button").click(function(){
      $(".checkpoint-image").hide();
      $("#syn_ant_checkpoint_back_button").hide();
      $("#syn_ant_checkpoint_container").hide();
      $("#syn_ant_checkpoint_continue_button").hide();
      $("#syn_ant_checkpoint_score_div").hide();
      $("#real_world_examples_back_button").show();
      $("#real_world_examples_container").show();
      giveDirections(
				"Tap each source to see how <strong>'" +
        chosenWordName +
				"'</strong> has been used in everyday life."
      );
      updateProgressBar(90);

      // If all words have been clicked on, show the RWE container
      if ($("#rwe_no_results").hasClass("please-tap-continue")) {
        $("#real_world_examples_back_button").hide();
        $("#real_world_examples_continue_button").hide();
        $("#real_world_examples_container").hide();
        $("#directions").hide();
        $("#review_level_one_back_button").fadeIn();
        $("#review_level_one_continue_button").fadeIn();
        $("#review_level_one_container").fadeIn();
        update_user_word_games_completed();
        update_num_played();
        updateProgressBar(100);
        updateUserPoints(10);
        addPoints(10);

        start_review_level_one_activity(chosenWordName);
      } else {
        start_real_world_examples_activity(chosenWordName);
      }
    });
  }

  function real_world_examples_continue_button(chosenWordName) {
    $("#real_world_examples_continue_button").click(function(){
      $("#real_world_examples_back_button").hide();
      $("#real_world_examples_continue_button").hide();
      $("#real_world_examples_container").hide();
      $("#directions").hide();
      $("#review_level_one_back_button").fadeIn();
      $("#review_level_one_continue_button").fadeIn();
      $("#review_level_one_container").fadeIn();
			start_review_level_one_activity(chosenWordName);
      update_user_word_games_completed();
      update_num_played();
      updateProgressBar(100);
      updateUserPoints(10);
    });
  }

	/***
	*
	*
	* FUNCTIONS FOR THE ACTIVITIES
	*
	*
	***/

	function getGameWords() {
		return $.get(
			"/fundamentals?word_id=" + $chosenWordID, function() {}, "json"
		);
	};

	function getMeaningAlts(wordID) {
		return $.get(
			"/words/" + wordID + "/meaning_alts", function() {}, "json"
		);
	};

	function getExampleNonExamples(wordID) {
		return $.get(
			"/words/" + wordID + "/example_non_examples", function() {}, "json"
		);
	};

	function setTheStage() {
		getGameWords().done(function(response) {
			var words = response.words;
			var targetWord = words[0];
			var targetWordName = targetWord.name
			startActivity(targetWordName);
			spellTheWordContinueBtn(targetWord);
			fillInTheBlankContinueBtn(targetWord);
			pronunciationContinueBtn(words);
			exampleNonExamplesContinueBtn(words);
			meaningAltsContinueBtn(targetWord);
			synonyms-cont-btn(targetWordName);
			antonyms_continue_button(targetWordName);
			syn_ant_checkpoint_continue_button(targetWordName);
			real_world_examples_continue_button(targetWordName);
		});
	}

	function startActivity(targetWordName) {
		if ($("#game-started-bool").hasClass("begin-timer")) {
			giveDirections("Type the word above.");
			spellByTyping(targetWordName);
			updateProgressBar(0);
			startCountup($scoreboardTimer, 0);
			$timeGameStarted = new Date();
		}
	}

	function spellByTyping(word) {
		const $chosenWordDiv = $chosenWordHeaderContainer;
		var inputText;
		var wordSubstring;
		var wordLetterSpan;
		var chosenWordSpanLetters = [];
		var $input = $("#spell-the-word");
		var $btn = $("#spell-the-word-continue-btn");
		var numLettersTyped = 0;
		var successLetters = 0;
		$input.focus();

		$.each(word.split(""), function() {
			wordLetterSpan = $(createElem("span")).append(this);
			chosenWordSpanLetters.push(wordLetterSpan);
		})

		$chosenWordDiv.append(chosenWordSpanLetters);

		$input.on('input', function() {
			inputText = $(this).val().trim().toLowerCase();
			numLettersTyped = inputText.length;
			wordSubstring = word.substring(0, numLettersTyped);

			if (inputText == wordSubstring) {
				makeLettersGreen($chosenWordDiv, numLettersTyped);
				successLetters = $chosenWordDiv.find("span.text-success").length;

				if (successLetters != numLettersTyped) {
					makeLettersDefault($chosenWordDiv);
					makeLettersGreen($chosenWordDiv, numLettersTyped);
				}
			}

			if (inputText == word) {
				$input.parent().addClass("has-success");
				$input.addClass("form-control-success");
				$btn.fadeIn();
			} else {
				$input.parent().removeClass("has-success");
				$input.removeClass("form-control-success");
				$btn.fadeOut();
			}
		});
	};

	function spellByClickingLetters(chosenWordLetters) {
		var $letter;
		var $tappedLetterBtn;
		var tappedLetter;
		var firstLetter;
		var underscores = "";
		var $underscoreContainer = createElem("div", null, "underscore-container");
		makeLettersDefault($chosenWordHeaderContainer);
		$spellByClickingLettersDiv.show();
		$chosenWordHeaderContainer.html($underscoreContainer);

		$.each(chosenWordLetters, function() {
			underscores += "_ ";
		});

		$underscoreContainer.text(underscores);

		for (var i = 0; i < 3; i++) {
			$randomAlphabet = $alphabets[randomRange(26, 0)];
			$alphabetRandLetters.push($randomAlphabet);
		}

		$mergedLettersArray = merge(chosenWordLetters, $alphabetRandLetters);
		$mergedLettersArray = shuffleArray($mergedLettersArray);

		$.each($mergedLettersArray, function(index, letter) {
			$letter = createElem(
				"button",
				"btn btn-lg btn-outline-primary fitb-letter letter_" + letter);
			$letter.text(letter);
			$spellByClickingLettersDiv.append($letter);
		});

		$(".fitb-letter").click(function() {
			$tappedLetterBtn = $(this);
			tappedLetter = $(this).text();

			for (var i = 0; i < chosenWordLetters.length; i++) {
				firstLetter = chosenWordLetters[0];
			}

			if (firstLetter == tappedLetter) {
				$tappedLetterBtn.removeClass("btn-outline-primary")
												.addClass("btn-success");
				$tappedLetterBtn.prop("disabled", true);
				underscores = underscores.replace(/_ /, tappedLetter);
				$underscoreContainer.text(underscores);
				chosenWordLetters.shift();
				addPoints(1);
				flashPointsUpdate($arrowSuccess);
			} else {
				removePoints(1);
				flashPointsUpdate($arrowDanger);
				$tappedLetterBtn.removeClass("animated shake")
												.addClass("animated shake");
			}

			if (chosenWordLetters.length == 0) {
				$underscoreContainer.addClass("text-success");
				$(".fitb-letter").prop("disabled", true);
				$("#fill-in-the-blank-continue-btn").fadeIn();
			} else {
				$("#fill-in-the-blank-continue-btn").fadeOut();
			}
		});
	};

	function startPronunciationActivity(targetWord) {
		const $audioBtn = $(".funds-audio-btn");
		const $pronunciationContinueBtn = $("#pronunciation-continue-btn");
		var attr = $(".audiooo").attr("src") + targetWord.name + ".mp3";
		var $btn;
		$chosenWordHeaderContainer.html(targetWord.phonetic_spelling);
		$(".audiooo").attr("src", attr);

		// TODO Track this metric
		$audioBtn.click(function() {
			$btn = $(this);
			$btn.addClass("text-success")
					.removeClass("fa-volume-off")
					.addClass("fa-volume-up")
			setTimeout(function() {
				$btn.removeClass("text-success")
						.removeClass("fa-volume-up")
						.addClass("fa-volume-off");
			}, 500);
			$chosenWordHeaderContainer.addClass("text-success");
			addPoints(1);
			flashPointsUpdate($arrowSuccess);
			$pronunciationContinueBtn.fadeIn();
		});
	};

	function startMeaningAltsActivity(words, meaningAltArray) {
		var chosenWord = words[0];
		giveDirections(
			"Read the statement(s) below and decide which one is better."
		);

		$.each(meaningAltArray, function(index) {
			$("#meaning-alts-div").append(createMeaningAltQues(this, index));
		})

		$("#meaning-alts-div").show();

		$(".container").on("click", ".mean-alts-answer", function() {
			$selectedAnswer = $(this);
			$selectedAnswerText = $selectedAnswer.text().trim();
			$btnRow = $selectedAnswer.parent().parent();
			index = $btnRow.data("index");
			answer = meaningAltArray[index].answer.trim();
			$feedbackCardText = $btnRow.siblings(".mean-alts-feedback")

			if ($selectedAnswerText == answer) {
				$selectedAnswer.parents(".card-block")
											 .find(".float-right")
											 .append(createFontAweIcon("check fa-2x text-success"));
				$btnRow.find(".mean-alts-answer").prop("disabled", true)
																				 .removeClass("btn-outline-primary")
																				 .addClass("btn-outline-secondary");
				$feedbackCardText.prepend("<br>").addClass("text-success").fadeIn();
				$feedbackCardText.find("strong").prepend("Correct! ");
				addPoints(1);
			} else {
				$selectedAnswer.parents(".card-block")
											 .find(".float-right")
											 .append(createFontAweIcon("close fa-2x text-danger"));
				$btnRow.find(".mean-alts-answer").prop("disabled", true)
																				 .removeClass("btn-outline-primary")
																			 	 .addClass("btn-outline-secondary");
 			  $feedbackCardText.prepend("<br>").addClass("text-danger").fadeIn();
				$feedbackCardText.find("strong").prepend("Incorrect. ");
				removePoints(1);
			}

			var numBtns = $("#meaning-alts-div .btn").length;
			var numBtnsDisabled = $("#meaning-alts-div .btn:disabled").length;

			if (numBtns == numBtnsDisabled) {
				$("#meaning-alts-continue-btn").fadeIn();
				scrollToBottom();
			}
		});
	};

	function startExampleNonExamplesActivity(targetWord, exNonExArray) {
		const $eNonEContinueBtn = $("#ex-non-ex-continue-btn");
		console.log(exNonExArray);
		$eNonEContinueBtn.hide();
		giveDirections(
			"Are the statements below an example or non-example of " +
			"the word above, whose definition is <mark>" + targetWord.definition +
			"</mark>."
		);

		$.each(exNonExArray, function(index) {
			$("#ex-non-exs-div").append(createExNonExQues(this, index));
		})

		$("#ex-non-exs-div").show();

		$(".container").on("click", ".ex-non-exs-answer", function() {
			$selectedAnswer = $(this);
			$selectedAnswerText = $selectedAnswer.text().trim();
			$btnRow = $selectedAnswer.parent().parent();
			index = $btnRow.data("index");
			answer = exNonExArray[index].answer.trim();
			$feedbackCardText = $btnRow.siblings(".ex-non-exs-feedback")

			if ($selectedAnswerText == answer) {
				$selectedAnswer.parents(".card-block")
											 .find(".float-right")
											 .append(createFontAweIcon("check fa-2x text-success"));
				$btnRow.find(".ex-non-exs-answer").prop("disabled", true)
																				  .removeClass("btn-outline-primary")
																				  .addClass("btn-outline-secondary");
				$feedbackCardText.prepend("<br>").addClass("text-success").fadeIn();
				$feedbackCardText.find("strong").prepend("Correct! ");
				addPoints(1);
			} else {
				$selectedAnswer.parents(".card-block")
											 .find(".float-right")
											 .append(createFontAweIcon("close fa-2x text-danger"));
				$btnRow.find(".ex-non-exs-answer").prop("disabled", true)
																				  .removeClass("btn-outline-primary")
																				  .addClass("btn-outline-secondary");
				$feedbackCardText.prepend("<br>").addClass("text-danger").fadeIn();
				$feedbackCardText.find("strong").prepend("Incorrect. ");
				removePoints(1);
			}

			var numBtns = $("#ex-non-exs-div .btn").length;
			var numBtnsDisabled = $("#ex-non-exs-div .btn:disabled").length;

			if (numBtns == numBtnsDisabled) {
				$("#synonyms-cont-btn").fadeIn();
				scrollToBottom();
			}
		});
	}

	function start_synonyms_activity() {
		if ($("#synonym_no_results").hasClass("please-tap-continue")) {
			$("#synonyms-cont-btn").fadeIn();
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
					$("#synonyms-cont-btn").fadeIn();
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
			class: "float-right" }
		);
		$($syn_ant_checkpoint_score_div).insertBefore(
			"#syn_ant_checkpoint_container"
		);

		// Find all of the synonyms for  and add to the synonyms array
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
		$shuffled_syn_ant_array = shuffleArray($shuffled_syn_ant_array);

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

	function start_review_level_one_activity(chosenWordName) {
		$("#goodies, #games-score, .progress-bar-container").css(
			"visibility", "hidden"
		);
		$("#all_levels_button").show();
		$("#level-congrats-text").append(
			"<strong>'" + chosenWordName + "'</strong>."
		);
		$("#goodies_total").html(newPointsTotal);
	};

	/**
	*
	*
	* HELPER FUNCTIONS
	*
	*
	**/

	function createFontAweIcon(_class) {
		return createElem("i", "fa fa-" + _class)
	}

	function createBtn(_class, text) {
		var $btn = createElem("button", "btn " + _class);
		return $btn.text(text);
	}

	function createMeaningAltQues(meaningAlt, index) {
		$card = createElem("div", "card mb-3");
		$cardBlock = createElem("div", "card-block");
		$cardTitle = createElem("h4", "card-title");
		$rightOrWrongIcon = createElem("div", "float-right");
		$btnsDiv = createElem("div", "row text-center");
		$halfCol1 = createElem("div", "col-sm-6");
		$halfCol2 = createElem("div", "col-sm-6");
		btnOptions = meaningAlt.choices.split(",");
		$btn1 = createBtn(
			"btn-lg btn-outline-primary btn-block mean-alts-answer",
			btnOptions[0]
		);
		$btn2 = createBtn(
			"btn-lg btn-outline-primary btn-block mean-alts-answer",
			btnOptions[1]
		);
		$feedback = createElem(
			"p", "card-text mean-alts-feedback"
		).append(createElem("strong"));
		$card.append($cardBlock);
		$cardBlock.append($cardTitle);
		$cardTitle.append($rightOrWrongIcon);
		$cardTitle.append(meaningAlt.text);
		$cardBlock.append($btnsDiv);
		$cardBlock.append($feedback);
		$btnsDiv.attr("data-index", index);
		$btnsDiv.append($halfCol1).append($halfCol2);
		$halfCol1.append($btn1);
		$halfCol2.append($btn2);
		$feedback.find("strong").append(meaningAlt.feedback);
		return $card;
	}

	function createExNonExQues(exNonEx, index) {
		$card = createElem("div", "card mb-3");
		$cardBlock = createElem("div", "card-block");
		$cardTitle = createElem("h4", "card-title");
		$rightOrWrongIcon = createElem("div", "float-right");
		$btnsDiv = createElem("div", "row text-center");
		$halfCol1 = createElem("div", "col-sm-6");
		$halfCol2 = createElem("div", "col-sm-6");
		btnOptions = ["example", "non-example"];
		$btn1 = createBtn(
			"btn-lg btn-outline-primary btn-block ex-non-exs-answer",
			btnOptions[0]
		);
		$btn2 = createBtn(
			"btn-lg btn-outline-primary btn-block ex-non-exs-answer",
			btnOptions[1]
		);
		$feedback = createElem(
			"p", "card-text mean-alts-feedback"
		).append(createElem("strong"));
		$card.append($cardBlock);
		$cardBlock.append($cardTitle);
		$cardTitle.append($rightOrWrongIcon);
		$cardTitle.append(exNonEx.text);
		$cardBlock.append($btnsDiv);
		$cardBlock.append($feedback);
		$btnsDiv.attr("data-index", index);
		$btnsDiv.append($halfCol1).append($halfCol2);
		$halfCol1.append($btn1);
		$halfCol2.append($btn2);
		$feedback.find("strong").append(exNonEx.feedback);
		return $card;
	}

	function flashPointsUpdate($arrow) {
		$arrow.css("opacity", "1");

		setTimeout(function() {
			$arrow.css("opacity", "0.1");
		}, 300);
	}

	function makeLettersGreen($section, numLetters) {
		$($section.find("span").splice(0, numLetters)).addClass("text-success");
	}

	function makeLettersDefault($section) {
		$($section.find("span.text-success")).removeClass("text-success");
	}

	function merge(array1, array2) {
		return $.merge($.merge([], array1), array2);
	}

	function displayTimer($section, seconds) {
		var $timerContainer = createElem("div", null, "timer-container");
		var $countdown = createElem("span", null, "countdown");
		var $clockIcon = createElem("i", "fa fa-clock-o");
		$countdown.append(seconds);
		$timerContainer.append($clockIcon);
		$timerContainer.append($countdown);
		$section.append($timerContainer);
	}

	function startCountdown($section, seconds) {
		var countdownID = setInterval(function() {
			seconds--;
			$section.html(seconds);
			if (seconds == 0) {
				clearInterval(countdownID);
			}
		}, 1000);
	}

	function startCountup($section, seconds) {
		var countdownID = setInterval(function() {
			seconds++;
			$section.html(seconds);
		}, 1000);
	}

	function create_yes_or_no_def_checkpoint_panel(definition) {
		// buttons need type="button"?
		var well = createElem("div", "well def-chkpt-panel");
		$("#meaning-alts-div").append(well);
		var yes_no_container = createElem("div", "row center");
		$("#meaning-alts-div").append(yes_no_container);
		var yes_container = createElem("div", "col-xs-6");
		var no_container = createElem("div", "col-xs-6");
		var yes_button = createElem(
			"button",
			"btn btn-lg btn-info btn-block def-chkpt-btn"
		);
		var no_button = createElem(
			"button",
			"btn btn-lg btn-info btn-block def-chkpt-btn"
		);
		var yes_emoji = createElem("i","fa fa-thumbs-up");
		var no_emoji = createElem("i","fa fa-thumbs-down");

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

	function createElem(elem, elemClass, elemID) {
		_class = elemClass || null;
		_id = elemID || null;
		return $("<" + elem + ">", { class: _class, id: _id });
	}

	function array_of_attributes(string) {
		return string.split("***");
	}

	function update_user_word_games_completed() {
		var game_info = { "word_id": $chosenWordID };

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
      "word_id": $chosenWordID,
      "game_name": "Fundamentals",
      "time_spent_in_min": ((new Date() - $timeGameStarted) / 1000 ) / 60
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

	function updateUserPoints(num) {
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

	function addPoints(points) {
		newPointsTotal += points;
		$points.html(newPointsTotal);
	};

	function removePoints(points) {
		if (newPointsTotal > 0) {
			newPointsTotal -= points;
			$points.html(newPointsTotal);
		}
	};

	function giveDirections(instruction) {
		$("#fundamentals-game-instructions").html(instruction);
	};

	function updateProgressBar(value) {
		var $progressBar = $(".progress-bar");
		$progressBar.attr("aria-valuenow", value)
								.attr("style", "width: " + value + "%;")
								.text(value + "%");
	};

	function randomRange (x, y) {
		return Math.floor(Math.random()* (x-y) + y);
	};

	function scrollTo($section) {
		$("html, body").animate({ scrollTop: $section.offset().top - 50 }, 2000);
	};

	function scrollToBottom() {
		$("html, body").animate({ scrollTop: $(document).height() }, "slow");
	}

	function shuffleArray(array) {
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
