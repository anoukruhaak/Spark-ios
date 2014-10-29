//
//  SPDataSource.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/21/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//


import UIKit

class SPDataSource: NSObject, UITableViewDataSource, UIWebViewDelegate {
    
    var sparkArray: [Spark] = []
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    var controller: SparkList?

       
    func getAllSparks()
    {
        let mySparks = delegate.hoodie?.store.findAllObjectsWithType("spark")
        
        sparkArray = getSparksFromDictionary(mySparks!)
    }
    
    func getSparksFromDictionary(unparsedSparks: NSArray) -> Array<Spark> {
        
        var mySparks: [Spark] = []
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        for sparkDict in unparsedSparks
        {
            //TODO: fix date stuff
            //println(sparkDict.objectForKey("createdAt")! as String)
            let dateString = sparkDict.objectForKey("createdAt")! as String
            let dateCreated: NSDate = dateFormatter.dateFromString(dateString)!
            let textString: String = (sparkDict.objectForKey("text")as String)
            let idString: String = (sparkDict.objectForKey("id")as String)
            let spark = Spark(text: textString, date: dateCreated)
            spark.sparkId = idString
            
            mySparks.append(spark)
        }
        
        return mySparks
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: SPSparkCell = tableView.dequeueReusableCellWithIdentifier("SparkCell", forIndexPath: indexPath) as SPSparkCell
        
        var spark = sparkArray[indexPath.row]
        
        let error: NSErrorPointer = NSErrorPointer()
        var baseHTMLString = MMMarkdown.HTMLStringWithMarkdown("\(spark.sparkText)", error: error)
        
       let newHTMLString = "<style> img{max-width:300px} h1, h2, h3, body{max-width:300px; font: 16px \"Helvetica\";} strong{color: green} h1{font-size: 26px;} h2{font-size: 22px;} h3{font-size: 18px;}</style>\(baseHTMLString)"
        NSLog("\(newHTMLString)")
        
        cell.webContent.delegate = controller!
        cell.webContent.hidden = true;
        cell.webContent.loadHTMLString(newHTMLString, baseURL: nil)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.getAllSparks()
                
        return  sparkArray.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            let sparkToDelete: Spark = sparkArray[indexPath.row]
            
            delegate.hoodie!.store.removeObjectWithID(sparkToDelete.sparkId, andType: "spark", onRemoval:{(success: Bool?, error: NSError?) -> Void in
            tableView.reloadData()
            })
        }
    }
    
 }