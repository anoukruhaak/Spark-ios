//
//  SparkDetail.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/18/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SparkDetail: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate {
    
    var spark: Spark = Spark()
    let sparkTextField = UITextField(frame: CGRectMake(20.0, 80.0, 280.0, 400.0))
    var didEdit: Bool = false
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sparks"
        self.view.backgroundColor = UIColor.purpleColor().colorWithAlphaComponent(0.5)
        
        //navigation items
       
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "backPressed")
        
        let leftBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPressed")
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        //Create a label with the spark text
        self.view.addSubview(sparkTextField)
        sparkTextField.text = spark.sparktext
        sparkTextField.backgroundColor = UIColor.clearColor()
        sparkTextField.textAlignment = NSTextAlignment.Left
        sparkTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
        sparkTextField.textColor = UIColor.whiteColor()
        sparkTextField.delegate = self
        sparkTextField.placeholder = "Type away..!"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backPressed()
    {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    func cancelPressed()
    {
        if didEdit {
            let saveAlert = UIAlertView(title: "Save changes?", message: "Would you like to save the changes made to this spark file?", delegate: self, cancelButtonTitle: "No", otherButtonTitles: "Yes, save")
            saveAlert.tag = 101
            saveAlert.show()
        }else{
            self.navigationController?.popViewControllerAnimated(false)

        }
      
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        didEdit = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        didEdit = true
       
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 && alertView.tag == 101
        {
            self.navigationController?.popViewControllerAnimated(false)

        }
    }
}