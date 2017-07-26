//
//  APIConfiguration.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation

private enum BuildMode {
    case Debug
    case Production
}

struct APIConfiguration {
    fileprivate let buildMode: BuildMode
    init() {
        buildMode = .Debug
        //        #if DEBUG
        //
        //        #else
        //            buildMode = .Production
        //        #endif
    }

    func baseServerURL() -> URL {
        switch buildMode {
        case .Debug:
            return URL(string: "http://")!
        case .Production:
            return URL(string: "http://")!
        }
    }
}
