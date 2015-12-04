//
//  AddViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    //error label
    @IBOutlet weak var errorLabel: UILabel!
    
    //elimination type boolean
    var singleElim = true //default true
    
    var mainViewController: UIViewController!
    
    //text fields
    @IBOutlet weak var bracketName: UITextField!
    
    @IBOutlet weak var gameName: UITextField!
    //Single or Double Elimination
    @IBOutlet weak var elimType: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch elimType.selectedSegmentIndex {
        case 0:
            singleElim = true
        case 1:
            singleElim = false
        default:
            singleElim = true
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Add Bracket"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButton")
        navigationItem.leftBarButtonItem = cancelButton
        bracketName.text = ""
        errorLabel.text = ""
    }
    
    
    func cancelButton(){
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.mainViewController = UINavigationController(rootViewController: mainViewController)
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createButton(sender: AnyObject) {
        let name = bracketName.text
        let gname = gameName.text
        if (name == ""){
            errorLabel.text = "Name cannot be blank."
        }
        else if (gname == ""){
            errorLabel.text = "Game name cannot be blank."
        }
        else{
            // Use Core Data functionality to add the brackets!
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let entity = NSEntityDescription.entityForName("Bracket", inManagedObjectContext: managedContext)
            let savedBracket = Bracket(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            savedBracket.name = bracketName.text
            savedBracket.active = 0
            savedBracket.gameName = gameName.text
            
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let creationDate = formatter.stringFromDate(date)
            
            savedBracket.creationDate = creationDate
            
            savedBracket.numParts = nil //no participants yet
            savedBracket.bracketType = nil //no bracket type yet
            savedBracket.singleElim = singleElim
            savedBracket.started = false
            savedBracket.winner = nil
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
            
            currentBracket = savedBracket
            currentBracket?.generateMatches()
            competitors = currentBracket!.players?.allObjects as! [Participant]
            matches = currentBracket!.matches?.allObjects as! [Match]
            matches.sortInPlace{Int($0.matchNumber!) < Int($1.matchNumber!)}
            results.removeAll()
            
            for eachMatch in matches{
                eachMatch.assignWinner()
                eachMatch.assignLoser()
            }
            do {
                try managedContext.save()
                brackets.append(savedBracket)
                print("Saved")
            } catch let error as NSError {
                print("Could not save \(error)")
            }
            
            var bracketViewController: UIViewController!
            
            bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
            bracketViewController = UINavigationController(rootViewController: bracketViewController)
            self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
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
