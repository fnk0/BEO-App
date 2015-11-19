//
//  LoginController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 10/4/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import Parse
import PKHUD

class LoginController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var employeeBtn: UIButton!
    @IBOutlet weak var managerBtn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var whiteBox: UIImageView!
    
    override func viewDidLoad() {
        email.delegate = self
        password.delegate = self
        password.addTarget(self, action: "passwordTextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        registerKeyboardEvents()
    }
    
    override func viewWillDisappear(animated: Bool) {
        registerKeyboardEvents()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
//            self.view.frame = CGRectMake(0,-215 , self.view.frame.width, self.view.frame.height)
        } else {
            password.resignFirstResponder()
            self.login()
        }
        return true
    }
    
    func passwordTextFieldDidChange(textField: UITextField) {
        if let text = textField.text {
            if text.characters.count != 0 {
                forgotBtn.hidden = true
            } else {
                forgotBtn.hidden = false
            }
        }
    }
    
    // The changing stuff is just UI asthetics... 
    // We don't really need to reflect anything else
    // We know when a user signs in if he is a manager or not..
    @IBAction func changeToManager(sender: AnyObject) {
        self.whiteBox.image = UIImage(named: "WhiteBox_Manager.png")
    }
    
    @IBAction func changeToEmployee(sender: AnyObject) {
        self.whiteBox.image = UIImage(named: "WhiteBox_Employee.png")
    }
    
    func login() {
        if let e = email.text {
            if e.isValidEmail() {
                if let p = password.text {
                    if p.isValidPassword() {
                        PKHUD.sharedHUD.contentView = PKHUDProgressView()
                        PKHUD.sharedHUD.show()
                        
                        PFUser.logInWithUsernameInBackground(e, password: p, block: { (user: PFUser?, error: NSError?) in
                            PKHUD.sharedHUD.hide()
                            if let _ = user {
                                self.performSegueWithIdentifier(Segue.LoginSegue, sender: nil)
                            } else {
                                // Wrong password probably
                                print("Wrong password")
                            }
                        })
                    } else {
                        // Password not valid
                    }
                }
            } else {
                // Email not valid
            }
        }
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        print(notification)
        self.view.frame = CGRectMake(0,-215, self.view.frame.width, self.view.frame.height)
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
    }
    
    func registerKeyboardEvents() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardEvents() -> Void {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

}