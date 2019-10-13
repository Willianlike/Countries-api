//
//  CountryTableCell.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import UIKit
import Cartography

class CountryTableCell: UITableViewCell, ReusableView {
    
    let name = UILabel()
    let nativeName = UILabel()
    let population = UILabel()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupCell(country: CountryModel) {
        name.text = country.name
        nativeName.text = country.nativeName
        population.text = "Population: \(country.population.formattedWithSeparator)"
    }
    
    private func setupUI() {
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        name.font = .b2()
        name.numberOfLines = 0
        name.textColor = .black
        
        nativeName.font = .b3()
        nativeName.numberOfLines = 0
        nativeName.textColor = .gray
        
        population.font = .b3()
        population.numberOfLines = 0
        population.textColor = .gray
        
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(nativeName)
        stackView.addArrangedSubview(population)
        constrain(contentView, stackView) { (contentView, stackView) in
            stackView.edges == inset(contentView.edges, 8, 16, 8, 8)
        }
        stackView.setEqualsWidth(for: name, population, nativeName)
    }
    
}
