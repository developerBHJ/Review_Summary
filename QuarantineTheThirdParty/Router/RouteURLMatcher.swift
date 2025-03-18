//
//  RouteURLMatcher.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation

struct RouteURLMatcher: RouteURLMatching {
    let schemeMatcher: RouteSchemeMatcher
    let pathMatcher: RoutePathMatcher
    
    func isRouteSchemeMatch(url: URL) -> Bool {
        schemeMatcher.isRouteSchemeMatch(url: url)
    }
    
    func isRoutePathMatch(url: URL) -> Bool {
        pathMatcher.isRoutePathMatch(url: url)
    }
}

extension RouteURLMatcher{
    enum Test {
        private static func matcher(for pathMatcher: RoutePathMatcher) -> RouteURLMatching{
            RouteURLMatcher(schemeMatcher: RouteSchemeMatcher.normal, pathMatcher: pathMatcher)
        }
        static let home = matcher(for: RoutePathMatcher.Test.test)
        static let home1 = matcher(for: RoutePathMatcher.Test.test1)
    }
}
