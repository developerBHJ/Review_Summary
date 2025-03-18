//
//  LocalizationConstants.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation

enum LocalizationConstants {
    static let localizableFileName = "Localizable"
    static let homeFileName = "HomePage"
    
    @propertyWrapper
    struct Localized{
        private var value: String
        private let tableName: String
        
        var wrappedValue: String{
            get{
                value.localized(using: tableName)
            }
            set{
                value = newValue
            }
        }
        
        init(wrappedValue: String, tableName: String = LocalizationConstants.localizableFileName) {
            self.value = wrappedValue
            self.tableName = tableName
        }
    }
}
