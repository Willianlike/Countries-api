//
//  ThrowingJSON.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import SwiftyJSON

extension JSON {
    public func reqString() throws -> String {
        switch self.type {
        case .number:
            return self.numberValue.stringValue
        case .string:
            return self.stringValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "String")
        }
    }

    public func reqInt() throws -> Int {
        switch self.type {
        case .number:
            return self.intValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "Int")
        }
    }
    
    public func reqFloat() throws -> Float {
        switch self.type {
        case .number:
            return self.floatValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "Float")
        }
    }
    
    public func reqDouble() throws -> Double {
        switch self.type {
        case .number:
            return self.doubleValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "Double")
        }
    }

    public func reqArray() throws -> [JSON] {
        switch self.type {
        case .array:
            return self.arrayValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "Array")
        }
    }

    public func reqDictionary() throws -> [String : JSON] {
        switch self.type {
        case .dictionary:
            return self.dictionaryValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "Dictionary")
        }
    }

    public func reqURL() throws -> URL {
        switch self.type {
        case .string:
            if let url = self.url {
                return url
            } else {
                throw JSONDecodeError.wrongValueType(requested: "URL")
            }
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "URL")
        }
    }

    public func reqBool() throws -> Bool {
        switch self.type {
        case .bool:
            return self.boolValue
        case .null:
            throw JSONDecodeError.missingValue
        default:
            throw JSONDecodeError.wrongValueType(requested: "Bool")
        }
    }
}
