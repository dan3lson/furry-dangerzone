$(document).ready(function() {
	var $chosenWordID = $(".palabra-id").html();
	var $chosenWordHeaderContainer = $("#chosen-word-header-container");
	var $regex = /^[a-zA-Z. ]+$/;
	var newPointsTotal = 0;
  var $timeGameStarted;
	var $scoreboardTimer = $(".scoreboard-timer");
	var checkmark = "✓";
	var $points = $(".scoreboard-points");
	var timerID;
	const $arrowDanger = $(".fa-arrow-down.text-danger");
	const $arrowSuccess = $(".fa-arrow-up.text-success");

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
      updateProgress(17);
			addPoints(100);
			flashPointsUpdate($arrowSuccess);
			spellByClickingLetters(chosenWordLetters);
    });
  }

  function fillInTheBlankContinueBtn(word) {
    $("#fill-in-the-blank-continue-btn").click(function() {
			var numSyllables = word.phonetic_spelling.split("·").length;
			var $pronunciationSpans = $("#pronunciation-spans");
			var $spellByClickingLettersDiv = $("#spell-by-clicking-letters-div");
      $("#fill-in-the-blank-continue-btn").hide();
      $spellByClickingLettersDiv.hide();
      $pronunciationSpans.show();
			giveDirections(
				"<mark>This word has " + numSyllables + " syllable(s).</mark> Click " +
				"the volume button to hear its pronunciation."
      );
      updateProgress(34);
			addPoints(150);
			flashPointsUpdate($arrowSuccess);
      startPronunciationActivity(word);
    });
  }

  function pronunciationContinueBtn(words) {
		const $pronunciationContinueBtn = $("#pronunciation-continue-btn");
		const targetWord = words[0];
		var $pronunciationSpans = $("#pronunciation-spans");

    $pronunciationContinueBtn.click(function() {
      $pronunciationSpans.hide();
      $pronunciationContinueBtn.hide();
			addPoints(200);
			flashPointsUpdate($arrowSuccess);
			updateProgress(51);
			$chosenWordHeaderContainer.html(targetWord.name)
																.removeClass("text-success");

			getMeaningAlts(targetWord.id).done(function(response) {
				if (response.length) {
					startMeaningAltsActivity(words, response);
				} else {
					getExampleNonExamples(targetWord.id).done(function(response) {
						if (response.length) {
							startExampleNonExamplesActivity(targetWord, response);
						} else {
							thesaurus(targetWord.name).done(function(response) {
								const synonyms = response[0];
								const antonyms = response[1];

								if (synonyms.length) {
									startSynVersusAntActivity(synonyms, antonyms);
								} else {
									startReviewActivity(targetWord);
								}
							});
						}
					});
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
			updateProgress(68);

			getExampleNonExamples(targetWord.id).done(function(response) {
				if (response.length) {
					startExampleNonExamplesActivity(targetWord, response);
				} else {
					thesaurus(targetWord.name).done(function(response) {
						const synonyms = response[0];
						const antonyms = response[1];

						if (synonyms.length) {
							startSynVersusAntActivity(synonyms, antonyms);
						} else {
							startReviewActivity(targetWord);
						}
					});
				}
			});
		});
	}

	function exampleNonExamplesContinueBtn(targetWord) {
		$("#ex-non-exs-cont-btn").click(function () {
			$("#ex-non-exs-div").hide();
			$("#ex-non-exs-cont-btn").hide();
			addPoints(500);
			flashPointsUpdate($arrowSuccess);
			updateProgress(85);

			thesaurus(targetWord.name).done(function(response) {
				const synonyms = response[0];
				const antonyms = response[1];

				if (isOffline(synonyms)) {
					var $alert = createElem("div", "alert alert-warning");
					$alert.text(synonyms);
					$("#syn-vs-ant-div").append($alert);
					$("#syn-vs-ant-cont-btn").show();
				} else {
					startSynVersusAntActivity(synonyms, antonyms);
				}
			});
		});
	}

	function synVersusAntContBtn(targetWord) {
		$("#syn-vs-ant-cont-btn").click(function () {
			$("#syn-vs-ant-div").hide();
			$("#syn-vs-ant-cont-btn").hide();
			addPoints(1000);
			flashPointsUpdate($arrowSuccess);
			updateProgress(100);
			startReviewActivity(targetWord);
		});
	}


	/***
	*
	*
	* FUNCTIONS FOR THE ACTIVITIES
	*
	*
	***/

	function setTheStage() {
		getGameWords().done(function(response) {
			var words = response.words;
			var targetWord = words[0];
			var targetWordName = targetWord.name
			startActivity(targetWordName);
			spellTheWordContinueBtn(targetWord);
			fillInTheBlankContinueBtn(targetWord);
			pronunciationContinueBtn(words);
			exampleNonExamplesContinueBtn(targetWord);
			meaningAltsContinueBtn(targetWord);
			synVersusAntContBtn(targetWordName);
		});
	}

	function startActivity(targetWordName) {
		if ($("#game-started-bool").hasClass("begin-timer")) {
			giveDirections("Type the word above.");
			spellByTyping(targetWordName);
			updateProgress(0);
			timerID = startCountup($scoreboardTimer, 0);
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
		var $alphabets = "abcdefghijklmnopqrstuvwxyz".split("");
		var	$randomAlphabet;
		var $alphabetRandLetters = [];
		var $mergedLettersArray = [];
		var $spellByClickingLettersDiv = $("#spell-by-clicking-letters-div");

		makeLettersDefault($chosenWordHeaderContainer);
		$spellByClickingLettersDiv.show();
		$chosenWordHeaderContainer.html($underscoreContainer);

		$.each(chosenWordLetters, function() {
			underscores += "_ ";
		});

		$underscoreContainer.text(underscores);

		for (var i = 0; i < 3; i++) {
			$randomAlphabet = $alphabets[randNumInRange(0, 26)];
			$alphabetRandLetters.push($randomAlphabet);
		}

		$mergedLettersArray = merge(chosenWordLetters, $alphabetRandLetters);
		$mergedLettersArray = shuffleArray($mergedLettersArray);

		$.each($mergedLettersArray, function(index, letter) {
			$letter = createBtn(
				"btn-lg btn-outline-primary fitb-letter letter_" + letter,
				letter
			);
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
					.addClass("fa-volume-up");

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
			"Read the statements below and decide which one makes more sense."
		);

		$.each(meaningAltArray, function(index) {
			$("#meaning-alts-div").append(createMeaningAltQues(this, index));
		})

		$("#meaning-alts-div").show();

		$(".container").on("click", ".mean-alts-answer", function() {
			$selAnswer = $(this);
			$selAnswerText = $selAnswer.text().trim();
			$selAnswerCard = $selAnswer.parents(".card");
			$selAnswerBlock = $selAnswerCard.find(".card-block");
			$btnRow = $selAnswer.parent().parent();
			index = $btnRow.data("index");
			answer = meaningAltArray[index].answer.trim();
			$feedbackCardText = $btnRow.siblings(".mean-alts-feedback")

			if ($selAnswerText == answer) {
				$selAnswerCard.addClass("card-outline-success");
				$selAnswerBlock.find(".float-right")
											 .append(createFontAweIcon("check fa-2x text-success"));
				$btnRow.find(".mean-alts-answer").prop("disabled", true)
																				 .removeClass("btn-outline-primary")
																				 .addClass("btn-outline-secondary");
				$feedbackCardText.prepend("<br>").addClass("text-success").fadeIn();
				$feedbackCardText.find("strong").prepend("Correct! ");
				addPoints(1);
			} else {
				$selAnswerCard.addClass("card-outline-danger");
				$selAnswerBlock.find(".float-right")
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
			}
		});
	};

	function startExampleNonExamplesActivity(targetWord, exNonExArray) {
		const $eNonEContinueBtn = $("#ex-non-exs-cont-btn");
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
		// TODO Figure out why the buttons oddly lose their btn-block class
		$(".container").on("click", ".ex-non-exs-answer", function() {
			$selAnswer = $(this);
			$selAnswerText = $selAnswer.text().trim();
			$selAnswerCard = $selAnswer.parents(".card");
			$selAnswerBlock = $selAnswerCard.find(".card-block");
			$btnRow = $selAnswer.parent().parent();
			index = $btnRow.data("index");
			answer = exNonExArray[index].answer.trim();
			$feedbackCardText = $btnRow.siblings(".ex-non-exs-feedback")

			if ($selAnswerText == answer) {
				$selAnswerCard.addClass("card-outline-success");
				$selAnswerBlock.find(".float-right")
											 .append(createFontAweIcon("check fa-2x text-success"));
				$btnRow.find(".ex-non-exs-answer").prop("disabled", true)
																				  .removeClass("btn-outline-primary")
																				  .addClass("btn-outline-secondary");
				$feedbackCardText.prepend("<br>").addClass("text-success").fadeIn();
				$feedbackCardText.find("strong").prepend("Correct! ");
				addPoints(1);
			} else {
				$selAnswerCard.addClass("card-outline-danger");
				$selAnswerBlock.find(".float-right")
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
				$("#ex-non-exs-cont-btn").fadeIn();
				// show an emoji pointing down and when clicked, scrollToBottom();
			}
		});
	}

	function startSynVersusAntActivity(synonyms, antonyms) {
		var $selectedBtn;
		var $selectedBtns;
		var twoBtnsAreSelected = false;
		var btnsAreTheSame = false;
		var gameCompleted = false;
		var isMatchMade = false;
		var matches = [];
		giveDirections("Match the synonym and antonym pairs for the word above.");
		matches = shuffleArray(merge(
			createMatchObjects(synonyms, "synonym"),
			createMatchObjects(antonyms, "antonym")
		));
		$("#syn-vs-ant-div").append(createMatchingCards(matches));

		$(".container").on("click", ".match", function() {
			$selectedBtn = $(this);
			$selectedBtn.addClass("selected");
			$selectedBtns = $(".selected");
			numSelected = $selectedBtns.length;
			twoBtnsAreSelected = numSelected > 1;

			if (twoBtnsAreSelected) {
				$firstBtn = $($selectedBtns[0]);
				$secondBtn = $($selectedBtns[1]);
				btnsAreOnyms = $firstBtn.text() == $secondBtn.text();

				if (btnsAreOnyms) {
					$selectedBtns.removeClass("btn-primary btn-outline-primary selected")
											 .addClass("btn-outline-primary");
				}

				if ($firstBtn.text() == "synonym" || $secondBtn.text() == "synonym") {
					var $wordBtn = findBtnNot($selectedBtns, "synonym");
					var matchIsFound = findMatch(matches, $wordBtn, "synonym").length;
					if (matchIsFound) { isMatchMade = true; }
				} else {
					var $wordBtn = findBtnNot($selectedBtns, "antonym");
					var matchIsFound = findMatch(matches, $wordBtn, "antonym").length;
					if (matchIsFound) { isMatchMade = true; }
				}

				if (isMatchMade) {
					$selectedBtns.removeClass("btn-primary btn-outline-primary selected")
											 .addClass("btn-success")
											 .prop("disabled", true);
					addPoints(30);
					flashPointsUpdate($arrowSuccess);
					isMatchMade = false;
					gameCompleted = $(".match.btn-success").length == matches.length * 2;

					if (gameCompleted) {
						$("#syn-vs-ant-cont-btn").fadeIn();
					}
				} else {
					$selectedBtns.removeClass("btn-primary btn-outline-primary selected")
											 .addClass("btn-outline-primary");
			    removePoints(10);
					flashPointsUpdate($arrowDanger);
				}
			} else {
				if ($selectedBtn.hasClass("btn-primary")) {
					$selectedBtn.removeClass("btn-primary selected")
											.addClass("btn-outline-primary");
				} else {
					$selectedBtn.removeClass("btn-outline-primary")
											.addClass("btn-primary");
				}
			}
		});
	};

	function startReviewActivity(targetWord) {
		updateProgress(100);
		addPoints(1000);
		flashPointsUpdate($arrowSuccess);
		$("#chosen-word-header-container").hide().addClass("text-center").fadeIn();
		$("#chosen-word-header-container").prepend(createElem("i", "em em-clap"));
		$("#chosen-word-header-container").append(createElem("i", "em em-clap"));
		$("#directions .text-primary").html("Nice job...you finished!");
		$("#directions span:last").html("Ready for the next challenge?");
		clearTimeout(timerID);
	};

	/**
	*
	*
	* HELPER FUNCTIONS
	*
	*
	**/

	function findBtnNot($btns, type) {
		return $btns.filter(function() {
			return $(this).text() != type;
		});
	}

	function findMatch(matches, $btn, type) {
		return matches.filter(function(match) {
			return isMatch(match, $btn, type);
		});
	}

	function isMatch(match, $btn, type) {
		return match.word == $btn.text() && match.type == type;
	}

	function createMatchObjects(words, type) {
		matches = [];

		$.each(words, function(index, word) {
			match = new Object();
			match.id = index;
			match.word = word;
			match.type = type;
			matches.push(match);
		});

		return matches;
	}

	function createMatchingCards(matches) {
		var $row = createElem("div", "row text-center");
		var $typeBtn;
		var $wordBtn;
		var $typeColSmallThree;
		var $wordColSmallThree;

		$.each(matches, function(index, match) {
			$wordColSmallThree = createElem("div", "col-sm-4 mb-3");
			$typeColSmallThree = createElem("div", "col-sm-4 mb-3");
			$wordBtn = createBtn(
				"btn-outline-primary btn-lg btn-block match", match.word
			)
			$typeBtn = createBtn(
				"btn-outline-primary btn-lg btn-block match", match.type
			);
			$typeColSmallThree.append($typeBtn);
			$wordColSmallThree.append($wordBtn);
			$row.append($wordColSmallThree).append($typeColSmallThree);
		});

		return $row;
	}

	function isOffline(string) {
		return string.indexOf("Looks like you are offline") != -1;
	}

	function thesaurus(targetWordName) {
		return $.get(
			"/thesaurus/" + targetWordName, function() {}, "json"
		);
	};

	function getGameWords() {
		return $.get(
			"/fundamentals?word_id=" + $chosenWordID, function() {}, "json"
		);
	};

	function getExampleNonExamples(wordID) {
		return $.get(
			"/words/" + wordID + "/example_non_examples", function() {}, "json"
		);
	};

	function getMeaningAlts(wordID) {
		return $.get(
			"/words/" + wordID + "/meaning_alts", function() {}, "json"
		);
	};

	function createFontAweIcon(_class) {
		return createElem("i", "fa fa-" + _class)
	}

	function createBtn(_class, text) {
		return createElem("button", "btn " + _class).text(text.trim());
	}

	function createMeaningAltQues(meaningAlt, index) {
		$card = createElem("div", "card mb-3");
		$cardBlock = createElem("div", "card-block");
		$cardTitle = createElem("h4", "card-title");
		$rightOrWrongIcon = createElem("div", "float-right");
		$btnsDiv = createElem("div", "row text-center");
		$halfCol1 = createElem("div", "col-sm-6");
		$halfCol2 = createElem("div", "col-sm-6");
		btnOptions = shuffleArray(meaningAlt.choices.split(","));
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
		btnOptions = shuffleArray(["example", "non-example"]);
		$btn1 = createBtn(
			"btn-lg btn-outline-primary btn-block ex-non-exs-answer",
			btnOptions[0]
		);
		$btn2 = createBtn(
			"btn-lg btn-outline-primary btn-block ex-non-exs-answer",
			btnOptions[1]
		);
		$feedback = createElem(
			"p", "card-text ex-non-exs-feedback"
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
		return countdownID = setInterval(function() {
			seconds++;
			$section.html(seconds);
		}, 1000);
	}

	function createElem(elem, elemClass, elemID) {
		_class = elemClass || null;
		_id = elemID || null;
		return $("<" + elem + ">", { class: _class, id: _id });
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

	function updateProgress(value) {
		var $progressBar = $(".progress-bar");
		$progressBar.attr("aria-valuenow", value)
								.attr("style", "width: " + value + "%;")
								.text(value + "%");
	};

	function randNumInRange(start, end) {
		return Math.floor(Math.random()* (start - end) + end);
	};

	function scrollTo($section) {
		$("html, body").animate({ scrollTop: $section.offset().top - 50 }, 2000);
	};

	function scrollToBottom() {
		$("html, body").animate({ scrollTop: $(document).height() }, 3000);
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
