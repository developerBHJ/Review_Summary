//
//  RootViewController.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/3/20.
//

import UIKit
class RootViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setChildren()
    }
    
    func setChildren(){
        addChild(ViewController(), title: "Test", normalImage: nil, selectedImage: nil)
        addChild(CombineDemoViewController(), title: "Combine", normalImage: nil, selectedImage: nil)
    }
    
    func addChild(_ childController: UIViewController,title: String,normalImage: UIImage?,selectedImage: UIImage?) {
        let nav = UINavigationController.init(rootViewController: childController)
        nav.title = title
        let tabBarItem = UITabBarItem()
        tabBarItem.title = title
        tabBarItem.image = normalImage
        tabBarItem.selectedImage = selectedImage
        addChild(nav)
    }
}
