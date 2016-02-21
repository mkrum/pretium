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
    


    @IBAction func paymentButton(sender: AnyObject) {
        let url = NSURL(string: "http://api.reimaginebanking.com/enterprise/accounts?key=a542f50542abaf9fe3d1b119f1303007")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
        }
        dataTask.resume()
        print(textInput.text!)
    }
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad(){
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        totalLabel.text=(formatter.stringFromNumber(total))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="backToNavigation"){
            let navigationController=segue.destinationViewController as! UINavigationController
            if let myTableViewController = navigationController.viewControllers[0] as? myTableViewController {
                myTableViewController.prices=prices
            }
        }
        
    }


   /*
    prepare for segue function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier==""){
            if let totalUpViewController = segue.destinationViewController as? totalUpViewController {
                totalUpViewController.total=totalPrice
                totalUpViewController.prices=prices
            }
            
        }
        
    }
    */
    
}

