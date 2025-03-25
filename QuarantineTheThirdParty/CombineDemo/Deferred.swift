//
//  Deferred.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/20.
//

import UIKit
import Combine

class DeferredDemoViewController: UIViewController {
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
        BTask{
            await fetchDataFromService().receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion{
                    case .finished:
                        print("请求完成")
                    case .failure(let error):
                        self.resultLabel.text = "网络请求失败：\(error.localizedDescription)"
                    }
                } receiveValue: { value in
                    self.resultLabel.text = "请求结果：\(value)"
                }.store(in: &cancellables)
        }
    }
    
    /// 使用 Deferred创建一个延迟发布者
    private func fetchDataFromService() async -> AnyPublisher<String,Error>{
        return Deferred {
            Future{ promise in
                print("开始请求数据")
                BTask{
                    try await BTask.sleep(nanoseconds: 100_000_000)
                    let success = Bool.random()
                    if success{
                        promise(.success("请求成功"))
                    }else{
                        promise(.failure(NSError(domain: "网络异常", code: 400, userInfo: nil)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

