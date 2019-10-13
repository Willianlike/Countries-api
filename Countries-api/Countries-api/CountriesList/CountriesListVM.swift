//
//  CountriesListVM.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CountriesListVM {
    
    let requestAllCountries = PublishSubject<Void>()
    let refreshAllCountries = PublishSubject<Void>()
    let error = PublishSubject<CError>()
    let countriesList = BehaviorRelay<[CountryModel]>(value: [])
    let loadingInProgress = BehaviorRelay<Bool>(value: true)
    let refreshInProgress = BehaviorRelay<Bool>(value: false)
    
    let provider = CountriesProvider.shared
    
    let disposeBag = DisposeBag()
    
    init() {
        Observable.of(requestAllCountries, refreshAllCountries)
            .merge()
            .do(onNext: { [unowned self] in
                self.loadingInProgress.accept(true)
            })
            .flatMap({ [unowned self] in self.provider.requestAll() })
            .do(onNext: { [unowned self] _ in
                self.loadingInProgress.accept(false)
                self.refreshInProgress.accept(false)
            })
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case let .success(response):
                    self.countriesList.accept(response.countries)
                case let .failure(error):
                    self.error.onNext(error)
                }
            })
            .disposed(by: disposeBag)
        
        refreshAllCountries
            .map({ _ in true })
            .bind(to: refreshInProgress)
            .disposed(by: disposeBag)
        
    }
    
}
