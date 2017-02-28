//
//  InDatePicker.swift
//  
//
//  Created by Can Kınay on 21/02/2017.
//
//

import UIKit

class DatePicker {
    private var view: UIDatePicker
    
    let id : String
    let callbackId : String
    
    var timestampInMs : Int {
        get {
            return Int(view.date.timeIntervalSince1970) * 1000
        }
    }
    
    init(options: DatePickerOptions) {
        self.id = options.id
        callbackId = options.callbackId
        view = UIDatePicker(frame: options.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0))
        update(options)
        view.addTarget(self, action:#selector(onChange(sender:)), for: .valueChanged)
    }
    
    func show() {
        view.isHidden = false
    }
    
    func hide() {
        view.isHidden = true
    }
    
    func appendTo(_ parent: UIView) {
        parent.addSubview(view)
    }
    
    @objc func onChange(sender : UIDatePicker) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DatePickerChanged"), object: nil, userInfo: ["id": id, "date": timestampInMs, "callbackId": callbackId])
    }
    
    func update(_ options: DatePickerOptions) {
        if let isEnabled = options.isEnabled {
            view.isEnabled = isEnabled
        }
        
        if let datePickerMode = options.mode {
            view.datePickerMode = datePickerMode
        }
        
        if let frame = options.frame {
            view.frame = frame
        }
        
        if let isHidden = options.isHidden {
            view.isHidden = isHidden
        }
        
        if let date = options.date {
            view.date = date
        }
        
        if let minimumDate = options.minimumDate {
            view.minimumDate = minimumDate
        }
        
        if let maximumDate = options.maximumDate {
            view.maximumDate = maximumDate
        }
        
        if let minuteInterval = options.minuteInterval {
            view.minuteInterval = minuteInterval
        }
        
        if let backgroundColor = options.backgroundColor {
            view.backgroundColor = backgroundColor
        }
        
        if let alpha = options.alpha {
            view.alpha = alpha
        }
    }
    
    func remove() {
        view.removeFromSuperview()
    }
}

struct DatePickerOptions {

    // CDVDatePicker specific attributes
    var id : String
    var callbackId : String
    var allocOnly : Bool = false
    var removesAllOthers : Bool = false

    // UIDatePicker attributes
    var date: Date? = Date()
    var locale: Locale?
    var timeZone: TimeZone?
    var mode: UIDatePickerMode?
    var maximumDate: Date?
    var minimumDate: Date?
    var minuteInterval: Int? = 1

    // UIControl attributes
    var isEnabled: Bool?

    // UIView attributes
    var backgroundColor: UIColor?
    var alpha: CGFloat?
    var frame: CGRect?
    var isHidden: Bool?
}
