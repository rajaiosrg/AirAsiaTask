//
//  UIManager.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 16/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class UIManager: NSObject {

    var tabBarController : UITabBarController!

    override init() {
        super.init()
        setupTabBarController()
    }
    
    func setupTabBarController()  {
        tabBarController = UITabBarController ()
        
        let homeNavigationController = UINavigationController.init(rootViewController: homeViewController())
        let transactionNavigationController = UINavigationController.init(rootViewController: transactionsViewController())
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        transactionNavigationController.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(named: "transaction"), tag: 1)
        tabBarController.viewControllers = [homeNavigationController,transactionNavigationController]
    }
    
    func pinViewController () -> PinViewController {
        let viewController =  storyBoard().instantiateViewController(withIdentifier: "PinViewController")
        return viewController as! PinViewController
    }
    
    func pinNavViewController () -> UINavigationController {
        let viewController =  storyBoard().instantiateViewController(withIdentifier: "PinNavigationViewController")
        return viewController as! UINavigationController
    }

    
    func homeViewController() -> HomeViewController {
        let viewController =  storyBoard().instantiateViewController(withIdentifier: "HomeViewController")
        return viewController as! HomeViewController
    }
    
    func transactionsViewController() -> TransactionsViewController {
        let viewController =  storyBoard().instantiateViewController(withIdentifier: "TransactionsViewController")
        return viewController as! TransactionsViewController
    }
    
    func storyBoard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
    
    func logout() {
        CoreDataManger.sharedManager.nukeCoreData()
        sharedDelegate().window?.rootViewController = pinNavViewController()
    }
    
    func sharedDelegate () -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

}
