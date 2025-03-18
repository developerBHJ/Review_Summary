//
//  BaseModelProtocol.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/25.
//

import Foundation
/*
 隔离第三方
 eg:
 HandyJSON 第三方不更新了，可以同步更换为 HandyJSON1，不需要改大量的代码，
 只需要观测一下新的第三方的适用性
 */
public protocol Serializable{
    init()
    func toJSON() -> [String: Any]?
    func toJSONString(prettyPrint: Bool) -> String?
}
/*
 模拟第三方
 */
public protocol HandyJSON {}
public protocol HandyJSON1 {}

public protocol BaseModel: Serializable & HandyJSON {}
public protocol BaseModel1: Serializable & HandyJSON1 {}

extension BaseModel{
    static func model(from json: String,designatedPath: String? = nil) -> Self{
        print("HandyJSON -> Model")
        return Self()
    }
    
    static func modelArray(from json: String,designatedPath: String? = nil) -> [Self]{
        print("HandyJSON -> Model")
        return [Self()]
    }
}

extension BaseModel1{
    static func model(from json: String,designatedPath: String? = nil) -> Self{
        print("HandyJSON1 -> Model")
        return Self()
    }
    
    static func modelArray(from json: String,designatedPath: String? = nil) -> [Self]{
        print("HandyJSON -> Model")
        return [Self()]
    }
}

/*
 方法定义到协议主题返回self需要class是final的
 把方法拆到扩展里面，方法派发的时候会走扩展方法并不会走到具体类型里，所以需要强制类型然后派发到合适的类
 */
extension Serializable{
    /// json转模型
    /// - Parameters:
    ///   - json: josn字符串
    ///   - designatedPath: key
    /// - Returns: 模型
    static func model(from json: String,designatedPath: String? = nil) -> Self{
        if let type = Self.self as? BaseModel.Type {
            return type.model(from: json,designatedPath: designatedPath) as! Self
        }else if let type = Self.self as? BaseModel1.Type{
            return type.model(from: json,designatedPath: designatedPath) as! Self
        }
        return Self()
    }
    
    /// json转模型数组
    /// - Parameters:
    ///   - json: josn字符串
    ///   - designatedPath: key
    /// - Returns: 模型数组
    static func modelArray(from json: String,designatedPath: String? = nil) -> [Self]{
        if let type = Self.self as? BaseModel.Type {
            return type.modelArray(from: json,designatedPath: designatedPath) as! [Self]
        }else if let type = Self.self as? BaseModel1.Type{
            return type.modelArray(from: json,designatedPath: designatedPath) as! [Self]
        }
        return []
    }
}

public extension Collection where Iterator.Element: BaseModel{
    func toJSON() -> [[String: Any]?]{
        self.map{$0.toJSON()}
    }
    
    func toJSONString(prettyPrint:Bool) -> String?{
        let array = self.toJSON()
        if JSONSerialization.isValidJSONObject(array){
            do{
                let jsonData: Data
                if prettyPrint{
                    jsonData = try JSONSerialization.data(withJSONObject: array,options: [.prettyPrinted])
                }else{
                    jsonData = try JSONSerialization.data(withJSONObject: array,options: [])
                }
                return String(data: jsonData, encoding: .utf8)
            } catch let error{
                print(error)
            }
        }
        return nil
    }
}
