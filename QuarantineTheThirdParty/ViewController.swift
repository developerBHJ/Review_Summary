//
//  ViewController.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        JourneyContainer.shared.setup(config: .init(appInfo: AppInfo()))
        
        let string = LocalizationConstants.HomePage.navTitle
        print(string)
        
        setButton()
        
        testBranchInfoFilter()
    }
    
    func setButton(){
        let button = UIButton(type: .custom)
        button.frame = .init(origin: .zero, size: .init(width: 100, height: 30))
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("tapEvent", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.center = view.center
    }
    
    @objc func buttonEvent(sender: UIButton){
        testRouter()
    }

    func testRouter(){
        guard let url = URL.init(string: "app://test"),let navigationController = self.navigationController else {return}
        JourneyContainer.shared.route(to: url, action: .push(to: navigationController, animated: true))
    }
    
    func testRouter1(){
        guard let url = URL.init(string: "app://test1") else {return}
        JourneyContainer.shared.route(to: url, action: .present(from: self, modalPresentationStyle: .overFullScreen, animated: true))
    }
    
    func testBranchInfoFilter(){
        let tempList = [BranchInfo.init(id: 0,saturdayOpen: false,isATM: true),BranchInfo(id: 1,saturdayOpen: true,isATM: false),BranchInfo(id: 2,saturdayOpen: true,isATM: true)]
        let filter = BranchInfoFiltter(saturdayOpen: true,isATM: true)
        let result = tempList.filter(branchFilter: filter)
        print("match === \(result)")
    }
}

