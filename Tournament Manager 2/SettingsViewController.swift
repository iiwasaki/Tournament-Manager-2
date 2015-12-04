//
//  SettingsViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit
import CoreData


class SettingsViewController: UIViewController {

    @IBOutlet weak var UpdateLabel: UILabel!
    
    //Update Timer Button
    @IBAction func UpdateTimer(sender: UIButton) {
        if (DefTimer.text == ""){
            UpdateLabel.text = "Please input a number in seconds to update the default timer"
        }
        else {
            defaultTimer = Int(DefTimer.text!)
            UpdateLabel.text = "Timer Updated!"
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(Int(UpdateLabel.text!), forKey: "defaultTimer")
        }
    }

    
    @IBOutlet weak var sortingControl: UISegmentedControl!

    
    @IBOutlet weak var ascOrDsc: UISegmentedControl!
    
    @IBAction func sortingChanged(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        switch sortingControl.selectedSegmentIndex {
        case 0:
            defaults.setInteger(0, forKey: "sortingMethod")
        case 1:
            defaults.setInteger(1, forKey: "sortingMethod")
        case 2:
            defaults.setInteger(2, forKey: "sortingMethod")
        default:
            break
        }
    }
    
    
    @IBAction func ascChanged(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        switch ascOrDsc.selectedSegmentIndex {
        case 0:
            defaults.setInteger(0, forKey: "ascMethod")
        case 1:
            defaults.setInteger(1, forKey: "ascMethod")
        default:
            break
    }
    }
    
    
    
    
    //Textfields
    @IBOutlet weak var DefTimer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Settings"
        if defaultTimer != nil {
            DefTimer.text! = String(defaultTimer)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Delete All Brackets Button
    @IBAction func deleteAllBrackets(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchrequest = NSFetchRequest(entityName: "Bracket")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchrequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
        } catch let error as NSError {
            print ("Error: \(error)")
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
