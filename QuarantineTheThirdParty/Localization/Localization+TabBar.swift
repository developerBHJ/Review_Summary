//
//  Localization+TabBar.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation

extension LocalizationConstants{
    enum TabBar {
        @Localized
        static var home = "home_title"
    }
    
    enum HomePage {
        @Localized(tableName: LocalizationConstants.homeFileName)
        static var navTitle = "navigation_title"
    }
}
