$(document).ready(function() {
	$("#select-multi-classrooms").change(function() {
		$(".num-classrooms").html(numClassrooms());
	});

	$(".search-results-container").on("click", ".awfs-add-word-btn", function(e) {
		e.preventDefault();
		var $index = 0;
		var wordID = $(this).data('word-id');
		var wordName = $(this).data('word-name');
		var numSelected = classLength(".teacher-selected-word") + 1;
		$(".num-words-selected").html(numSelected);
		var $word = displaySelectedWord(wordName, wordID);
		$("#selected-words").append($word);
		$("#selected-words-ids").append(wordID + ",");
		var $dd = $("dd[data-word-id='" + wordID + "']");
		var $message = createElem("span").append(
			"Successfully added to the queue above."
		);
		$dd.html(createFlash("success", $message));
		activateOrDeactivateFinishBtn(numSelected);
	});

	$("#teacher-words").on("click", ".teacher-selected-word", function() {
		numSelected = classLength(".teacher-selected-word") - 1;
		$(".num-words-selected").html(numSelected);
		var selectedWordIDs = $("#selected-words-ids").html();
		var $id = selectedWordIDs.split(",")[$(this).index()];
		var updatedWordIDs = selectedWordIDs.replace($id + ",", "");
		$("#selected-words-ids").html(updatedWordIDs);
		$(this).remove();
		activateOrDeactivateFinishBtn(numSelected);
	});

	$("#select-words-finish-btn").click(function() {
		showOrHideResults("show");
		sendToRails();
	});

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

	function activateOrDeactivateFinishBtn(numSelected) {
		if (numSelected > 0) {
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

	function selectedClassroomNames() {
		return $("#select-multi-classrooms").val();
	}

	function numClassrooms() {
		if (selectedClassroomNames() == null) {
			return 0;
		} else {
			return selectedClassroomNames().length;
		}
	}

	function classLength(_class) {
		return $(_class).length;
	}

	function sendToRails() {
		var selectedWordIDs = $("#selected-words-ids").html();
		var myLeksi_info = {
			"names": selectedClassroomNames(),
			"word_ids": selectedWordIDs
		};

		$.ajax({
			type: "PATCH",
			url: "/school/add_words_for_student",
			dataType: "json",
			data: myLeksi_info,
			success: function(response) {
				$("#select-words-finish-btn").remove();
				$("#awfs-step-1-div, #awfs-step-2-div").remove();
				display_results(
					response.num_words,
					response.num_students,
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
		num_words,
		num_stu,
		num_warnings,
		num_successes,
		num_errors,
		warnings,
		successes,
		errors
	) {
		$("#add-more-words-btn").removeClass("d-none");
		$("#success-results, #warning-resultss, #error-resultss").empty();
		$("#finish-stats").html(
			"<small> Students (" + num_stu + ") " + "Words (" + num_words +
			")</small>"
		);

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
