//
//  UIViewController+Extension.swift
//  QuarantineTheThirdParty
//
//  Created by BHJ on 2025/2/28.
//

import UIKit

protocol TopMostViewControllerProviding{
    var topMostViewController: UIViewController? {get}
}

struct TopMostViewControllerProvider: TopMostViewControllerProviding {
    var topMostViewController: UIViewController?{
        UIViewController.topMost
    }
}

extension UIViewController{
   @objc func presentFullScreenAndDisablePullToDismiss(){
       modalPresentationStyle = .fullScreen
       if #available(iOS 13.0, *){
           isModalInPresentation = true
       }
    }
}


extension UIViewController{
    
    @objc public class var topMost: UIViewController?{
        guard let currentWindows = getCurrentWindows() else {
            return nil
        }
        guard let rootViewController = getRootViewController(currentWindows: currentWindows) else {
            return nil
        }
        return topMost(of: rootViewController)
    }
    
    public class var sharedApplication: UIApplication?{
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector).takeUnretainedValue() as? UIApplication
    }
    
    class func getCurrentWindows() -> [UIWindow]?{
        sharedApplication?.windows
    }
    
    class func getRootViewController(currentWindows: [UIWindow]) -> UIViewController?{
        currentWindows.filter({$0.isKeyWindow}).first?.rootViewController
    }
    
    public class func topMost(of viewController: UIViewController) -> UIViewController{
        // presentedViewController
        if let presentedViewController = viewController.presentedViewController {
            return topMost(of: presentedViewController)
        }
        // tabBarController
        if let tabBarController = viewController as? UITabBarController,let selectedViewController = tabBarController.selectedViewController{
            return topMost(of: selectedViewController)
        }
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,let visibedViewController = navigationController.visibleViewController{
            return topMost(of: visibedViewController)
        }
        // UIPageViewController
        if let pageViewController = viewController as? UIPageViewController,let viewController = pageViewController.viewControllers?.first{
            return topMost(of: viewController)
        }
        // childViewController
        for subView in viewController.view.subviews{
            if let childViewController = subView.next as? UIViewController{
                return topMost(of: childViewController)
            }
        }
        return viewController
    }
    
    public class func topMostNavigationController(of viewController: UIViewController) -> UINavigationController?{
        // presentedViewController
        if let presentedViewController = viewController.presentedViewController {
            return topMostNavigationController(of: presentedViewController)
        }
        // tabBarController
        if let tabBarController = viewController as? UITabBarController,let selectedViewController = tabBarController.selectedViewController{
            return topMostNavigationController(of: selectedViewController)
        }
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,let visibedViewController = navigationController.visibleViewController{
            return topMostNavigationController(of: visibedViewController)
        }
        return viewController.navigationController
    }
    
    @objc public class var topMostTabBarController: UITabBarController?{
        guard let currentWindows = getCurrentWindows() else {
            return nil
        }
        return getTopMostTabBarController(currentWindows: currentWindows)
    }
    
    class func getTopMostTabBarController(currentWindows: [UIWindow]) -> UITabBarController?{
        guard let rootViewController = getRootViewController(currentWindows: currentWindows) else {
            return nil
        }
        return topMostTabBarController(of: rootViewController)
    }
    
    public class func topMostTabBarController(of controller: UIViewController) -> UITabBarController?{
        if let result = controller as? UITabBarController{
            return result
        }
        if let result = controller.tabBarController{
            return result
        }
        // presentedViewController
        if let presentedViewController = controller.presentedViewController{
            return topMostTabBarController(of: presentedViewController)
        }
        // childViewController
        for subView in controller.view.subviews{
            if let childViewController = subView.next as? UIViewController{
                return topMostTabBarController(of: childViewController)
            }
        }
        return nil
    }
}


extension UIScene.ActivationState{
    var sortPriority: Int{
        switch self {
        case .unattached:
            return 4
        case .foregroundActive:
            return 1
        case .foregroundInactive:
            return 2
        case .background:
            return 3
        @unknown default:
            return 5
        }
    }
}
