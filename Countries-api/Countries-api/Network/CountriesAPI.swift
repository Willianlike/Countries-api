//
//  CountriesAPI.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Moya

enum CountriesAPI {
    case all
    case name(_ name: String)
}

extension CountriesAPI: TargetType {
    var baseURL: URL {
        var url = "https://restcountries.eu/rest/v2/"
        switch self {
        case .all:
            url += "all"
        case let .name(name):
            url += "name/\(name)"
        }
        return URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
