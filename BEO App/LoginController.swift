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

class LoginController : UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func login(sender: UIButton) {
        
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
    
    @IBAction func callFrontDesk(sender: UIBarButtonItem) {
        
    }
}