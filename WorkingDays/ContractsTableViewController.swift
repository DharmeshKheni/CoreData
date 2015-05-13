//
//  ContractsTableViewController.swift
//  WorkingDays
//
//  Created by Nikolay Dudrenov on 5/11/15.
//  Copyright (c) 2015 Nikolay Dudrenov. All rights reserved.
//

import UIKit
import CoreData

class ContractsTableViewController: UITableViewController {
    
    var myList : Array<AnyObject> = []
    var totalContracts = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contex : NSManagedObjectContext = appDel.managedObjectContext!
        
        let freq = NSFetchRequest(entityName: "Contract")
        
        myList = contex.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID : NSString = "Default"
        var cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as! UITableViewCell
        
        var data : NSManagedObject = myList[indexPath.row] as! NSManagedObject
        
        var thisContract = myList[indexPath.row] as! Contract
        
        cell.detailTextLabel!.text = "From" + " " + thisContract.stratdate + " " + "to" + " " + thisContract.enddate
        cell.textLabel!.text = thisContract.workingdays + " " + "days" + " " + "as" + " " + thisContract.position + " " + "on" + " " + thisContract.ship
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contex : NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            contex.deleteObject(myList[indexPath.row] as! NSManagedObject)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
        var error : NSError? = nil
        if !contex.save(&error){
            abort()
        }
        
    }

}
