var exec = require('cordova/exec');

// Calculate viewport scale
var viewportScale = screen.width / window.innerWidth;

exports.create = function(element, options, success, error) {
    var elementRect = getElementRect(element);
    options = options || {};
    options.x = elementRect.left;
    options.y = elementRect.top;
    options.width = elementRect.width;
    options.height = elementRect.height;
    exec(success, error, 'CDVDatePicker', 'create', [options]);
};

exports.removeAll = function (success, error) {
    exec(success, error, 'CDVDatePicker', 'removeAll', []);
}

exports.Mode = {
    TIME: 0, // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)

    DATE: 1, // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)

    DATE_AND_TIME: 2, // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)

    COUNTDOWN_TIMER: 3 // Displays hour and minute (e.g. 1 | 53)
};


function getElementRect(div) {
  if (!div) {
    return;
  }

  var pageRect = getPageRect();

  var rect = div.getBoundingClientRect();
  return {
    'top': (rect.top + pageRect.top) * viewportScale,
    'left': (rect.left + pageRect.left) * viewportScale,
    'width': (rect.width) * viewportScale,
    'height': (rect.height) * viewportScale
  };
}

function getPageRect() {
  var doc = document.documentElement;

  var pageWidth = window.innerWidth ||
      document.documentElement.clientWidth ||
      document.body.clientWidth,
    pageHeight = window.innerHeight ||
      document.documentElement.clientHeight ||
      document.body.clientHeight;
  var pageLeft = (window.pageXOffset || doc.scrollLeft) - (doc.clientLeft || 0);
  var pageTop = (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);

  return {
    'top': pageTop,
    'left': pageLeft,
    'width': pageWidth,
    'height': pageHeight
  };
}
