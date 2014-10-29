//
//  SPSparkCell.swift
//  Spark
//
//  Created by Anouk Ruhaak on 10/23/14.
//  Copyright (c) 2014 Anouk Ruhaak. All rights reserved.
//

import UIKit

class SPSparkCell: UITableViewCell{
    

    @IBOutlet weak var webContent: UIWebView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
