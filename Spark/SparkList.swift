//
//  SparkList.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/18/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SparkList: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    let sparksList: UITableView = UITableView(frame: UIScreen.mainScreen().bounds)

    var sparkArray = [Spark]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sparks"
        
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newSpark")
        
        self.navigationItem.rightBarButtonItem = rightBarButton;

        sparksList.delegate = self
        sparksList.dataSource = self
        self.view.addSubview(sparksList)
        
        let sparkOne: Spark =  Spark()
        sparkOne.sparktext = "Create your first spark"
        sparkArray.append(sparkOne)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func newSpark ()
    {
        let detailVC = SparkDetail()
        detailVC.spark = Spark()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //TableView datasource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = sparksList.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.text = sparkArray[indexPath.row].sparktext
        
        return cell!
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sparkArray.count
    }
    
    //Tableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = SparkDetail()
        detailVC.spark = sparkArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
}
