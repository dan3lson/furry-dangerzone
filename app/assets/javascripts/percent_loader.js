$(document).ready(function(){
	// percentage_loader(".fund-show-game-circle", 95, 95, .69);

	function percentage_loader(selector, width, height, progress) {
		$(selector).percentageLoader({
			width : width,
			height : height,
			progress : progress,
			value : ''
		});
	}
});
