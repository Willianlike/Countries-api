//
//  JSONDecodeError.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation

enum JSONDecodeError: Error {
    case missingValue
    case wrongValueType(requested: String?)
    case invalidValue
    case message(String)
}
