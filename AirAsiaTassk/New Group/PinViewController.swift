//
//  PinViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 14/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

import SVPinView

class PinViewController: UIViewController {
    
    @IBOutlet weak var pinView: SVPinView!
    
    @IBOutlet weak var keyPadButton: UIButton!
    
    @IBOutlet weak var virtualKeyPad: AAVirtualKeyPad!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let valenciaColor = UIColor(red: 218/255, green: 68/255, blue: 83/255, alpha: 1)
        let discoColor = UIColor(red: 137/255, green: 33/255, blue: 107/255, alpha: 1)
        setGradientBackground(view: self.view, colorTop: valenciaColor, colorBottom: discoColor)
        
        virtualKeyPad.isHidden = true
        
        keyPadButtonConfiguration()
        configurePinView()
    }
    
    func keyPadButtonConfiguration()  {
        let normalImage = UIImage(named: "ic_circle-uncheck")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: "ic_circle-check")?.withRenderingMode(.alwaysTemplate)

        keyPadButton .setImage(normalImage , for: .normal)
        keyPadButton .setImage(selectedImage, for: .selected)
    }
    
    func configurePinView() {
        
        pinView.pinLength = 5
        pinView.style = .box
        pinView.borderLineColor = UIColor.white
        pinView.secureCharacter = "\u{25CF}"
        pinView.textColor = UIColor.white
        pinView.borderLineColor = UIColor.white
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        
        pinView.font = UIFont.systemFont(ofSize: 15)
        pinView.keyboardType = .phonePad
        pinView.pinIinputAccessoryView = { () -> UIView in
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            doneToolbar.barStyle = UIBarStyle.default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(dismissKeyboard))
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }()
        
        pinView.didFinishCallback = didFinishEnteringPin(pin:)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func didFinishEnteringPin(pin:String) {
        validateAndLoginPin(pin: pin)
//showAlert(title: "Success", message: "The Pin entered is \(pin)")
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func handleKeyPadAction(_ sender: UIButton) {
        keyPadButton.isSelected = !keyPadButton.isSelected
        
        virtualKeyPad.isHidden = !keyPadButton.isSelected
        
        print("\(keyPadButton.isSelected ? "YES" : "NO")")
        self.view.endEditing(false)
    }
    
    
    func setGradientBackground(view:UIView, colorTop:UIColor, colorBottom:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func validateAndLoginPin(pin : String)  {
        let login = JSONDataHelper().loginData()
        if Int(pin) == login.pin {
           print("============== Login Success =============")
            
        } else {
            showAlert(title: "Invalid Pin", message: "Please Check once again")
        }
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

