//
//  SPAuthViewController.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/22/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SPAuthViewController: UIViewController, UITextFieldDelegate {

    let authView = SPAuthView(frame: CGRectMake(0, 62, 320, 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        
        view.backgroundColor = UIColor.whiteColor()
        
        authView.usernameText.delegate = self
        authView.password.delegate = self
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
