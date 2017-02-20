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
    
    private var datePickerDict: [Int: DatePicker] = [:]
    private var counter: Int = 0
    static var commandDelegate: CDVCommandDelegate?

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onChange), name: NSNotification.Name(rawValue: "DatePickerChanged"), object: nil)
    }
    
    func createWithOptions(_ options : DatePickerOptions) -> DatePicker {
        let newDatePicker = DatePicker(id: counter, options: options)
        
        datePickerDict[counter] = newDatePicker
        counter += 1
        
        return newDatePicker;
    }
    
    @objc func onChange(notification: Notification) {
        let id = (notification.userInfo?["id"] as? Int) ?? 0
        let timestamp = Int((notification.userInfo?["date"] as? Date)?.timeIntervalSince1970 ?? 0)
        DatePickerManager.commandDelegate?.evalJs("cordova.fireWindowEvent('datePickerChanged', { id: \(id), date: new Date(\(timestamp)000) })")
    }
    
    func removeAll() {
        for datePicker in datePickerDict.values {
            datePicker.remove()
        }
        datePickerDict.removeAll()
    }
}
