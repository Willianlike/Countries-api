//
//  JSONDecodable.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import SwiftyJSON

protocol JSONDecodable {
    init(json: JSON) throws
}
