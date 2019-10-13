//
//  UIView+extension.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import UIKit
import Cartography

extension UIView {
    
    func setEqualsWidth(for views: UIView...) {
        for view in views {
            constrain(view, self) { (view, sup) in
                view.width == sup.width
            }
        }
    }
    
}
