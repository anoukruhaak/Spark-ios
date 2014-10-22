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
        
        if !(sparkArray.count > 0)
        {
            sparkArray.append(Spark(text: "Create your first spark", date: NSDate()))
        }
        
        return  sparkArray.count
    }
 }