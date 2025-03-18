//
//  RoutePathMatcher.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation

struct RoutePathMatcher: RoutePathMatching{
    let path: String
    func isRoutePathMatch(url: URL) -> Bool {
        path == (url.host ?? "") + url.path
    }
}

extension RoutePathMatcher{
    enum Test{
        static let test = RoutePathMatcher(path: "test")
        static let test1 =  RoutePathMatcher(path: "test1")
    }
}
