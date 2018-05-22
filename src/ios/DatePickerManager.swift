//
//  DatePickerManager.swift
//  
//
//  Created by Can Kınay on 21/02/2017.
//
//

import Foundation

class DatePickerManager {
    static let sharedInstance = DatePickerManager()
    
    private var datePickerDict: [String: DatePicker] = [:]
    static var commandDelegate: CDVCommandDelegate?
    static var view: UIView?

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onChange), name: NSNotification.Name(rawValue: "DatePickerChanged"), object: nil)
    }
    
    func createWithOptions(_ options : DatePickerOptions) -> DatePicker {
        let newDatePicker = DatePicker(options: options)

        if options.removesAllOthers {
            DatePickerManager.sharedInstance.removeAll()
        }

        datePickerDict[options.id] = newDatePicker

        if !options.allocOnly {
            newDatePicker.appendTo(DatePickerManager.view!)
        }

        return newDatePicker;
    }
    
    func update(_ options: DatePickerOptions) {
        datePickerDict[options.id]?.update(options);
    }
    
    func show(_ id : String) {
        datePickerDict[id]?.show();
    }
    
    func hide(_ id: String) {
        datePickerDict[id]?.hide();
    }
    
    func remove(_ id: String) {
        if let pickerToRemove = datePickerDict[id] {
            pickerToRemove.remove()
            datePickerDict.removeValue(forKey: id)
        }
    }
    
    @objc func onChange(notification: Notification) {
        let id = (notification.userInfo?["id"] as? String) ?? "no-id"
        let timestamp = (notification.userInfo?["date"] as? Int64) ?? 0

        if let callbackId = notification.userInfo?["callbackId"] as? String {
            let result = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: ["id": id, "date": timestamp, "initial": false]
            )
            result!.setKeepCallbackAs(true)
            DatePickerManager.commandDelegate!.send(result, callbackId: callbackId)
        }
    }
    
    func removeAll() {
        for datePicker in datePickerDict.values {
            datePicker.remove()
        }
        datePickerDict.removeAll()
    }
}
