$(document).ready(function() {
	$(".spe-bee-q-a").click(function() {
		$btn = $(this);
		$fa = $btn.find(".fa");
		$btn.next().slideToggle("fast");

		if ($fa.hasClass("fa-plus")) {
			$fa.removeClass("fa-plus").addClass("fa-minus");
		} else {
			$fa.removeClass("fa-minus").addClass("fa-plus");
		}

	});

	$(".spe-bee-nav").click(function(e) {
		e.preventDefault();
		var sectionName = $(this).text().trim();
		var section = $(".spe-bee-section").filter(function() {
			return $(this).find("h1").text().trim() == sectionName;
		});

		switch (sectionName) {
			case "Students":
				scrollToSection(section);
				break;
			case "Teachers":
				scrollToSection(section);
				break;
			case "Sponsors":
				scrollToSection(section);
				break;
			default: "Students"
		}
	});

	$(".spe-bee-contact-us").click(function(e) {
		e.preventDefault();
		var sectionName = $("#spe-bee-contact-us");
		var dataSubject = $(this).data("sub");

		// TODO: also add has-success class in order to validate
		// field count
		if (dataSubject == "stu") {
			updateValue("Question/Comment from a Student");
		} else if (dataSubject == "tea-reg") {
			updateValue("School Registration");
		} else if (dataSubject == "tea") {
			updateValue("Question/Comment from a Teacher");
		} else if (dataSubject == "spo-his") {
			updateValue("Sponsoring Your Event");
		} else if (dataSubject == "spo") {
			updateValue("Question/Comment from a Sponsor");
		} else {
			updateValue("");
		}

		scrollToSection(sectionName);
	});

	function updateValue(text) {
		var $subjectInput = $("#cf-subject");
		$subjectInput.val(text);
		$subjectInput.addClass("form-control-success");
		$subjectInput.parent().addClass("has-success");
	}

	function scrollToSection(section) {
		$("html, body").animate({ scrollTop: section.offset().top + 50 }, 1000);
	};
});
