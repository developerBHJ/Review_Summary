//
//  String+Localize.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import Foundation

public enum JourneyLocale: String{
    case en
    case zh_Hans = "zh-Hans"
}

extension String{
    func localized(using tabName: String? = LocalizationConstants.localizableFileName,
                   in bundle: Bundle = Bundle.main,
                   with local: JourneyLocale = Locale.current.language.languageCode?.identifier == "en" ? .en : .zh_Hans)-> String{
        if let path = bundle.path(forResource: local.rawValue, ofType: "lproj"),let localizedBundle = Bundle(path: path){
            return localizedBundle.localizedString(forKey: self, value: nil, table: tabName)
        }
        return self
    }
}
