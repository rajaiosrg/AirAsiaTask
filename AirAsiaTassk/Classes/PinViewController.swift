//
//  PinViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 14/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

import SVPinView

class PinViewController: BaseViewController {
    
    @IBOutlet weak var pinView: SVPinView!
    
    @IBOutlet weak var keyPadButton: UIButton!
    
    @IBOutlet weak var clearPinButton: UIButton!
    
    @IBOutlet weak var virtualKeyPad: AAVirtualKeyPad!
    
    let maxPinLength : Int = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true

        super.setGradientColor(inView: self.view)
        
        virtualKeyPad.isHidden = true
        clearPinButton.isHidden = true
        
        keyPadButtonConfiguration()
        configurePinView()
        configureVirtualKeyPad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ContactsManager.shared.getContacts()
    }
    
    func keyPadButtonConfiguration()  {
        let normalImage = UIImage(named: "ic_circle-uncheck")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: "ic_circle-check")?.withRenderingMode(.alwaysTemplate)

        keyPadButton .setImage(normalImage , for: .normal)
        keyPadButton .setImage(selectedImage, for: .selected)
        
        clearPinButton.layer.cornerRadius = 2
        clearPinButton.layer.borderColor = UIColor.white.cgColor
        clearPinButton.layer.borderWidth = 1
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
    
    func configureVirtualKeyPad() {
        virtualKeyPad.didTapNumberCallback = sendNumberToPinView(pin:)
    }
    
    func sendNumberToPinView(pin : String) {
        let currentPinLength : Int = pinView.currentPasswordLength()
        if currentPinLength <= maxPinLength {
            pinView.enterNumberAtIndex(at: currentPinLength, text: pin)
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func didFinishEnteringPin(pin:String) {
        validateAndLoginPin(pin: pin)
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clearPinAction(_ sender: UIButton) {
        pinView.clearPin()
    }
    
    
    @IBAction func handleKeyPadAction(_ sender: UIButton) {
        keyPadButton.isSelected = !keyPadButton.isSelected
        virtualKeyPad.isHidden = !keyPadButton.isSelected
        pinView.shouldShowKeboard = !keyPadButton.isSelected
        clearPinButton.isHidden = !keyPadButton.isSelected
        self.view.endEditing(false)
    }
    
    func validateAndLoginPin(pin : String)  {
        let defaultAccount = CoreDataManger.sharedManager.currentAccountUser
        if Int64(pin) == defaultAccount.pin {
            UserInfoManager().markUserAsLoggedIn(userId: defaultAccount.uid)
            self.present(UIManager().tabBarController, animated: true, completion: nil)
        } else {
            showAlert(title: "Invalid Pin", message: "Please Check once again")
        }
    }
}

