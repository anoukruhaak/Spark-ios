//
//  SPAuthView.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/22/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SPAuthView: UIView {

    let usernameText: UITextField
    let password: UITextField
    let createAccount: UIButton
    
    override init(frame: CGRect) {
        usernameText = UITextField(frame: CGRectMake(15, 46, 290, 40))
        password = UITextField(frame: CGRectMake(15, 126, 290, 40))
        createAccount = UIButton(frame: CGRectMake(30, 200, 60, 40))
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.configureTextField(usernameText, placeholder: "username")
        self.configureTextField(password, placeholder: "password")
        password.clearsOnBeginEditing = true
        password.secureTextEntry = true
        self.configureAccountCreated(createAccount)
        self.configureStaticLayout()
        
        self.addSubview(usernameText)
        self.addSubview(password)
        self.addSubview(createAccount)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTextField(textfield:UITextField, placeholder: String){
        textfield.userInteractionEnabled = true
        textfield.placeholder = placeholder
        textfield.backgroundColor = UIColor.whiteColor()
        textfield.layer.cornerRadius = 6.0
        textfield.layer.borderColor = UIColor.lightGrayColor().CGColor
        textfield.layer.borderWidth = 1.0
        textfield.textAlignment = NSTextAlignment.Center
        textfield.allowsEditingTextAttributes = false
        textfield.autocapitalizationType = UITextAutocapitalizationType.None
        textfield.autocorrectionType = UITextAutocorrectionType.No
    }
    
    
    
    func configureAccountCreated(button: UIButton){
        button.titleLabel?.textColor = UIColor.blueColor()
        button.titleLabel?.text = "Create account"
        button.tintColor = UIColor.redColor()
    }
    
    func configureStaticLayout(){
       
        
}
    
}
