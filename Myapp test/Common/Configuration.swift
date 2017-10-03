//
//  Configuration.swift
//  IOS Project Starter
//
//  Created by Valentina Iancu on 05/09/2017.
//  Copyright © 2017 Valentina Iancu. All rights reserved.
//

import Foundation

enum Environment: String {
    case debug = "Debug"
    case qa = "QA"
    case staging = "Staging"
    case release = "Release"
}

class Configuration {
    static let sharedInstance = Configuration()

    lazy var environment: Environment = {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
            let environment = Environment(rawValue: configuration) else {
                return Environment.debug
        }
        return environment
    }()
}
