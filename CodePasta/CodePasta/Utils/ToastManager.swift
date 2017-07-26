//
//  ToastManager.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import SwiftMessages

protocol ToastManager {
    func showError(text: String)
    func showInfo(text: String)
}

extension ToastManager {
    func showError(text: String) {
        let view = defaultView(text: text)
        view.configureTheme(.error)
        SwiftMessages.show(config: defaultConfig(), view: view)
    }

    func showInfo(text: String) {
        let view = defaultView(text: text)
        view.configureTheme(.success)
        SwiftMessages.show(config: defaultConfig(), view: view)
    }

    fileprivate func defaultView(text: String) -> MessageView {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureDropShadow()
        view.configureContent(body: text)
        return view
    }

    fileprivate func defaultConfig() -> SwiftMessages.Config {
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .automatic
        config.interactiveHide = true
        return config
    }
}
