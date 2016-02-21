//
//  totalUpViewController.swift
//  pretium
//
//  Created by Luke Duane on 2/20/16.
//  Copyright © 2016 ndSophware. All rights reserved.
//

import UIKit

class totalUpViewController: UIViewController {
    let client = NSEClient.sharedInstance
    
    var total: Double = 0.0
    var prices:[String]=[]
    var pricesToRemove: [String] = []
    


    @IBAction func paymentButton(sender: AnyObject) {
        print("payment")
        let myAccountId = "56c66be6a73e492741507c7e"
        let url = NSURL(string: "http://api.reimaginebanking.com/accounts?key=54c00b786b0e4a4da4a8a33bb7ad7570")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!) {(data, response, error) in
            
            func testPostTransfer() {
                TransferRequest(block: {(builder:TransferRequestBuilder) in
                    builder.requestType = HTTPType.POST
                    builder.amount = 10
                    builder.transferMedium = TransactionMedium.BALANCE
                    builder.description = "test"
                    builder.accountId = myAccountId
                    builder.payeeId = "56c94e807742719f0e4d5189"
                    
                })?.send(completion: {(result) in
                    TransferRequest(block: {(builder:TransferRequestBuilder) in
                        builder.requestType = HTTPType.GET
                        builder.accountId = myAccountId
                    })?.send(completion: {(result:TransferResult) in
                        var transfers = result.getAllTransfers()
                        print(result)
                        
                        if transfers!.count > 0 {
                            let transferToGet = transfers![transfers!.count-1]
                            var transferToDelete:Transfer? = nil;
                            for transfer in transfers! {
                                if transfer.status == "pending" {
                                    transferToDelete = transfer
                                    //                            self.testDeleteTransfer(transferToDelete)
                                }
                            }
                            
                            //self.testGetOneTransfer(transferToGet)
                            //self.testPutTransfer(transferToDelete)
                            
                        }
                    })
                    
                })
            }
            
//            do {
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
//                
//                if let nicknames = json["results"] as? [[String: AnyObject]] {
//                    for nickname in nicknames {
//                        if let name = nickname["nickname"] as? String {
//                            if name.rangeOfString(self.textInput.text!) != nil{
//                                if let id = nickname["customer_id"] as? String {
//                                    if id != myAccountId{
//                                        // POST TRANSFER
//                                        TransferRequest(block: {(builder:TransferRequestBuilder) in
//                                            builder.requestType = HTTPType.POST
//                                            builder.amount = Int(self.total)
//                                            builder.transferMedium = TransactionMedium.BALANCE
//                                            builder.description = "test"
//                                            builder.accountId = id
//                                            builder.payeeId = myAccountId
//                                            
//                                        })?.send(completion: {(result) in
//                                            TransferRequest(block: {(builder:TransferRequestBuilder) in
//                                                builder.requestType = HTTPType.GET
//                                                builder.accountId = id
//                                            })?.send(completion: {(result:TransferResult) in
//                                                var transfers = result.getAllTransfers()
//                                                print(result)
//                                                
//                                                if transfers!.count > 0 {
//                                                    let transferToGet = transfers![transfers!.count-1]
//                                                    var transferToDelete:Transfer? = nil;
//                                                    for transfer in transfers! {
//                                                        if transfer.status == "pending" {
//                                                            transferToDelete = transfer
//                                                            //                            self.testDeleteTransfer(transferToDelete)
//                                                        }
//                                                    }
//                                                    
//                                                    self.testGetOneTransfer(transferToGet)
//                                                    //self.testPutTransfer(transferToDelete)
//                                                    
//                                                }
//                                            })
//                                            
//                                        })
//                                        // POST TRANSFER
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            } catch {
//                print("error serializing JSON: \(error)")
//            }
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        dataTask.resume()
        print(textInput.text!)
        
    }
    
    func testGetOneTransfer(transfer:Transfer) {
        TransferRequest(block: {(builder:TransferRequestBuilder) in
            builder.requestType = HTTPType.GET
            builder.transferId = transfer.transferId
        })?.send(completion: {(result:TransferResult) in
            let transferResult = result.getTransfer()
            print(transferResult)
        })
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
        for rem in pricesToRemove {
            prices = prices.filter{$0 != rem}
        }
        if (segue.identifier=="toDecision"){
            if let decisionController = segue.destinationViewController as? decisionController {
                print(prices)
                decisionController.prices=prices
            }
        }
        
    }
}

