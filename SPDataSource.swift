//
//  SPDataSource.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/21/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//


import UIKit

class SPDataSource: NSObject, UITableViewDataSource {
    
    var sparkArray: [Spark] = []
    let delegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    func getAllSparks()
    {
        let mySparks = delegate.hoodie?.store.findAllObjectsWithType("spark")
        
        println(mySparks)
        sparkArray = getSparksFromDictionary(mySparks!)
        
    }
    
    func getSparksFromDictionary(unparsedSparks: NSArray) -> Array<Spark> {
        
        var mySparks: [Spark] = []
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        for sparkDict in unparsedSparks
        {
            //TODO: fix date stuff
//            let dateString: String = (sparkDict.objectForKey("createdAt") as String)
//              let date: NSDate = dateFormatter.dateFromString(dateString)!
            let textString: String = (sparkDict.objectForKey("text")as String)
            let idString: String = (sparkDict.objectForKey("id")as String)
            let spark = Spark(text: textString, date: NSDate())
            spark.sparkId = idString
            
            mySparks.append(spark)
        }
        
        return mySparks
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.text = sparkArray[indexPath.row].sparkText
        return cell!
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.getAllSparks()
        if !(sparkArray.count > 0)
        {
            sparkArray.append(Spark(text: "Create your first spark", date: NSDate()))
        }
        
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