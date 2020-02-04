//
//  ViewController.swift
//  KeyBoardHandlingLab
//
//  Created by Jaheed Haynes on 2/4/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var muncheeImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var  keyboardIsVisible = false
    
    @IBOutlet weak var imageTopValue: NSLayoutConstraint!
    var originalImageTopValue = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        
        usernameTextField.delegate = self
        passwordTextfield.delegate = self
        pulsateLogo()
        roundCorners()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }
    
    
    
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    @objc private func keyboardWillShow(_ notication: NSNotification) {
        print("keyboardWillShow")
        //    print(notication.userInfo)
        
        guard let keyboardFrame = notication.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect
            else {
                return
        }
        
        
        moveKeyboardUp(keyboardFrame.size.height)
        
    }
    
    
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        resetUI()
    }
    
    
    
    private func moveKeyboardUp (_ height: CGFloat) {
        
        if keyboardIsVisible { return } // this prevents from the text feild moving the constraints multiple times
        
        originalImageTopValue = imageTopValue
        
        imageTopValue.constant -= (height) * 0.50
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        keyboardIsVisible = true
        
    }
    
    
    
    private func pulsateLogo () {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.muncheeImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
    }
    
    
    
    private func resetUI () {
        keyboardIsVisible = false
        imageTopValue.constant -= originalImageTopValue.constant
        
    }
    
    private func roundCorners() {
        continueButton.backgroundColor = .systemGreen
        continueButton.layer.cornerRadius = 5
        continueButton.layer.borderWidth = 1
        continueButton.layer.borderColor = UIColor.systemGray.cgColor
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           
           return true
       }
}
