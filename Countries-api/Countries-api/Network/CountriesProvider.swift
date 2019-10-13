//
//  CountriesProvider.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class CountriesProvider {
    let provider: MoyaProvider<CountriesAPI>
    
    let internetReachability: Observable<Bool>
    
    static let shared = CountriesProvider()
    
    init() {
        let moyaPlugins: [Moya.PluginType] = []//[NetworkLoggerPlugin(verbose: true, cURL: true)]
        
        self.provider = MoyaProvider<CountriesAPI>(
            endpointClosure: { (target: CountriesAPI) -> Endpoint in
                return Endpoint(url: target.baseURL.absoluteString,
                                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)}
            , manager: APISessionManager.shared
            , plugins: moyaPlugins)
        
        internetReachability = Observable<Bool>
            .using({ ReachabilityInformer() }, observableFactory: { (informer: ReachabilityInformer) -> Observable<Bool> in
                return informer.observableReachable()
            })
    }
    
    typealias AllCountriesResult = Result<CountriesResponse, CError>
    func requestAll() -> Observable<AllCountriesResult>  {
        return internetReachability.take(1).flatMap { (reachable) -> Observable<DetailCountryResult> in
            if reachable {
                return self.provider.rx.request(.all)
                    .asObservable()
                    .mapObject(type: CountriesResponse.self)
                    .map { .success($0) }
                    .catchErrorJustReturn(.failure(.allResponse))
            } else {
                return Observable.just(.failure(.networkError))
            }
        }
    }
    
    typealias DetailCountryResult = Result<CountriesResponse, CError>
    func requestDetail(country: String) -> Observable<DetailCountryResult>  {
        return internetReachability.take(1).flatMap { (reachable) -> Observable<DetailCountryResult> in
            if reachable {
                return self.provider.rx.request(.name(country))
                    .asObservable()
                    .mapObject(type: CountriesResponse.self)
                    .map { .success($0) }
                    .catchErrorJustReturn(.failure(.detailResponse))
            } else {
                return Observable.just(.failure(.networkError))
            }
        }
    }
    
    
}
