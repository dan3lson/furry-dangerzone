$(document).ready(function() {
	$(".awfs-classrooms-or-individuals").click(function() {
		$(this).parents(".row").next().removeClass("d-none");
		var type = $(this).find("h1").text().trim();
		$("#awfs-header").html(type);
		$(".awfs-classrooms-or-individuals").removeClass("border-primary");
		$(this).addClass("border-primary");

		if (type == "Add Words For Entire Classrooms") {
			$("#select-multi-individual-students option:selected").prop("selected", false);
			displayUsernamesNum();
			$("#awfs-step-3-div").hide();
			$("#awfs-step-2-div").show();
		} else {
			$("#select-multi-classrooms option:selected").prop("selected", false);
			displayClassroomsNum();
			$("#awfs-step-2-div").hide();
			$("#awfs-step-3-div").show();
		}
	})

	$("#select-multi-classrooms").change(function() {
		displayClassroomsNum();
	});

	$("#select-multi-individual-students").change(function() {
		displayUsernamesNum();
	});

	$(".search-results-container").on("click", ".awfs-add-word-btn", function(e) {
		e.preventDefault();
		var $index = 0;
		var wordID = $(this).data('word-id');
		var wordName = $(this).data('word-name');
		var numWordsSelected = classLength(".teacher-selected-word") + 1;
		$(".num-words-selected").html(numWordsSelected);
		var $word = displaySelectedWord(wordName, wordID);
		$("#selected-words").append($word);
		$("#selected-words-ids").append(wordID + ",");
		var $dd = $("dd[data-word-id='" + wordID + "']");
		var $message = createElem("span").append(
			"Successfully added to the queue above."
		);
		$dd.html(createFlash("success", $message));
		activateOrDeactivateFinishBtn(numWordsSelected);
	});

	$("#teacher-words").on("click", ".teacher-selected-word", function() {
		numWordsSelected = classLength(".teacher-selected-word") - 1;
		$(".num-words-selected").html(numWordsSelected);
		var selectedWordIDs = $("#selected-words-ids").html();
		var $id = selectedWordIDs.split(",")[$(this).index()];
		var updatedWordIDs = selectedWordIDs.replace($id + ",", "");
		$("#selected-words-ids").html(updatedWordIDs);
		$(this).remove();
		activateOrDeactivateFinishBtn(numWordsSelected);
	});

	$("#select-words-finish-btn").click(function() {
		showOrHideResults("show");
		sendToRails();
	});

	function displayClassroomsNum() {
		$(".num-classrooms").html(numClassrooms());
	}

	function displayUsernamesNum() {
		$(".num-students").html(numUsernames());
	}

	function createFlash(_class, text) {
		return createElem("div", "alert alert-" + _class)
					 .append(text)
					 .attr("role", "alert");
	}

	function createElem(elem, elemClass, elemID) {
		_class = elemClass || null;
		_id = elemID || null;
		return $("<" + elem + ">", { class: _class, id: _id });
	}

	function activateOrDeactivateFinishBtn(numWordsSelected) {
		if (numWordsSelected > 0) {
			$("#select-words-finish-btn").prop("disabled", false);
		} else {
			$("#select-words-finish-btn").prop("disabled", true);
			showOrHideResults("hide");
		}
	}

	function showOrHideResults(string) {
		if (string == "show") {
			$("#awfs-suc-war-err-container").removeClass("d-none");
		} else {
			$("#awfs-suc-war-err-container").addClass("d-none");
		}
	}

	function displaySelectedWord(text, id) {
		return "<button type='button' class='btn btn-light teacher-selected-word mr-2'>" +
	  				 text +
						 " <span class='fa fa-remove text-danger'></span>" +
	  			 	 "<span class='sr-only'>unread messages</span>" +
					 "</button>";
	}

	function tagName() {
		return $("#tag_name").val();
	}

	function selectedClassroomNames() {
		return $("#select-multi-classrooms").val();
	}

	function selectedUsernames() {
		return $("#select-multi-individual-students").val();
	}

	function numClassrooms() {
		if (selectedClassroomNames() == null) {
			return 0;
		} else {
			return selectedClassroomNames().length;
		}
	}

	function hasSelectedClassrooms() {
		return numClassrooms() > 0;
	}

	function numUsernames() {
		if (selectedUsernames() == null) {
			return 0;
		} else {
			return selectedUsernames().length;
		}
	}

	function hasSelectedUsernames() {
		return numUsernames() > 0;
	}

	function classLength(_class) {
		return $(_class).length;
	}

	function sendToRails() {
		var selectedWordIDs = $("#selected-words-ids").html();
		var myLeksi_info = {
			"classroom_names": selectedClassroomNames(),
			"individual_usernames": selectedUsernames(),
			"word_ids": selectedWordIDs,
			"tag_name": tagName()
		};

		$.ajax({
			type: "PATCH",
			url: "/school/add_words_for_student",
			dataType: "json",
			data: myLeksi_info,
			success: function(response) {
				$("#select-words-finish-btn, .row:first").remove();
				$("#awfs-step-1-div, #awfs-step-2-div, #awfs-step-3-div").remove();
				display_results(
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

	function display_results(
		num_warnings,
		num_successes,
		num_errors,
		warnings,
		successes,
		errors
	) {
		$("#add-more-words-btn").removeClass("d-none");
		$("#success-results, #warning-resultss, #error-resultss").empty();

		$.each(successes, function(index, value) {
			$("#success-results").append(value, "<hr>");
		});
		$("#num-successes").html(num_successes);


		$.each(warnings, function(index, value) {
			$("#warning-results").append(value, "<hr>");
		});
		$("#num-warnings").html(num_warnings);

		$.each(errors, function(index, value) {
			$("#error-results").append(value, "<hr>");
		});
		$("#num-errors").html(num_errors);
	}
});
