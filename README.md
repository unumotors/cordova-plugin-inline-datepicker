# Cordova Inline DatePicker Plugin

Allows you to display inline native date picker over your Cordova application.

## Usage

```js
cordova.plugins.DatePicker.create(htmlElement, options, callback);
```

Creates native date picker view (UIDatePickerView) over given element's position and size with given options. Callback function is called everytime date/time value from date picker is changed.

### Example:

```html
<div class="date-label">No date selected</div>
<div class="inline-datepicker"></div>
```

```js
cordova.plugins.DatePicker.create(
    document.querySelector('.inline-datepicker'),
    {
        'id': 'date-from-picker-1', // this should be the unique identifier of the picker
        'mode': cordova.plugins.DatePicker.Mode.DATE, // default is DATE_AND_TIME
        'date': new Date('2016-11-24T'),
        'minimumDate': new Date()
    },
    function (data) {
        // this callback is called everytime input is changed
        document.querySelector('.date-label').innerText = new Date(data.date).toLocalDateString();
    }
);
```

To remove a single picker:

```js
cordova.plugins.DatePicker.removeById(
    'date-from-picker-1'
);
```


To remove multiple pickers:
```js
cordova.plugins.DatePicker.removeById(
    ['date-from-picker-1', 'date-from-picker-2']
);
```

## Methods

```js
cordova.plugins.DatePicker.show(element, options, success, error); // Sets isHidden option to false for given element.
cordova.plugins.DatePicker.hide(element, options, success, error); // Sets isHidden option to true for given element.
cordova.plugins.DatePicker.remove(element, options, success, error); // Removes date picker view bound to given element.
cordova.plugins.DatePicker.hideAll(element, success, error); // Hides all date pickers bound to given element and it's children.
cordova.plugins.DatePicker.removeAll(success, error); // Removes all date picker instances.
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

### `isHidden`

Type: `Boolean`

Default value: `false`

When given `true`, picker is created but not shown in screen.

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
