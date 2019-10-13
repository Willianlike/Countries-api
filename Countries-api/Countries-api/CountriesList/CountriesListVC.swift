//
//  CountriesListVC.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Cartography

class CountriesListVC: BaseVC {
    
    let viewModel = CountriesListVM()
    
    var listView: CountriesListView {
        return view as! CountriesListView
    }
    
    let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CountriesListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupModel()
    }
    
    private func setupUI() {
        title = "Countries"
        activityIndicator.startAnimating()
    }
    
    private func setupModel() {
        viewModel.requestAllCountries.onNext(())
        
        viewModel.refreshInProgress
            .bind(to: listView.refresher.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.loadingInProgress
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        listView.refresher.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.refreshAllCountries)
            .disposed(by: disposeBag)
        
        listView.tableView.rx.itemSelected
            .withLatestFrom(viewModel.countriesList) {($0, $1)}
            .subscribe(onNext: { [unowned self] (ip, countries) in
                let country = countries[ip.row]
                self.listView.tableView.deselectRow(at: ip, animated: true)
                self.coordinator.openDetailInfo(for: country)
            })
            .disposed(by: disposeBag)
        
        viewModel.countriesList
            .bind(to: listView.tableView
                .rx.items(cellIdentifier: CountryTableCell.reuseIdentifier,
                          cellType: CountryTableCell.self))
            { indexPath, country, cell in
                cell.setupCell(country: country) }
            .disposed(by: disposeBag)
        
        viewModel.error.subscribe(onNext: { [unowned self] error in
            self.showError(message: error.localizedDescription)
        })
            .disposed(by: disposeBag)
    }


}

