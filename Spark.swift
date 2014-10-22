//
//  Spark.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/21/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import Foundation

class Spark: NSObject {
    var sparkTitle: NSString = "spark"
    var sparkText: NSString = ""
    var sparkDate: NSDate = NSDate()
    
    init(text:NSString, date:NSDate) {
        super.init()
        
        self.sparkText = text
        self.sparkDate = date
    }
    
    func getDictionary(Spark) -> NSDictionary {
        let sparkDict = ["title":"spark", "text":"(self.sparkTitle)", "date":"(self.sparkDate)"]
        
        return sparkDict
    }
    
    
}