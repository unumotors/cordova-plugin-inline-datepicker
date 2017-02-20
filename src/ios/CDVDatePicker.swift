//
//  CDVDatePicker.swift
//  
//
//  Created by Can Kınay on 21/02/2017.
//
//

import Foundation

@objc(CDVDatePicker) class CDVDatePicker : CDVPlugin {

    func create(_ command: CDVInvokedUrlCommand) {
        let options = parseOptions(command)

        if options.removesAllOthers {
            DatePickerManager.sharedInstance.removeAll()
        }

        let newDatePicker = DatePickerManager.sharedInstance.createWithOptions(options)
        
        newDatePicker.appendTo(self.webView.scrollView)
        
        DatePickerManager.commandDelegate = self.commandDelegate

        self.commandDelegate!.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: Int32(newDatePicker.id)
            ),
            callbackId: command.callbackId
        )
    }

    func removeAll(_ command: CDVInvokedUrlCommand) {
        DatePickerManager.sharedInstance.removeAll()

        self.commandDelegate!.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK
            ),
            callbackId: command.callbackId
        )
    }

    private func parseOptions(_ command: CDVInvokedUrlCommand) -> DatePickerOptions {
        let options = command.arguments[0] as? [String: Any]

        let mode : UIDatePickerMode
        if let intMode = options?["mode"] as? Int {
            mode = UIDatePickerMode(rawValue: intMode)!
        } else {
            mode = .date
        }

        return DatePickerOptions(
            removesAllOthers: options?["removesAllOthers"] as? Bool ?? false,
            date: parseDateString(options?["date"] as? String),
            locale: nil,
            timeZone: nil,
            mode: mode,
            maximumDate: parseDateString(options?["maximumDate"] as? String),
            minimumDate: parseDateString(options?["minimumDate"] as? String),
            minuteInterval: (options?["minuteInterval"] as? Int) ?? 1,
            isEnabled: options?["isEnabled"] as? Bool ?? true,
            backgroundColor: nil,
            alpha: CGFloat(options?["alpha"] as? Float ?? 1.0),
            frame: CGRect(
                x: options?["x"] as? Int ?? 0,
                y: options?["y"] as? Int ?? 0,
                width: options?["width"] as? Int ?? 300,
                height: options?["height"] as? Int ?? 250
            )
        )
    }

    private func parseDateString(_ dateString : String?) -> Date? {
        if dateString == nil {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        return dateFormatter.date(from: dateString!)!
    }
}
