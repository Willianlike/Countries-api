//
//  APISessionManager.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import Alamofire

class APISessionManager: Alamofire.SessionManager {
    static let shared: APISessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return APISessionManager(configuration: configuration)
    }()
}
