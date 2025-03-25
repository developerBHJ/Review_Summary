//
//  Macro.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/20.
//

import Foundation

public typealias BTask = _Concurrency.Task

public func BLog<T>(message: T,fileName: String = #file,funcName: String = #function,lineNum: Int = #line){
    let filePath = (fileName as NSString).lastPathComponent
    print("[\(filePath)] - [\(funcName)] - [\(lineNum)]: \(message)")
}
