//
//  Just.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/20.
//

import UIKit
import Combine

/*
 Just 用于立即发布一个值，并立即完成
 使用场景：
 1、调试和测试：在开发过程中临时显示某些静态数据，方便调试数据管道
 2、占位符数据：在数据加载之前，可以用静态文本作为提示或占位符，提升用户体验
 3、初始化静态状态：用于显示固定欢迎消息、错误消息等单次信息展示
 */
class JustDemoViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()// 用于管理订阅
    private let resultLabel = UILabel()// 用于显示请求结果
    private let requestButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        self.title = "Future 使用实例"
        requestButton.setTitle("发送请求", for: .normal)
        requestButton.setTitleColor(.black, for: .normal)
        requestButton.addTarget(self, action: #selector(makeRequest), for: .touchUpInside)
        requestButton.backgroundColor = .green
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        
        resultLabel.text = "等待请求结果..."
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(resultLabel)
        view.addSubview(requestButton)
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            requestButton.widthAnchor.constraint(equalToConstant: 80),
            requestButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func makeRequest(){
        Just(1).sink { value in
            self.resultLabel.text = "Just Demo \(value)"
        }.store(in: &cancellables)
    }
}

