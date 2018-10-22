
function targetSlidedown($target) {
	if($target.is(':hidden')) {
		$target.slideDown(500);
	}else {
		$target.slideUp(500);
	}
}
