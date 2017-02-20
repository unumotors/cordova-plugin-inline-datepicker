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
    
    let id : Int
    
    init(id: Int, options: DatePickerOptions) {
        self.id = id
        view = UIDatePicker(frame: options.frame)
        update(options)
        view.addTarget(self, action:#selector(onChange(sender:)), for: .valueChanged)
    }
    
    func appendTo(_ parent: UIView) {
        parent.addSubview(view)
    }
    
    @objc func onChange(sender : UIDatePicker) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DatePickerChanged"), object: nil, userInfo: ["id": self.id, "date": sender.date])
    }
    
    func update(_ options: DatePickerOptions) {
        view.isEnabled = options.isEnabled
        view.datePickerMode = options.mode
        
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
    var removesAllOthers : Bool = false

    // UIDatePicker attributes
    var date: Date? = Date()
    var locale: Locale?
    var timeZone: TimeZone?
    var mode: UIDatePickerMode = .date
    var maximumDate: Date?
    var minimumDate: Date?
    var minuteInterval: Int? = 1

    // UIControl attributes
    var isEnabled: Bool = true

    // UIView attributes
    var backgroundColor: UIColor?
    var alpha: CGFloat?
    var frame: CGRect
}
