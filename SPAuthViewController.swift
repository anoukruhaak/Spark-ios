//
//  SPAuthViewController.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/22/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

func setUserLoggedIn(loggedIN: Bool) {
    NSUserDefaults.standardUserDefaults().setBool(loggedIN, forKey: "loggedIn")
}

func isLoggedIn()-> Bool{
    let state: Bool? =  NSUserDefaults.standardUserDefaults().boolForKey("loggedIn")
    
    if (state != nil)
    {
        return state!
    }else{
        return false
    }
}

class SPAuthViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {

    let authView = SPAuthView(frame: CGRectMake(0, 62, 320, 300))
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        
        view.backgroundColor = UIColor.whiteColor()
        
        authView.usernameText.delegate = self
        authView.password.delegate = self
        authView.login.addTarget(self, action: "loginPressed", forControlEvents: UIControlEvents.TouchUpInside)
        authView.createAccount.addTarget(self, action: "createAccountPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        if isAccountCreated()
        {
            authView.createAccount.hidden = true
        }
        
        self.view.addSubview(authView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    func loginPressed() {
        
        if ((countElements(authView.usernameText.text) > 0) && countElements(authView.password.text) > 0){
            delegate.hoodie!.account.signInUserWithName(authView.usernameText.text, password: authView.password.text, onSignIn:{(success: Bool?, error: NSError?) -> Void in
                
                 if (error != nil) {
                    setUserLoggedIn(false)
                    let alert = UIAlertView(title: "Error!", message: error!.localizedDescription, delegate: self, cancelButtonTitle: "Ok")
                    alert.show()
                 }else{
                     setUserLoggedIn(true)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            
            })

            
        }else{
            let alert = UIAlertView(title: "Oops", message: "Please enter username and password", delegate: self, cancelButtonTitle: "Got it!")
            alert.show()
        }
       
    }
    
    func createAccountPressed()
    {
        let createVC = SPCreateAccountViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
    }

}
