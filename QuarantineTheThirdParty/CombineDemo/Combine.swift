//
//  Combine.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/20.
//

import UIKit
import Combine

class CombineDemoViewController: UITableViewController {
    private var dataSource = ["Just","Future","Deferred","Empty","Fail"]
    private var viewControllers = [JustDemoViewController(),FutureDemoViewController(),DeferredDemoViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Combine的基本用法"
        tableView.reloadData()
    }
}

extension CombineDemoViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.text = dataSource[indexPath.row]
            cell?.backgroundColor = .white
            cell?.selectionStyle = .none
            cell?.accessoryType = .detailButton
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        failTest()
        if viewControllers.count > index{
            let vc = viewControllers[index]
            vc.title = dataSource[index]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// MARK: Empty
/*
 empty 是combine 中的一个发布者，专门用于立即完成并不会发布任何值的情况
 通常用于不需要发送数据的场景或者只是为了提供一个结束事件（完成或失败）
 */

// MARK: Fail 用于发布错误，主要用于模拟失败场景
extension CombineDemoViewController{
    
    func failTest(){
        let failPublisher = Fail<Int,Error>(error: NSError(domain: "网络错误", code: 0, userInfo: nil))
        _ = failPublisher.sink { error in
            BLog(message: "\(error)")
        } receiveValue: { _ in
            print("Received")
        }
    }
}

// MARK: Timer.TimerPublisher
extension CombineDemoViewController{
    
    func timerTest(){
        let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .default)
        let _ = timerPublisher.autoconnect().sink { time in
            BLog(message: "\(time)")
        }
    }
}

// MARK: NotificationCenter.Publisher
extension CombineDemoViewController{
    
    func notificationTest(){
        let notificationPublisher = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
        _ = notificationPublisher.sink { _ in
            BLog(message: "Received")
        }
    }
}

struct TestModel {
    var name: String?
}
// MARK: URLSession.DataTaskPublisher
extension CombineDemoViewController{
    
    func urlTest(){
        guard let url = URL(string: "https://www.baidu.com") else {return}
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
//        dataTaskPublisher
//            .map{$0.data}
//            .decode(type: Post.self, decoder: JSONDecoder())
//            .sink {
//                BLog(message: "\($0)")
//            }
//        receiveValue: {  in
//                BLog(message: "Received")
//            }
    }
}
