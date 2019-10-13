//
//  CountriesListView.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import UIKit
import Cartography

class CountriesListView: UIView {
    
    let tableView = UITableView()
    let refresher = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        
        constrain(self, tableView) { (view, table) in
            table.edges == view.edges
        }
        
        tableView.register(CountryTableCell.self,
                           forCellReuseIdentifier: CountryTableCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorInset.left = 16
        
        tableView.refreshControl = refresher
    }
    
}
