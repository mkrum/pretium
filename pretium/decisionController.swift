//
//  decisionController.swift
//  pretium
//
//  Created by Luke Duane on 2/20/16.
//  Copyright © 2016 ndSophware. All rights reserved.
//

//import Cocoa
import UIKit

class decisionController: UIViewController {
    
    var prices:[String]=[]
    
    @IBAction func chargeAgain(sender: AnyObject) {
        if let navigationController = navigationController{
            if let myTableViewController = navigationController.viewControllers[0] as? myTableViewController {
                print("in decision controller")
                print(prices)
                myTableViewController.prices=prices
                myTableViewController.pricesToRemove.removeAll()
            }
            navigationController.popToViewController(navigationController.viewControllers[0], animated: true)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="backToNavigation"){
            let navigationController=segue.destinationViewController as! UINavigationController
            if let myTableViewController = navigationController.viewControllers[0] as? myTableViewController {
                print("in decision controller")
                print(prices)
                myTableViewController.prices=prices
                myTableViewController.pricesToRemove.removeAll()
            }
        }
        if (segue.identifier=="backToStart"){
            if let startViewController = segue.destinationViewController as? startViewController {
                startViewController.prices=prices
            }
            
        }
        
    }

}
