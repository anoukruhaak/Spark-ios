//
//  SparkList.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/18/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SparkList: UIViewController, UITableViewDelegate, UINavigationControllerDelegate, UIWebViewDelegate,UIGestureRecognizerDelegate {
    
    let sparksList: UITableView = UITableView(frame: UIScreen.mainScreen().bounds)
    let dataSource = SPDataSource()
    var heightDict = [String: CGFloat]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sparks"
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newSpark")
        let leftBarButton = UIBarButtonItem(title: "Log in", style: UIBarButtonItemStyle.Plain, target: self, action: "loginPressed")
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton

        
        let nib = UINib(nibName: "SPSparkCell", bundle: nil)
        sparksList.registerNib(nib, forCellReuseIdentifier: "SparkCell")
        sparksList.delegate = self
        sparksList.backgroundColor = UIColor.clearColor()
        self.view.addSubview(sparksList)
        dataSource.controller = self
        sparksList.dataSource = dataSource
        sparksList.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapCell:")
        tapGesture.delegate = self
        sparksList.addGestureRecognizer(tapGesture)
  
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        sparksList.reloadData()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func newSpark()
    {
        var newSpark = Spark(text: "Type away!", date: NSDate())
        let detailVC = SparkDetail(spark: newSpark, newSpark: true)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func loginPressed()
    {
        let authVC = SPAuthViewController()
        self.navigationController?.pushViewController(authVC, animated: true)
    }
    
    //Tableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = SparkDetail(spark: dataSource.sparkArray[indexPath.row], newSpark: false)
        self.navigationController?.pushViewController(detailVC, animated: true)

    } 
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let sparkId: String = dataSource.sparkArray[indexPath.row].sparkId!
        let height: Optional = heightDict[sparkId]?
        
        if (height != nil){
            
            return height!
        }else{
            return 80
        }
    }
    
    func didTapCell(tap:UITapGestureRecognizer)
    {
        let point: CGPoint = tap.locationInView(sparksList)
        let index: NSIndexPath? = sparksList.indexPathForRowAtPoint(point)
        
        if (index != nil)
        {
            tableView(sparksList, didSelectRowAtIndexPath: index!)
        }
 
    }
    
    //pragma mark - Webview delegate
    func webViewDidFinishLoad(webView: UIWebView) {
        
        let cell: SPSparkCell = webView.superview?.superview? as SPSparkCell
        
        if (sparksList.indexPathForCell(cell) != nil){
            NSLog("\(sparksList.indexPathForCell(cell))")
            let index: NSIndexPath = sparksList.indexPathForCell(cell)!
            let sparkId: String = dataSource.sparkArray[index.row].sparkId!
            
            let newHeight: CGFloat = webView.scrollView.contentSize.height + 5.0
            let oldHeight: Optional = heightDict[sparkId]?
            
            webView.sizeToFit()
            
            if (oldHeight != nil){
                if newHeight == oldHeight{
                    webView.hidden = false
                }else{
                    heightDict[sparkId] = newHeight
                    sparksList.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.None)
                }
            }else{
                
                heightDict[sparkId] = newHeight
                sparksList.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.None)
            }
        }else{
            NSLog("Empty cell. weird")
        }
       
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == UIWebViewNavigationType.LinkClicked
        {
            UIApplication.sharedApplication().openURL(request.URL)
            return false
        }
        
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
