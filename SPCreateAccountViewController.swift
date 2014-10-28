//
//  SPCreateAccountViewController.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/23/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SPCreateAccountViewController: UIViewController, UITextFieldDelegate {

    let authView = SPAuthView(frame: CGRectMake(0, 62, 320, 300))
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Account"
        
        view.backgroundColor = UIColor.whiteColor()
        
        authView.usernameText.delegate = self
        authView.password.delegate = self
        authView.login.setTitle("Create", forState: UIControlState.Normal)
        authView.login.addTarget(self, action: "createPressed", forControlEvents: UIControlEvents.TouchUpInside)
        authView.createAccount.hidden = true;
        
        self.view.addSubview(authView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createPressed() {
        
        if ((countElements(authView.usernameText.text) > 4) && countElements(authView.password.text) > 4){
            
            delegate.hoodie!.account.signUpUserWithName(authView.usernameText.text, password: authView.password.text, onSignUp: {(success: Bool?, error: NSError?) -> Void in
                
                if (error != nil) {
                    let alert = UIAlertView(title: "Error!", message: error!.localizedDescription, delegate: self, cancelButtonTitle: "Ok")
                    alert.show()
                    
                }else{
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                
            })

            
            
        }else{
            let alert = UIAlertView(title: "Oops", message: "Please enter username and password. \n Each should have at least 5 characters", delegate: self, cancelButtonTitle: "Got it!")
            alert.show()
        }
        
    }


}
