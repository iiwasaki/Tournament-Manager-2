//
//  ViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/8/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//


import UIKit
import CoreData

//global variables
var brackets = [Bracket]()
var currentBracket: Bracket? //the current bracket in use
var competitors = [Participant]() //current participants
var stations = [Station]() //current stations
var results = [Participant]() //results of the current bracket
var matches = [Match]()
var defaultTimer: Int?
var globalMatch: Match? 


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults.standardUserDefaults()
        if let index = defaults.objectForKey("selectedBracket"){
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Bracket")
            
            do {
                let results = try managedContext.executeFetchRequest(fetchRequest)
                brackets = results as! [Bracket]
                brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
                print("Fetched\n")
            } catch let error as NSError {
                print ("Could not fetch \(error), \(error.userInfo)")
            }
            currentBracket = brackets[Int(index as! NSNumber)]
            competitors = currentBracket!.players?.allObjects as! [Participant]
            matches = currentBracket!.matches?.allObjects as! [Match]
            stations = currentBracket!.stations?.allObjects as! [Station]
            competitors.sortInPlace{Int($0.seed!) < Int($1.seed!)}
            results = currentBracket!.results?.allObjects as! [Participant]
            matches.sortInPlace{Int($0.matchNumber!) < Int($1.matchNumber!)}
        }
        if let defTime = defaults.objectForKey("defaultTimer"){
            defaultTimer = Int(defTime as! String)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //Retreive brackets from databse

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Bracket")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            brackets = results as! [Bracket]
            let defaults = NSUserDefaults.standardUserDefaults()
            let sortingMethods = defaults.integerForKey("sortingMethod")
            let ascMethod = defaults.integerForKey("ascMethod")
            sortBrackets(sortingMethods, aOrD: ascMethod)
            print("Fetched\n")
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
    }
    
    func sortBrackets(way: Int, aOrD: Int){
        if way == 0{
            brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
            if aOrD == 1{
                brackets = brackets.reverse()
            }
        }
        else if way == 1{
            brackets.sortInPlace{$0.creationDate! < $1.creationDate!}
            if aOrD == 1 {
                brackets = brackets.reverse()
            }
        }
        else if way == 2{
            brackets.sortInPlace{Int($0.active!) < Int($1.active!)}
            if aOrD == 1 {
                brackets = brackets.reverse()
            }
        }
        else {
            brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brackets.count
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        var activeOrNot: String?
        if(brackets[indexPath.row].active == 0){
            activeOrNot = "Not Started"
        }
        else if (brackets[indexPath.row].active == 1)
        {
            activeOrNot = "Active"
        }
        else {
            activeOrNot = "Finished"
        }
        
        //brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
        let selectedBracket = brackets[indexPath.row]
        
        let bracketName = selectedBracket.name
        let bracketCreationDate = selectedBracket.creationDate
        cell.nameLabel!.text = bracketName!
        cell.dateLabel!.text = bracketCreationDate!
        cell.statusLabel!.text = activeOrNot!
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentBracket = brackets[indexPath.row]
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(indexPath.row, forKey: "selectedBracket")
        competitors = currentBracket!.players?.allObjects as! [Participant]
        matches = currentBracket!.matches?.allObjects as! [Match]
        stations = currentBracket!.stations?.allObjects as! [Station]
        competitors.sortInPlace{Int($0.seed!) < Int($1.seed!)}
        results = currentBracket!.results?.allObjects as! [Participant]
        matches.sortInPlace{Int($0.matchNumber!) < Int($1.matchNumber!)}
        
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    
    
    @IBAction func sortByName(sender: AnyObject) {
        brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
        tableView.reloadData()
    }
    
    @IBAction func sortByDate(sender: AnyObject) {
        brackets.sortInPlace{$0.creationDate! < $1.creationDate!}
        tableView.reloadData()
    }
    @IBAction func sortByStatus(sender: AnyObject) {
        brackets.sortInPlace{Int($0.active!) < Int($1.active!)}
        tableView.reloadData()
    }
    
}

