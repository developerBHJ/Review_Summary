//
//  RouteManager.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation
import UIKit

public enum RouteActionType{
    case push
    case present
}

public protocol RouteJourneyStrategy{
    func canRoute(to url:URL) -> Bool
    func route(to url: URL,action: NavigationAction)
    func route(to url: URL,actionType:RouteActionType)
}

public protocol LoginService{
    func login(completion: ((UIViewController) -> Void)?)
    func wechatLogin(action: @escaping (() -> Void))
}

public protocol LogoffService{
    func logoff(completion: (() -> Void)?)
}

public protocol SessionStrategy{
    var loginSatus: Int {get}
    func updateAuthorizationToken(_ token: String)
}

class RouteManager: RouteJourneyStrategy{
    struct CacheRoute{
        let url: URL
        let action: NavigationAction
    }
    
    typealias Router = (matcher: RouteURLMatching,handle: RouteHandler)
    private var routers: [Router] = []
    
    private let loginService: (() -> LoginService)?
    private let sessionStrategy: (() -> SessionStrategy)?
    
    init(loginService: (() -> LoginService)? = nil, sessionStrategy: (() -> SessionStrategy)? = nil) {
        self.loginService = loginService
        self.sessionStrategy = sessionStrategy
        setRouters()
    }
    
    func setRouters(){
        registerTestRouter()
    }
}

extension RouteManager{
    func registerTestRouter(){
        register(matcher: RouteURLMatcher.Test.home, for: RouteTestHandle(page: .test))
        register(matcher: RouteURLMatcher.Test.home1, for: RouteTestHandle(page: .test1))
    }
    
    func register(matcher: RouteURLMatching,for handle: RouteHandler){
        routers.append((matcher,handle))
    }
    
    func canRoute(to url: URL) -> Bool {
        findFirstRoute(for: url) != nil
    }
    
    func route(to url: URL, action: NavigationAction) {
        guard let router = findFirstRoute(for: url) else {
            return
        }
        router.handle.handle(url: url, action: action)
    }
    
    func route(to url: URL, actionType: RouteActionType) {
        guard let topMost = TopMostViewControllerProvider().topMostViewController else {
            return
        }
        let routeAction: NavigationAction
        if let nav = topMost.navigationController,actionType == .push{
            routeAction =  NavigationAction.push(to: nav, animated: true)
        }else{
            routeAction = NavigationAction.present(from: topMost, modalPresentationStyle: .overFullScreen, animated: true)
        }
        route(to: url, action: routeAction)
    }
}

extension RouteManager{
    func findFirstRoute(for url: URL) -> Router?{
        routers.first(where: {
            $0.matcher.isRouteURLMatch(url: url)
        })
    }
}
