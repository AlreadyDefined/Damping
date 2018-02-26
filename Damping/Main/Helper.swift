//
//  Helper.swift
//  Damping
//
//  Created by Ирина Филиппова on 26.02.2018.
//  Copyright © 2018 Ирина Филиппова. All rights reserved.
//

import Foundation

class Helper {
    static func ShowAlert(messageText: String, alertStyle: NSAlert.Style, informativeText: String? = nil) {
        let alert = NSAlert()
        alert.messageText = messageText
        if (informativeText != nil) {
            alert.informativeText = informativeText!
        }
        alert.alertStyle = alertStyle
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
