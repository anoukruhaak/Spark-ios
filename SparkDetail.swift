//
//  SparkDetail.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/18/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SparkDetail: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UIAlertViewDelegate {
    
    var spark: Spark?
    let sparkTextView = UITextView(frame: CGRectMake(20.0, 66.0, 280.0, 280.0))
    var didEdit:Bool = false
    var sparkIsNew:Bool?
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    
    convenience init(spark: Spark, newSpark: Bool) {
        self.init()
        self.spark = spark
        sparkIsNew = newSpark

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sparks"
        self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(1.0)
        
        //navigation items
       
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "donePressed")
        
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPressed")
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        //Create a label with the spark text
        self.view.addSubview(sparkTextView)
        sparkTextView.text = spark!.sparkText
        sparkTextView.backgroundColor = UIColor.whiteColor()
        sparkTextView.textAlignment = NSTextAlignment.Left
        sparkTextView.textColor = UIColor.blackColor()
        sparkTextView.delegate = self
        sparkTextView.showsVerticalScrollIndicator = true
        sparkTextView.font = UIFont(name: "HelveticaNeue", size: 16.0)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func donePressed()
    {
        if didEdit {
             spark!.sparkText = sparkTextView.text
            if sparkIsNew! {
                saveSpark()
            }else{
                updateSpark()
            }
        }
    }
    
    func cancelPressed()
    {
        if didEdit {
            spark!.sparkText = sparkTextView.text
            let saveAlert = UIAlertView(title: "Save changes?", message: "Would you like to save the changes made to this spark file?", delegate: self, cancelButtonTitle: "No", otherButtonTitles: "Yes, save")
            saveAlert.tag = 101
            saveAlert.show()
            
        }
            
        else{
            self.navigationController?.popViewControllerAnimated(false)

        }
      
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        self.didEdit = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 && alertView.tag == 101
        {
            if sparkIsNew!{
                saveSpark()
            }else{
                updateSpark()
            }
        }else{
            self.navigationController?.popViewControllerAnimated(false)
        }
    }
    
    //TODO: use closure and add popVC as optional argument of function
    func saveSpark()
    {
        delegate.hoodie!.store.saveObject(spark!.getDictionary(spark!), withType: "spark", onSave:{(object: [NSObject : AnyObject]?, error: NSError?)-> Void in  })
        
        self.navigationController?.popViewControllerAnimated(false)

    }
    
    func updateSpark()
    {
        delegate.hoodie!.store.updateObjectWithID(spark!.sparkId, andType: "spark", withProperties: spark!.getDictionary(spark!), onUpdate: {(object: [NSObject : AnyObject]?, error: NSError?)-> Void in  })
         self.navigationController?.popViewControllerAnimated(false)

    }
}