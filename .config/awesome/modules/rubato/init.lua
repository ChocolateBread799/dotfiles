RUBATO_DEF_RATE = 30
RUBATO_DIR = (...):match("(.-)[^%.]+$").."rubato."

return {
	set_def_rate = function(rate) RUBATO_DEF_RATE = rate end,
	timed = require(RUBATO_DIR.."timed"),
	easing = require(RUBATO_DIR.."easing"),
	subscribable = require(RUBATO_DIR.."subscribable"),
}