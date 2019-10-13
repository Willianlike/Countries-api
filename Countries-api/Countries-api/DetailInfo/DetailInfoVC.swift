//
//  DetailInfoVC.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class DetailInfoVC: BaseVC {
    
    let viewModel: DetailInfoVM
    
    var listView: DetailInfoView {
        return view as! DetailInfoView
    }
    
    override func loadView() {
        view = DetailInfoView()
    }
    
    init(name: String) {
        viewModel = DetailInfoVM(name: name)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupModel()
    }
    
    private func setupUI() {
        title = "Country details"
        activityIndicator.startAnimating()
    }
    
    private func setupModel() {
        viewModel.requestCountry.onNext(())
        
        viewModel.loadingInProgress
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        let datasource = RxTableViewSectionedReloadDataSource<DetailSection>(configureCell:
        { dataSource, tableView, indexPath, text in
            let reuseId = "reuseIdentifier"
            var cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: reuseId)
            }
            cell!.selectionStyle = .none
            cell!.textLabel?.text = text
            cell!.textLabel?.numberOfLines = 0
            return cell!
        })
        
        datasource.titleForHeaderInSection = { model, sectionNumber in
            return model.sectionModels[sectionNumber].model
        }
        
        viewModel.sections
            .bind(to: listView.tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        viewModel.error.subscribe(onNext: { [unowned self] error in
            self.showError(message: error.localizedDescription)
        })
            .disposed(by: disposeBag)
    }
    
}
