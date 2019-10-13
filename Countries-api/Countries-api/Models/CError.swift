//
//  CError.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation

enum CError: Error {
    case allResponse
    case detailResponse
    case networkError
    
    var localizedDescription: String {
        switch self {
        case .allResponse:
            return "An error occurred while requesting all countries"
        case .detailResponse:
            return "An error occurred while requesting detail info"
        case .networkError:
            return "Network error"
        }
    }
}
