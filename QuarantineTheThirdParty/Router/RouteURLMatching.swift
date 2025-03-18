//
//  RouteURLMatching.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation
import UIKit

protocol RouteSchemeMatching {
    func isRouteSchemeMatch(url: URL) -> Bool
}

protocol RoutePathMatching {
    func isRoutePathMatch(url: URL) -> Bool
}

protocol RouteURLMatching:RouteSchemeMatching,RoutePathMatching {
    func isRouteURLMatch(url: URL) -> Bool
}

extension RouteURLMatching{
    func isRouteURLMatch(url: URL) -> Bool{
        isRouteSchemeMatch(url: url) && isRoutePathMatch(url: url)
    }
}
