//
//  AddContractViewController.swift
//  WorkingDays
//
//  Created by Nikolay Dudrenov on 5/11/15.
//  Copyright (c) 2015 Nikolay Dudrenov. All rights reserved.
//

import UIKit
import CoreData

class AddContractViewController: UIViewController {

    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var shipNameTextField: UITextField!
    @IBOutlet weak var positionOnBoardTextField: UITextField!
    @IBOutlet weak var workingDaysLabel: UILabel!
    
    // Start Date Text Field- action and format for DatePicker
    @IBAction func startDateTextFieldEditing(sender: UITextField) {
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("startDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func startDatePickerValueChanged(sender: UIDatePicker) {
        var dateformatter = NSDateFormatter()
        dateformatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        startDateTextField.text = dateformatter.stringFromDate(sender.date)
        println("Start Date is: " + startDateTextField.text)
    }
    
    // End Date Text Field - action and format for DatePicker
    @IBAction func endDateTextFieldEditing(sender: UITextField) {
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("endDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func endDatePickerValueChanged(sender: UIDatePicker) {
        var dateformatter = NSDateFormatter()
        dateformatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        endDateTextField.text = dateformatter.stringFromDate(sender.date)
        println("End Date is: " + endDateTextField.text)
    }
    
    // Hide keyboard or DatePicker
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // Calculate the working days
    @IBAction func calculateWorkingDays() {
        // Date format and localisation
        let calendar = NSCalendar.currentCalendar()
        let unit: NSCalendarUnit = .DayCalendarUnit
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let startDatePicker: NSDate = dateFormatter.dateFromString(startDateTextField.text)!
        let endDatePicker: NSDate = dateFormatter.dateFromString(endDateTextField.text)!
        
        // Calculate the diference and set the workingDays TextField to Days -> String from Int + 1
        let components = calendar.components(unit, fromDate: startDatePicker, toDate: endDatePicker, options: nil)
        println(components)
        workingDaysLabel.text = "\(components.day + 1)"
        
    }
    
    @IBAction func buttonSavePressed(sender: UIBarButtonItem) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        let ent = NSEntityDescription.entityForName("Contract", inManagedObjectContext: context)!
        
        var newContractData = Contract(entity: ent, insertIntoManagedObjectContext: context)
        
        newContractData.stratdate = startDateTextField.text
        newContractData.enddate = endDateTextField.text
        newContractData.ship = shipNameTextField.text
        newContractData.position = positionOnBoardTextField.text
        newContractData.workingdays = workingDaysLabel.text!
        
        println(newContractData)
        context.save(nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
