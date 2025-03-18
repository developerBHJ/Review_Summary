//
//  Person.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/25.
//

import Foundation

struct Person:BaseModel {
    func toJSON() -> [String : Any]? {
        nil
    }
    
    func toJSONString(prettyPrint: Bool) -> String? {
        nil
    }
    
    var age: Int = 0
    var gender: Int = 0
    var name: String = ""
}
