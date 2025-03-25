//
//  Review01.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/19.
//

import Foundation

struct Class1 {
    var nums = [1,2,3,4,5,6,7,8,9]
}

extension Class1{
    /*
     1、交换数组内的两个元素
     考察swift范型以及元组特性
     */
//    func swap(_ nums: inout [Int],_ a: Int,_ b: Int){
//        let temp = nums[a]
//        nums[a] = nums[b]
//        nums[b] = temp
//    }
    
//    func swap<T>(_ nums: inout [T],_ a: Int,_ b: Int){
//        let temp = nums[a]
//        nums[a] = nums[b]
//        nums[b] = temp
//    }
    
    /*
     利用元组特性
     */
    func swap<T>(_ nums: inout [T],_ a: Int,_ b: Int){
        let count = nums.count
        if a < 0 || a > count - 1 || b < 0, b > count - 1{
            return
        }
        (nums[a],nums[b]) = (nums[b],nums[a])
    }
}

extension Class1{
    /*
     2、使用swift实现一个函数，输入任意一个整数，输出返回输入整数+2
     */
    func addTwo(_ input: Int) -> Int{
        return input + 2
    }
    /*
     利用柯里化特性
     柯里化: 从一个多参数函数变成一连串单参数函数的变换
     */
    func add(input: Int) -> (Int) -> Int{
        return { value in
            input + value
        }
    }
}

/*
 3、这段代码打印出来是什么？
 var car = "Benz"
 let closure = { [car] in // 这里的car已经是局部变量，所以应该输出： Benz
     print("I drive \(car)")
 }
 car = "BMW"
 closure()
 */


class BankCard {
    var balance: Double = 0
    func deposit(amount: Double){
        balance += amount
    }
    
//    // 正常使用
//    let card = BankCard()
//    card.deposit(amount: 100)
//    // 柯里化
//    let deposit = BankCard.deposit
//    deposit(card)(100)
}
