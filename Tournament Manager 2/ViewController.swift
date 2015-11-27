//
//  ViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/8/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//


import UIKit
import CoreData

var brackets = [NSManagedObject]()
var currentBracket: Bracket? //the current bracket in use

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
            brackets = results as! [NSManagedObject]
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
        if(brackets[indexPath.row].valueForKey("active") as? Bool == true){
            activeOrNot = "Active"
        }
        else
        {
            activeOrNot = "Inactive"
        }
        
        let selectedBracket = brackets[indexPath.row]
        
        let bracketName = selectedBracket.valueForKey("name") as? String
        let bracketCreationDate = selectedBracket.valueForKey("creationDate") as? String
        cell.textLabel!.text = bracketName! + " " + bracketCreationDate! + " " + activeOrNot!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedBracket = brackets[indexPath.row]
        let bracketName = selectedBracket.valueForKey("name") as? String
        let bracketParts = selectedBracket.valueForKey("numParts") as? Int
        let bracketCreationDate = selectedBracket.valueForKey("creationDate") as? String
        let bracketActive = selectedBracket.valueForKey("active") as? Bool
        let bracketType = selectedBracket.valueForKey("bracketType") as? Int
        let bracketElim = selectedBracket.valueForKey("singleElim") as? Bool
        
        currentBracket = Bracket(bracketName: bracketName!, elim: bracketElim!, numPart: bracketParts!, type: bracketType!, activeStatus: bracketActive!, crDate: bracketCreationDate!)
        
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    
    
}

