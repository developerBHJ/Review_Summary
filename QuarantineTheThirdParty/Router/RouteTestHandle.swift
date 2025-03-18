//
//  RouteTestHandle.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation
import UIKit

struct RouteTestHandle: RouteHandler{
    enum Test{
        case test
        case test1
    }
    
    private let page: Test
    init(page: Test){
        self.page = page
    }
    
    func handle(url: URL, action: NavigationAction) -> Bool {
        switch page {
        case .test:
            let testViewController = RouteTestViewController()
            return handle(viewController: testViewController, action: action)
        case .test1:
            let testViewController = RouteTestViewController(page: 1)
            return handle(viewController: testViewController, action: action)
        }
    }
    
    private func handle(viewController: UIViewController,action: NavigationAction) -> Bool{
        switch action {
        case let .push(to: to, animated: animated):
            if viewController is UINavigationController{
                viewController.presentFullScreenAndDisablePullToDismiss()
                to.visibleViewController?.present(viewController, animated: true,completion: nil)
            }else{
                to.pushViewController(viewController, animated: animated)
            }
        case let .present(from, _, animated):
            viewController.presentFullScreenAndDisablePullToDismiss()
            from.present(viewController, animated: animated)
        }
        return true
    }
}
