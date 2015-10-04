//
//  NewAccountController.swift
//  BEO App
//
//  Created by Marcus Gabilheri on 10/4/15.
//  Copyright © 2015 Team Black. All rights reserved.
//

import Foundation
import UIKit
import B68UIFloatLabelTextField
import Parse
import PKHUD

class NewAccountController : UIViewController {
    
    @IBOutlet weak var name: B68UIFloatLabelTextField!
    @IBOutlet weak var lastName: B68UIFloatLabelTextField!
    @IBOutlet weak var email: B68UIFloatLabelTextField!
    @IBOutlet weak var phoneNumber: B68UIFloatLabelTextField!
    @IBOutlet weak var repeatPassword: B68UIFloatLabelTextField!
    @IBOutlet weak var password: B68UIFloatLabelTextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func createAccount(sender: UIButton) {
        if name.text?.length() > 2 {
            if lastName.text?.length() > 2 {
                if phoneNumber.text?.length() > 8 {
                    if let e = email.text {
                        if e.isValidEmail() {
                            if let p = password.text {
                                if p.isValidPassword() {
                                    if let rp = repeatPassword.text {
                                        if rp == p {
                                            PKHUD.sharedHUD.contentView = PKHUDProgressView()
                                            PKHUD.sharedHUD.show()
                                            let user = PFUser()
                                            user.username = e
                                            user.email = e
                                            user.password = p
                                            user["name"] = name.text
                                            user["lastName"] = lastName.text
                                            user["phone"] = phoneNumber.text
                                            user.signUpInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) in
                                                PKHUD.sharedHUD.hide()
                                                if let error = error {
                                                   // error creating user
                                                    let errorString = error.userInfo["error"] as? NSString
                                                    print(errorString)
                                                } else {
                                                    // User registered successfully
                                                    if let _ = PFUser.currentUser() {
                                                        self.performSegueWithIdentifier(Segue.RegisterSegue, sender: nil)
                                                    } else {
                                                        print("User is nil")
                                                    }
                                                }
                                            })
                                        } else {
                                            // passwords don't match
                                        }
                                    }
                                } else {
                                    // Password must bet at least 6 characters long and contain tat least 1 number
                                }
                            }
                        } else {
                            // Email is not valid
                        }
                    }
                } else {
                    // phone number should have at least 9 characters
                }
            } else {
                // lastName not valid
            }
        } else {
            // name is not valid
        }
    }
}