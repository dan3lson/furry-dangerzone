$(document).ready(function() {
	var $form;
	var $inputText;
	var $inputAnswer;
	var $inputFeedback;

	$(".container").on("click", ".create-e-non-e-btn", function() {
		$form = $(this).parent();
		$btn = $form.find("button");
		$inputText = $($form[0].elements.example_non_example_text);
		$inputAnswer = $($form[0].elements.example_non_example_answer);
		$inputFeedback = $($form[0].elements.example_non_example_feedback);
		clearErrors($form);

		if (anyFieldsEmpty()) {
			if (empty($inputText)) {
				showValidation($inputText, "Cannot be empty", "danger");
			}

			if (empty($inputAnswer)) {
				showValidation($inputAnswer, "Cannot be empty", "danger");
			}

			if (empty($inputFeedback)) {
				showValidation($inputFeedback, "Cannot be empty", "danger");
			}
		} else {
			// Add data-attribute, e.g. "submitted-form", to locate after result?
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
