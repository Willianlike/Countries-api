//
//  NumberFormatter.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
