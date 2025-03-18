//
//  URL+Extension.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/28.
//

import Foundation

extension URL{
    var queryItems: [String: String]{
        guard let components = URLComponents(string: absoluteString),let queryItems = components.queryItems else {
            return [:]
        }
        return queryItems.reduce([:]) { acc, item in
            var newAcc = acc
            newAcc[item.name] = item.value
            return newAcc
        }
    }
    
    var directoryPath: String{
        guard let components = URLComponents(string: absoluteString) else {
            return path
        }
        return components.path
    }
}


extension URL{
    func haveQueryItem(key: String,value: String,isCaseInsensitive: Bool = true) -> Bool{
        guard let components = URLComponents(string: absoluteString),let queryItems = components.queryItems else {
            return false
        }
        return queryItems.contains { item in
            item.name.compare(key, isCaseInsensitive: isCaseInsensitive) && (item.value?.compare(value, isCaseInsensitive: isCaseInsensitive) ?? false)
        }
    }
    
    func removingQueryItem(key: String,value: String,isCaseInsensitive: Bool = true) -> URL{
        guard var components = URLComponents(string: absoluteString),let queryItems = components.queryItems else {
            return self
        }
        let newQueryItems = queryItems.filter { item in
            let isRemovingItemMatch = item.name.compare(key, isCaseInsensitive: isCaseInsensitive) && (item.value?.compare(value, isCaseInsensitive: isCaseInsensitive) ?? false)
            return !isRemovingItemMatch
        }
        components.queryItems = newQueryItems.isEmpty ? nil : newQueryItems
        return components.url ?? self
    }
}

extension String{
    func compare(_ aString: String,isCaseInsensitive: Bool)-> Bool{
        if isCaseInsensitive{
            return compare(aString,options:.caseInsensitive) == .orderedSame
        }else{
            return compare(aString) == .orderedSame
        }
    }
}
