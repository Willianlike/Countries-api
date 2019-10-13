//
//  ReachabilityInformer.swift
//  Countries-api
//
//  Created by Вильян Яумбаев on 13/10/2019.
//  Copyright © 2019 Вильян Яумбаев. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class ReachabilityInformer: Disposable {

    private lazy var networkReachabilityManager: NetworkReachabilityManager? = NetworkReachabilityManager(host: "www.google.com")
    private lazy var relayNetworkReachable = PublishRelay<Bool>()

    init() {
        switch networkReachabilityManager {
        case .none:
            relayNetworkReachable.accept(false)
        case .some(let manager):
            manager.listener = { [weak informer = self] status in
                switch status {
                case .notReachable:
                    informer?.relayNetworkReachable.accept(false)
                case .unknown:
                    break
                case .reachable:
                    informer?.relayNetworkReachable.accept(true)
                }
            }
        }
        networkReachabilityManager?.startListening()
    }

    func observableReachable() -> Observable<Bool> {
        return relayNetworkReachable
            .asObservable()
            .distinctUntilChanged()
    }

    func dispose() {
        networkReachabilityManager?.stopListening()
        networkReachabilityManager?.listener = nil
        networkReachabilityManager = nil
    }
}
