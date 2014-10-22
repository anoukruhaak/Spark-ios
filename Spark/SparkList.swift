//
//  SparkList.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/18/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SparkList: UIViewController, UITableViewDelegate, UINavigationControllerDelegate {
    
    let sparksList: UITableView = UITableView(frame: UIScreen.mainScreen().bounds)
    let dataSource = SPDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sparks"
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newSpark")
        
        self.navigationItem.rightBarButtonItem = rightBarButton;

        sparksList.delegate = self
        sparksList.dataSource = dataSource
        self.view.addSubview(sparksList)
        sparksList.reloadData()
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
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    //Tableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = SparkDetail()
        detailVC.spark = dataSource.sparkArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)

    }
}
