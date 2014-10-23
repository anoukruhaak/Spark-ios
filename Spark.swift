//
//  Spark.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/21/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import Foundation

class Spark: NSObject {
    var sparkTitle: String = "spark"
    var sparkText: String = ""
    var sparkDate: NSDate = NSDate()
    var sparkId: String?
    
    init(text:NSString, date:NSDate) {
        super.init()
        
        self.sparkText = text
        self.sparkDate = date

    }
    
    func getDictionary(Spark) -> NSDictionary {
        let sparkDict = ["title":"spark", "text":"\(self.sparkText)", "date":"\(self.sparkDate)"]
        
        return sparkDict
    }
    
    func description() -> String {
        super.description
        
        return sparkText
    }
    
   
    
}