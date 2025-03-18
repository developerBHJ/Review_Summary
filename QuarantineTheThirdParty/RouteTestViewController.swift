//
//  RouteTestViewController.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/26.
//

import UIKit

class RouteTestViewController: UIViewController {
    private var page: Int = 0
    convenience init(page: Int){
        self.init()
        self.page = page
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "RouteTest\(page)"
        view.backgroundColor = .red
    }
}
