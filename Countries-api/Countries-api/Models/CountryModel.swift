//
//  ShortCountryModel.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxDataSources

struct CountryModel: JSONDecodable {
    
    let name: String
    let capital: String
    let borders: [String]
    let currencies: [String]
    let nativeName: String
    let population: Int
    
    init(json: JSON) throws {
        name = try json["name"].reqString()
        capital = try json["capital"].reqString()
        borders = json["borders"].arrayValue.compactMap({ $0.string })
        currencies = json["currencies"].arrayValue.compactMap({ json -> String? in
            if let code = json["code"].string,
                let symbol = json["symbol"].string {
                return symbol + " - " + code
            }
            return nil
        })
        nativeName = try json["nativeName"].reqString()
        population = try json["population"].reqInt()
    }
    
}

extension CountryModel: IdentifiableType {
    typealias Identity = String
    var identity: String {
        return name + nativeName + "\(population)"
    }
    
    func getSections() -> [DetailSection] {
        var sections = [DetailSection]()
        let name = self.name.isEmpty ? "-" : self.name
        let nativeName = self.nativeName.isEmpty ? "-" : self.nativeName
        let capital = self.capital.isEmpty ? "-" : self.capital
        let borders = self.borders.isEmpty ? ["-"] : self.borders
        let currencies = self.currencies.isEmpty ? ["-"] : self.currencies
        sections.append(DetailSection(model: "Country name",
                                      items: [name]))
        sections.append(DetailSection(model: "Native name",
                                      items: [nativeName]))
        sections.append(DetailSection(model: "Capital",
                                      items: [capital]))
        sections.append(DetailSection(model: "Population",
                                      items: ["\(self.population.formattedWithSeparator)"]))
        sections.append(DetailSection(model: "Border countries",
                                      items: borders))
        sections.append(DetailSection(model: "Country currencies",
                                      items: currencies))
        return sections
    }
}
