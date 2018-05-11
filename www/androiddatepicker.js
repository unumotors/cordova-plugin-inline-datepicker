var datePickerDict = {};

exports.create = function(element, options, success, error) {
      options = options || {};
      let optionsId = options.id || element && element.getAttribute && element.getAttribute('data-datepicker-id') || Date.now().toString(36);
      element && element.setAttribute && element.setAttribute('data-datepicker-id', optionsId);
      const dateValue = (options.date || new Date()).toISOString().substring(0, 16);
      let parentElement = element.parentElement;

      var newDatePicker = document.createElement('INPUT');
      newDatePicker.setAttribute('type', 'datetime-local');
      newDatePicker.setAttribute('name', optionsId);
      newDatePicker.setAttribute('id', optionsId);
      newDatePicker.value = dateValue;
      newDatePicker.min = dateValue;
      newDatePicker.setAttribute('style', 'color: none; padding: 0; -webkit-appearance: menulist; background-color: transparent; margin: -30px; margin-right: -200px; width: inherit; height: inherit;');

      if (parentElement) {
          parentElement.innerHTML = '';
          parentElement.appendChild(newDatePicker);
      }

      datePickerDict[optionsId] = success;

      newDatePicker.onchange = function(event) {
          const pickerId = event.srcElement.id || 'no-id';
          const dateInDateTime = parseISOString(event.srcElement.value);
          const callbackFunc = datePickerDict[pickerId];

          const datePickerInfo = [];
          datePickerInfo['id'] = pickerId;
          datePickerInfo['date'] = dateInDateTime.getTime() || 0;
          datePickerInfo['initial'] = true;
          callbackFunc(datePickerInfo);
    };
      return newDatePicker;
  };

  function parseISOString(s) {
      var b = s.split(/\D+/);
      return new Date(Date.UTC(b[0], --b[1], b[2], b[3], b[4], b[5] || 0, b[6] || 0));
  }

  exports.show = function(element, options, success, error) {
  }

  exports.hide = function(element, options, success, error) {
  }

  exports.hideAll = function (root, success, error) {
  }

  exports.remove = function (root, success, error) {
  }

  exports.removeAll = function (success, error) {
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
