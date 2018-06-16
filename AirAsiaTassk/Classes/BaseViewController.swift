//
//  BaseViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setRightNavigationButton()
    }
    
    func setGradientColor(inView: UIView)  {
        let valenciaColor = UIColor(red: 218/255, green: 68/255, blue: 83/255, alpha: 1)
        let discoColor = UIColor(red: 137/255, green: 33/255, blue: 107/255, alpha: 1)
        setGradientBackground(view: inView, colorTop: valenciaColor, colorBottom: discoColor)
    }
    
    func setGradientBackground(view:UIView, colorTop:UIColor, colorBottom:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLeftNavigationButton()  {
        let leftButton = UIButton(type: .custom);
        leftButton.setImage(UIImage(named: "ic_Arrow_Back"), for: .normal)
        leftButton.addTarget(self, action: #selector(handleLeftButonAction), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
        }
    }
    
    func setRightNavigationButton()  {
        let rightButton = UIButton(type: .custom);
        rightButton.setImage(UIImage(named: "logout"), for: .normal)
        rightButton.addTarget(self, action: #selector(handleRightButtonAction), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func handleLeftButonAction () {
     // override this method to take control
    }
    @objc func handleRightButtonAction () {
        UIManager().logout()
    }
}
