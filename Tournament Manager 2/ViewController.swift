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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Retreive brackets from databse
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Bracket")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            brackets = results as! [Bracket]
            print("Fetched\n")
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
        
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brackets.count
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        var activeOrNot: String?
        if(brackets[indexPath.row].active == true){
            activeOrNot = "Active"
        }
        else
        {
            activeOrNot = "Inactive"
        }
        
        let selectedBracket = brackets[indexPath.row]
        
        let bracketName = selectedBracket.name
        let bracketCreationDate = selectedBracket.creationDate
        cell.textLabel!.text = bracketName! + " " + bracketCreationDate! + " " + activeOrNot!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentBracket = brackets[indexPath.row]
        competitors = currentBracket!.players?.allObjects as! [Participant]
        
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    
    
}

