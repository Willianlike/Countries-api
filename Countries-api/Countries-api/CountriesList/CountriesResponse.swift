//
//  CountriesResponse.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CountriesResponse: JSONDecodable {
    
    let countries: [CountryModel]
    
    init(json: JSON) throws {
        countries = json.arrayValue.compactMap({ try? CountryModel(json: $0) })
    }
    
}
