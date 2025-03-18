//
//  RouteManaging.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation
import UIKit

public enum NavigationAction{
    case push(to: UINavigationController,animated: Bool)
    case present(from: UIViewController,modalPresentationStyle:UIModalPresentationStyle,animated:Bool)
}

protocol RouteHandler {
    @discardableResult
    func handle(url:URL,action: NavigationAction ) -> Bool
}
protocol RoutableJourneyMaking: RouteHandler {
    func makeViewController(url: URL) -> UIViewController?
}

private extension URL{
    var isDontNeedShowReminder: Bool{
        queryItems["needShowReminder"] == "false"
    }
    
    var checkSession: Bool{
        queryItems["checkSession"] == "true"
    }
}

extension RoutableJourneyMaking{
    func handle(url: URL, action: NavigationAction) -> Bool {
        guard let controller = makeViewController(url: url) else {return false}
        switch action {
        case let .push(from, animated):
            from.pushViewController(controller, animated: animated)
        case let .present(from, modalPresentationStyle, animated):
            controller.modalPresentationStyle = modalPresentationStyle
            from.present(controller, animated: animated,completion: nil)
        }
        return true
    }
}
