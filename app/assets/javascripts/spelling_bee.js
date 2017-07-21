$(document).ready(function() {
	function scrollToSection(section) {
		$("html, body").animate({ scrollTop: section.offset().top + 50 }, 1000);
	};
});
