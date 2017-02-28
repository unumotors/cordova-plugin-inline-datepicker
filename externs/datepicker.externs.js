var cordova = {};
cordova.plugins = {};
cordova.plugins.DatePicker = {};

/**
 * @param {Element} element
 * @param {Object=} options
 * @param {?function(Object)=} success Returns date picker id
 * @param {?Function=} error
 */
cordova.plugins.DatePicker.create = function(element, options, success, error) {};
/**
 * @param {Element} element
 * @param {Object=} options
 * @param {?function(Object)=} success
 * @param {?Function=} error
 */
cordova.plugins.DatePicker.show = function(element, options, success, error) {};

/**
 * @param {Element} element
 * @param {Object=} options
 * @param {?function(Object)=} success
 * @param {?Function=} error
 */
cordova.plugins.DatePicker.hide = function(element, options, success, error) {};

/**
 * @param {?Element=} root Root element to search for date pickers to hide. Defaults to document.
 * @param {?Function=} success
 * @param {?Function=} error
 */
cordova.plugins.DatePicker.hideAll = function(root, success, error) {};

/**
 * @param {?Element=} root Root element to search for date pickers to remove. Defaults to document.
 * @param {?Function=} success
 * @param {?Function=} error
 */
cordova.plugins.DatePicker.remove = function(root, success, error) {};

/**
 * @param {?Function=} success
 * @param {?Function=} error
 */
cordova.plugins.DatePicker.removeAll = function(success, error) {};

/**
 * @enum {Number}
 */
cordova.plugins.DatePicker.Mode = {
    TIME: 0,
    DATE: 1,
    DATE_AND_TIME: 2,
    COUNTDOWN_TIMER: 3
};

/**
 * @constructor
 * @extends {Event}
 */
cordova.plugins.DatePicker.DatePickerChangedEvent = function() {};

/**
 * @type {!Number}
 */
cordova.plugins.DatePicker.DatePickerChangedEvent.prototype.id;

/**
 * @type {!Date}
 */
cordova.plugins.DatePicker.DatePickerChangedEvent.prototype.date;
