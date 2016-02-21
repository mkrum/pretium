//
//  myTableViewController.swift
//  tableViewTest
//
//  Created by Luke Duane on 2/20/16.
//  Copyright © 2016 Luke Duane. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    
    
    var prices: [String]=[]
    var pricesToRemove: [String] = []
    var totalPrice: Double = 0.0
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(totalPrice)
        if (segue.identifier=="itemToPayment"){
            if let totalUpViewController = segue.destinationViewController as? totalUpViewController {
                totalUpViewController.total=totalPrice
                totalUpViewController.prices=prices
                totalUpViewController.pricesToRemove=pricesToRemove
                print("in table view")
                print(prices)
            }
            
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.editing=true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tableView.allowsMultipleSelectionDuringEditing=true
//        self.tableView.backgroundColor = UIColor(red: 142.0/255, green: 23.0/255, blue: 37.0/255, alpha: 1.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        totalPrice=0
    }
    
    func toggleEdit(button: UINavigationItem){
        tableView.setEditing(!tableView.editing, animated: true)
        if tableView.editing{
            navigationItem.leftBarButtonItem?.title="Done"
        }
        else{
            navigationItem.leftBarButtonItem?.title="Edit"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //returns the number of sections. Return the amount that you want. This will probably be a variable sent to the class
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return prices.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! myTableViewCell
        
        cell.cellLabel.text=prices[indexPath.row] //populates cells
//        cell.contentView.backgroundColor = UIColor(red: 142.0/255, green: 23.0/255, blue: 37.0/255, alpha: 1.0)
        

        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = prices[indexPath.row]
        var stringPrice: String=""
        if let c = cell.characters.first{
            if(c=="$"){
                stringPrice=String(cell.characters.dropFirst())
            } else {
                stringPrice=cell
            }
        }
        let cellPrice=Double(stringPrice)
        totalPrice+=cellPrice!
        pricesToRemove.append(cell)
        print(cell)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell=prices[indexPath.row]
        let stringPrice=String(cell.characters.dropFirst())
        let cellPrice=Double(stringPrice)
        pricesToRemove = pricesToRemove.filter{$0 != cell}
        totalPrice-=cellPrice!
    }
}
