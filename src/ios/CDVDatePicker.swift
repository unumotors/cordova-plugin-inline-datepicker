//
//  CDVDatePicker.swift
//  
//
//  Created by Can Kınay on 21/02/2017.
//
//

import Foundation

@objc(CDVDatePicker) class CDVDatePicker : CDVPlugin {

    override func pluginInitialize() {
        DatePickerManager.commandDelegate = self.commandDelegate
        DatePickerManager.view = self.webView.scrollView
    }
    
    func create(_ command: CDVInvokedUrlCommand) {
        let newDatePicker = DatePickerManager.sharedInstance.createWithOptions(parseOptions(command))
        
        let result = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: ["id": newDatePicker.id, "date": newDatePicker.timestampInMs, "initial": true]
        )
        result!.setKeepCallbackAs(true)

        self.commandDelegate!.send(result, callbackId: command.callbackId)
    }
    
    func update(_ command: CDVInvokedUrlCommand) {
        let options = parseOptions(command)

        DatePickerManager.sharedInstance.update(options)
    }

    func show(_ command: CDVInvokedUrlCommand) {
        let options = parseOptions(command)

        DatePickerManager.sharedInstance.update(options)
        DatePickerManager.sharedInstance.show(options.id)

        self.commandDelegate!.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK
            ),
            callbackId: command.callbackId
        )
    }

    func hide(_ command: CDVInvokedUrlCommand) {
        if let ids = (command.arguments[0] as? [String: Any])?["ids"] as? [String] {
            ids.forEach({ (id) in
                DatePickerManager.sharedInstance.hide(id)
            })
        } else {
            DatePickerManager.sharedInstance.hide(parseOptions(command).id)
        }

        self.commandDelegate!.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK
            ),
            callbackId: command.callbackId
        )
    }

    func remove(_ command: CDVInvokedUrlCommand) {
        if let ids = (command.arguments[0] as? [String: Any])?["ids"] as? [String] {
            ids.forEach({ (id) in
                DatePickerManager.sharedInstance.remove(id)
            })
        } else {
            DatePickerManager.sharedInstance.remove(parseOptions(command).id)
        }
        
        self.commandDelegate!.send(
            CDVPluginResult(
                status: CDVCommandStatus_OK
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
        let options = command.arguments[0] as! [String: Any]

        let mode : UIDatePickerMode
        if let intMode = options["mode"] as? Int {
            mode = UIDatePickerMode(rawValue: intMode)!
        } else {
            mode = .date
        }
        
        let frame : CGRect?;
        if let x = options["x"] as? Int, let y = options["y"] as? Int, let width = options["width"] as? Int, let height = options["height"] as? Int {
            frame = CGRect(
                x: x,
                y: y,
                width: width,
                height: height
            )
        } else {
            frame = nil
        }

        return DatePickerOptions(
            id: options["id"] as! String,
            callbackId: command.callbackId,
            allocOnly: options["allocOnly"] as? Bool ?? false,
            removesAllOthers: options["removesAllOthers"] as? Bool ?? false,
            date: parseDateString(options["date"] as? String),
            locale: nil,
            timeZone: nil,
            mode: mode,
            maximumDate: parseDateString(options["maximumDate"] as? String),
            minimumDate: parseDateString(options["minimumDate"] as? String),
            minuteInterval: (options["minuteInterval"] as? Int) ?? 1,
            isEnabled: options["isEnabled"] as? Bool ?? true,
            backgroundColor: nil,
            alpha: CGFloat(options["alpha"] as? Float ?? 1.0),
            frame: frame,
            isHidden: options["isHidden"] as? Bool
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
