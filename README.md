# Cordova Inline DatePicker Plugin

Allows you to display inline native date picker over your Cordova application.

## Usage

```js
cordova.plugins.DatePicker.create(htmlElement, options, callback);
```

Creates native date picker view (UIDatePickerView) over given element's position and size with given options. Callback function is called with an identification number which is used in events.

### Example:

```html
<div class="date-label">No date selected</div>
<div class="inline-datepicker"></div>
```

```js
cordova.plugins.DatePicker.create(
    document.querySelector('.inline-datepicker'),
    {
        'mode': cordova.plugins.DatePicker.Mode.DATE, // default is DATE_AND_TIME
        'date': new Date('2016-11-24T'),
        'minimumDate': new Date()
    },
    function (datePickerId) {
        document.querySelector('.date-label').id = 'date-picker-' + datePickerId;
    }
);

window.addEventListener('datePickerChanged', function (e) {
    var targetDatePickerLabel = document.querySelector('#date-picker-' + e.id);

    if (targetDatePickerLabel)
        targetDatePickerLabel.innerText = e.value.toDateString();
}, false);
```

## Options

All options are optional.

### `date`

Type: `Date|number`

Default value: `new Date()`

Initial date to show in date picker. Should be a JavaScript date object or UNIX timestamp integer.

### `removesAllOthers`

Type: `Boolean`

Default value: `false`

When given `true` removes all other instance of inline date pickers are removed from the web view.

### `mode`

Type: `number|cordova.plugin.DatePicker.Mode`

Default value: `cordova.plugin.DatePicker.Mode.DATE_AND_TIME`

The mode determines whether dates, times, or both dates and times are displayed. You can also use it to specify the appearance of a countdown timer.

### `maximumDate`

Type: `Date|number`

Default value: `null`

The maximum date that a date picker can show.

### `minimumDate`

Type: `Date|number`

Default value: `null`

The minimum date that a date picker can show.

### `minuteInterval`

Type: `number`

Default value: `1`

The interval at which the date picker should display minutes.

### `isEnabled`

Type: `boolean`

Default value: `true`

A Boolean value indicating whether the control is enabled.
