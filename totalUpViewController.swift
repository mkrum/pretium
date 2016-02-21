//
//  totalUpViewController.swift
//  pretium
//
//  Created by Luke "Thunderous Menace" Duane on 2/20/16.
//  Copyright © 2016 ndSophware. All rights reserved.
//

import UIKit

class totalUpViewController: UIViewController {
    
    var total: Double = 0.0
    var prices:[String]=[]
    var pricesToRemove: [String] = []


    @IBAction func paymentButton(sender: AnyObject) {
        print("payment")
        let url = NSURL(string: "http://api.reimaginebanking.com/enterprise/accounts?key=a542f50542abaf9fe3d1b119f1303007")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!) {(data, response, error) in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                if let nicknames = json["results"] as? [[String: AnyObject]] {
                    for nickname in nicknames {
                        if let name = nickname["nickname"] as? String {
                            if name.rangeOfString(self.textInput.text!) != nil{
                                print("Nickname: %@", name)
                            }
                        }
                    }
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        dataTask.resume()
        let para:NSMutableDictionary = NSMutableDictionary()
        para.setValue("balance", forKey: "medium")
        para.setValue("56c66be6a73e492741507c70", forKey: "payee_id")
        para.setValue(700, forKey: "amount")
        para.setValue("2016-02-21", forKey: "transaction_date")
        para.setValue("executed", forKey: "status")
        para.setValue("Testing", forKey: "description")
        let jsonData: NSData
        do{
            jsonData = try NSJSONSerialization.dataWithJSONObject(para, options: NSJSONWritingOptions())
            let url2 = NSURL(string: "http://api.reimaginebanking.com/accounts/%2256c66be6a73e492741507c75%22/transfers?key=a542f50542abaf9fe3d1b119f1303007")
            let newSes = NSURLSession.sharedSession()
            let postTask = newSes.uploadTaskWithRequest(NSURLRequest(URL: url2!), fromData: jsonData)
            postTask.resume()
        } catch {
            print("Yeah let me check for errors during a hackathon, oh wait")
        }
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
        print("below are the prices to remove")
        print(pricesToRemove)
        print("below are the prices")
        print(prices)
        if (segue.identifier=="toDecision"){
            if let decisionController = segue.destinationViewController as? decisionController {
                print(prices)
                decisionController.prices=prices
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor=UIColor(red: 142.0/255, green: 23.0/255, blue: 37.0/255, alpha: 1.0)
        
    }
}

