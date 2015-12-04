//
//  StationsViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit
import CoreData



class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //Table
    @IBOutlet weak var StationsTable: UITableView!
    
    //Label
    @IBOutlet weak var BottomLabel: UILabel!
    
    
    //Textfield
    @IBOutlet weak var StationName: UITextField!
    @IBOutlet weak var TimerLength: UITextField!
    
    //selected index of a station from the table
    var selectedStation: Int?
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    } //one section
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    } //rows however long the stations array is
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let stationNameRow = stations[indexPath.row].name
        if (stations[indexPath.row].filled == false){
            cell.textLabel?.text = "\(stationNameRow!) - Station is Open."
            return cell
        }
        
        else{
            cell.textLabel?.text = "\(stationNameRow!) - Station is in use."
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Number of Stations: \(stations.count)"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedStation = indexPath.row
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func backButton(){
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Add Stations"
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        navigationItem.leftBarButtonItem = backButton
        BottomLabel.text = ""
    }

    @IBAction func AddStation(sender: UIButton) {
        if(StationName == ""){
            BottomLabel.text = "Please input a name for the Station"
        }
        else{
            let finalName = StationName.text
            
            if(TimerLength.text == "") {
                let finalTimer = defaultTimer
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                
                let entity = NSEntityDescription.entityForName("Station", inManagedObjectContext: managedContext)
                let newStation = Station(entity: entity!, insertIntoManagedObjectContext: managedContext)
                newStation.name = finalName
                newStation.filled = 0
                newStation.time = finalTimer
                newStation.current_match = nil
                newStation.associated_bracket = currentBracket
                
                do {
                    try managedContext.save()
                    stations.append(newStation)
                    StationsTable.reloadData()
                    TimerLength.text = ""
                } catch let error as NSError {
                    print ("Could not save \(error)")
                }
                
                
                BottomLabel.text = "Addition Successful"
                StationName.text = ""
            }
            
            else {
                let finalTimer = Int(TimerLength.text!)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                
                let entity = NSEntityDescription.entityForName("Station", inManagedObjectContext: managedContext)
                let newStation = Station(entity: entity!, insertIntoManagedObjectContext: managedContext)
                newStation.name = finalName
                newStation.filled = 0
                newStation.time = finalTimer
                newStation.current_match = nil
                newStation.associated_bracket = currentBracket
                
                do {
                    try managedContext.save()
                    stations.append(newStation)
                    StationsTable.reloadData()
                } catch let error as NSError {
                    print ("Could not save \(error)")
                }
                
                BottomLabel.text = "Addition Successful"
                StationName.text = ""
            }
            
        }
    } //Adds a station to the table. If the TimerLength field is empty, it will use the DefaultTimer value that is set from the SettingsView
    
    @IBAction func DeleteSelectedStation(sender: UIButton) {
        if (selectedStation == nil ) {
            BottomLabel.text = "Select Station to delete"
        }
        else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(stations[selectedStation!])
            stations.removeAtIndex(selectedStation!)
            BottomLabel.text = "Station successfully deleted"
            do {
                try managedContext.save()
                StationsTable.reloadData()
            } catch let error as NSError {
                print("Could not delete \(error)")
            }
        }
        
    } //Delete a station from the table based on what row of the table is selected
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func helpButton(sender: AnyObject) {
    }
    
}
