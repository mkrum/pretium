//
//  totalUpViewController.swift
//  pretium
//
//  Created by Luke Duane on 2/20/16.
//  Copyright © 2016 ndSophware. All rights reserved.
//

import UIKit

class totalUpViewController: UIViewController {
    
    var total: Double = 0.0
    var prices:[String] = []

    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad(){
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        totalLabel.text=(formatter.stringFromNumber(total))
    }
    

}

