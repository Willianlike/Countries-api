//
//  Coordinator.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import UIKit

class Coordinator {
    
    weak var navigation: MainNavigationVC?
    
    func openDetailInfo(for country: CountryModel) {
        if let navigation = navigation {
            navigation.pushViewController(getDetailInfoVC(for: country), animated: true)
        }
    }
    
    private func getDetailInfoVC(for country: CountryModel) -> DetailInfoVC {
        return DetailInfoVC(name: country.name)
    }
    
}
