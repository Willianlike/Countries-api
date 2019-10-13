//
//  DetailInfoVM.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias DetailSection = SectionModel<String, String>

class DetailInfoVM {
    
    let requestCountry = PublishSubject<Void>()
    let error = PublishSubject<CError>()
    let sections = BehaviorRelay<[DetailSection]>(value: [])
    let loadingInProgress = BehaviorRelay<Bool>(value: true)
    
    let provider = CountriesProvider.shared
    
    let disposeBag = DisposeBag()
    
    init(name: String) {
        requestCountry
            .do(onNext: { [unowned self] in
                self.loadingInProgress.accept(true)
            })
            .flatMap({ [unowned self] in self.provider.requestDetail(country: name) })
            .do(onNext: { [unowned self] _ in
                self.loadingInProgress.accept(false)
            })
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case let .success(response):
                    if let country = response.countries.first {
                        self.sections.accept(country.getSections())
                    } else {
                        self.sections.accept([])
                    }
                case let .failure(error):
                    self.error.onNext(error)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
