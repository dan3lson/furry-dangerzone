$(document).ready(function() {
	var $form;
	var $inputText;
	var $inputChoices;
	var $inputAnswer;
	var $inputFeedback;

	$(".container").on("click", ".mean-alt-edit-btn", function() {
		var $card = $(this).parents(".card");
		var $cardText = $card.find(".card-text");
		var meaningAltID = $cardText.data("mean-alt-id");
		$.getScript("/school/meaning_alts/" + meaningAltID + "/edit");
	});

	$(".container").on("click", ".create-mean-alt-btn", function() {
		$form = $(this).parent();
		$btn = $form.find("button");
		$inputText = $($form[0].elements.meaning_alt_text);
		$inputChoices = $($form[0].elements.meaning_alt_choices);
		$inputAnswer = $($form[0].elements.meaning_alt_answer);
		$inputFeedback = $($form[0].elements.meaning_alt_feedback);
		clearErrors($form);

		if (anyFieldsEmpty()) {
			if (empty($inputText)) {
				showValidation($inputText, "Cannot be empty", "danger");
			}

			if (empty($inputChoices)) {
				showValidation($inputChoices, "Cannot be empty", "danger");
			}

			if (empty($inputAnswer)) {
				showValidation($inputAnswer, "Cannot be empty", "danger");
			}

			if (empty($inputFeedback)) {
				showValidation($inputFeedback, "Cannot be empty", "danger");
			}
		} else {
			$form.submit();
		}
	});

	function showValidation($input, string, className) {
		$input.siblings(".form-control-feedback").remove();
		$input.attr("class", "form-control form-control-" + className);
		$input.parent().attr("class", "form-group has-" + className);
		$(feedbackMessage(string)).insertAfter($input);
	}

	function feedbackMessage(text) {
		var formControlFeedback = "<div class='form-control-feedback'>";
		return formControlFeedback + text + ".</div>";
	};

	function anyFieldsEmpty() {
		return empty($inputText) ||
					 empty($inputAnswer) ||
					 empty($inputFeedback)
	}

	function empty($field) {
		return $field.val().trim() == "";
	}

  function clearErrors(form) {
    $(form).find(".form-group").removeClass("has-danger")
                               .removeClass("has-warning")
                               .removeClass("has-success");
    $(form).find("div.form-control-feedback").remove();
  }
});
