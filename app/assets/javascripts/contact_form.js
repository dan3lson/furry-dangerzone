$(document).ready(function() {
	$random_string_element = "form strong";
	$($random_string_element).html(createRandomString());
	var $random_string = $($random_string_element).html();
	validateTextField("#cf-name");
	validateTextField("#cf-email");
	validateTextField("#cf-subject");
	validateTextField("#cf-message");
	validateHumanSubmission("#prove-ur-human-field", $random_string);

	function createRandomString() {
		var $alphabet_lower_array = "abcdefghjkmnpqrstuvwxyz".split('');
		var $alphabet_upper_array = "ABCDEFGHJKLMNPQRSTUVXYZ".split('');
		var $merged_alphabet = $.merge($.merge([], $alphabet_lower_array),
      $alphabet_upper_array
    );
		var $numbers_array = "123456789".split('');
		var $random_characters = [];

		for (var i = 0; i < 2; i++) {
			var $random_letter = $merged_alphabet[randomRange(50,0)];
			var $random_number = $numbers_array[randomRange(9,0)];
			$random_characters.push($random_letter);
			$random_characters.push($random_number);
		}

		return $random_characters.join('');
	}

	function randomRange (x, y) {
		return Math.floor(Math.random() * (x-y) + y);
	};

	function validateHumanSubmission(input_selector, string) {
		var $word_being_spelled;

		$(input_selector).on("input", function() {
			$word_being_spelled = $.trim($(this).val());

			if ($word_being_spelled == string) {
				inputValidation(input_selector, "success");
				validateFormFields("#cf-submit-btn");
			} else {
				inputValidation(input_selector, "danger");
				validateFormFields("#cf-submit-btn");
			}
		});
	}

	function validateTextField(field_input_selector) {
		var $regex = /^[a-zA-Z0-9 .';,:?!()@-]+$/;

		$(field_input_selector).on("input", function() {
			$text = $.trim($(this).val());

			if ($text != "" && $regex.test($text)) {
				inputValidation(this, "success");
				validateFormFields("#cf-submit-btn");
			} else {
				inputValidation(this, "danger");
				validateFormFields("#cf-submit-btn");
			}
		});
	}

	function validateFormFields(btn_selector) {
		if($(".has-success").length == 5) {
			$(btn_selector).attr("disabled", false);
		} else {
			$(btn_selector).attr("disabled", true);
		}
	}

	function inputValidation(field_selector, className) {
		$(field_selector).removeClass("form-control-danger")
										 .removeClass("form-control-warning")
										 .removeClass("form-control-success")
										 .addClass("form-control-" + className);
		$(field_selector).parent().removeClass("has-danger")
															.removeClass("has-warning")
															.removeClass("has-success")
															.addClass("has-" + className);
	}
});
