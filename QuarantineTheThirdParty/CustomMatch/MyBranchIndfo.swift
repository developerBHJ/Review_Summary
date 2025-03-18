//
//  MyBranchIndfo.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/17.
//

import Foundation

struct BranchInfo: Equatable {
    var id: Int = 0
    var name: String?
    var todayOpen: Bool?
    var saturdayOpen: Bool?
    var isATM: Bool?
    
    static func == (lhs: BranchInfo, rhs: BranchInfo) -> Bool{
        lhs.id == rhs.id
    }
}

struct BranchInfoFiltter {
    var saturdayOpen: Bool?
    var isATM: Bool?
    
    func matches(info: BranchInfo) -> Bool{
        guard let isATM = info.isATM,let saturdayOpen = info.saturdayOpen else {return false}
        if !saturdayOpen {
            return false
        }
        return isATM
    }
}

extension Sequence<BranchInfo>{
    func filter(branchFilter: BranchInfoFiltter) -> [BranchInfo]? {
        filter(branchFilter.matches)
    }
}
