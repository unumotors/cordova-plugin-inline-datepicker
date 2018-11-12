var exec = require('cordova/exec');

// Calculate viewport scale
var viewportScale = screen.width / window.innerWidth;

exports.create = function(element, options, success, error) {
  options = parseOptions(element, options);

  element && element.setAttribute && element.setAttribute('data-datepicker-id', options.id);
  exec(success, error, 'CDVDatePicker', 'create', [options]);

  return options.id;
};

exports.show = function(element, options, success, error) {
  options = parseOptions(element, options);

  exec(success, error, 'CDVDatePicker', 'show', [options]);
}

exports.hide = function(element, options, success, error) {
  options = parseOptions(element, options);

  exec(success, error, 'CDVDatePicker', 'hide', [options]);
}

exports.hideAll = function (root, success, error) {
  root = root || document;
  var ids = Array.from(root.querySelectorAll('[data-datepicker-id]') || [])
    .map(function (element) {
      return element.getAttribute('data-datepicker-id');
    });
  if (ids.length)
    exec(success, error, 'CDVDatePicker', 'hide', [{ ids: ids }]);
}

exports.remove = function (root, success, error) {
  root = root || document;
  var ids = Array.from(root.querySelectorAll('[data-datepicker-id]') || [])
    .map(function (element) {
      return element.getAttribute('data-datepicker-id');
    });
  if (ids.length)
    exec(success, error, 'CDVDatePicker', 'remove', [{ ids: ids }]);
}

exports.removeById = function (id, success, error) {
  var ids = Array.isArray(id) ? id : [id];
  exec(success, error, 'CDVDatePicker', 'remove', [{ ids: ids }]);
}

exports.removeAll = function (success, error) {
  exec(success, error, 'CDVDatePicker', 'removeAll', []);
}

exports.Mode = {
  // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
  TIME: 0,

  // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
  DATE: 1,

  // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
  DATE_AND_TIME: 2,

  // Displays hour and minute (e.g. 1 | 53)
  COUNTDOWN_TIMER: 3
};

function parseOptions(element, options) {
  var elementRect = getElementRect(element);
  options = options || {};
  options.id = options.id || element && element.getAttribute && element.getAttribute('data-datepicker-id') || Date.now().toString(36);
  options.x = options.x || elementRect.left || 0;
  options.y = options.y || elementRect.top || 0;
  options.width = options.width || elementRect.width;
  options.height = options.height || elementRect.height;

  return options;
}

function getElementRect(elm) {
  if (!elm)
    return {};
  var pageRect = getPageRect();

  var rect = elm.getBoundingClientRect();
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
