//
//  NetworkHelpers.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension ObservableType where E == Response {
    
    /** Maps data received from the signal into an object which implements the
     ALSwiftyJSONAble protocol.
     If the conversion fails, the signal errors.
     
     - Parameter type: Type of the mappable object
     
     - Returns: An Observable containing mapped object
     **/
    func mapObject<T: JSONDecodable>(type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type: T.self))
        }
    }
    
    /** Maps data received from the signal into an object which implements the
     ALSwiftyJSONAble protocol.
     If the conversion fails, the signal errors.
     
     - Parameter type: Type of the mappable object
     
     - Returns: An Observable containing mapped object
     **/
    func mapObjectSafe<T: JSONDecodable>(type: T.Type) -> Observable<T?> {
        return flatMap { response -> Observable<T?> in
            return Observable.just(response.mapObjectSafe(type: T.self))
        }
    }

    /** Maps data received from the signal into an array of objects which implement the ALSwiftyJSONAble protocol.
        If the conversion fails, the signal errors.

        - Parameter type: Type of element of mappable array

        - Returns: An Observable containing array of specified type
    **/
    func mapArray<T: JSONDecodable>(type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type: T.self))
        }
    }
}

extension Response {
    func mapObject<T: JSONDecodable>(type: T.Type) throws -> T {
        let object = try mapJSON()
        let json = JSON(object)
        return try T(json: json)
    }
    func mapObjectSafe<T: JSONDecodable>(type: T.Type) -> T? {
        if let object = try? mapJSON() {
            let json = JSON(object)
            return try? T(json: json)
        } else {
            return nil
        }
    }

    func mapArray<T: JSONDecodable>(type: T.Type) throws -> [T] {
        let object = try mapJSON()
        let json = JSON(object)
        guard let array = json.array else {
            throw MoyaError.jsonMapping(self)
        }

        return try array.compactMap { try T(json: $0) }
    }
}
