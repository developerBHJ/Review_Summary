//
//  JourneyContainer.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/28.
//

import Foundation
import UIKit

protocol AppInfoProviding{
    var version: String{get}
    var local: JourneyLocale{get}
    var bundleId: String {get}
}

final class AppInfo: AppInfoProviding{
    var version: String{
        "1.0.0"
    }
    
    var local: JourneyLocale{
        .zh_Hans
    }
    var bundleId: String{
        "1.0"
    }
}

public class JourneyConfigrations{
    private(set) var apliClentFactory: Any?
    let appInfo: AppInfoProviding
    init(apliClentFactory: Any? = nil, appInfo: AppInfoProviding) {
        self.apliClentFactory = apliClentFactory
        self.appInfo = appInfo
    }
}

final class LoginServiceProvider: LoginService{
    func login(completion: ((UIViewController) -> Void)?) {
        
    }
    func wechatLogin(action: @escaping (() -> Void)) {
    }
}

public final class JourneyContainer{
    public static let shared = JourneyContainer()
    private(set) var config: JourneyConfigrations!
    
    private var routeManager: RouteJourneyStrategy?
    
    private init(){
    }
    
    public func setup(config: JourneyConfigrations){
        self.config = config
        routeManager = RouteManager()
    }
}

extension JourneyContainer: RouteJourneyStrategy{
    public func canRoute(to url: URL) -> Bool {
        routeManager?.canRoute(to: url) ?? false
    }
    
    public func route(to url: URL, action: NavigationAction) {
        routeManager?.route(to: url, action: action)
    }
    
    public func route(to url: URL, actionType: RouteActionType) {
        routeManager?.route(to: url, actionType: actionType)
    }
}
