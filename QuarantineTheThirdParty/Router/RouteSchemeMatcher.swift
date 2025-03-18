//
//  RouteSchemeMatcher.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation

struct RouteSchemeMatcher:RouteSchemeMatching {
    let scheme: String
    func isRouteSchemeMatch(url: URL) -> Bool {
        scheme == url.scheme
    }
}

extension RouteSchemeMatcher{
    static let normal = RouteSchemeMatcher(scheme: "app")
}
