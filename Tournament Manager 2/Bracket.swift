//
//  Bracket.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/28/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Bracket: NSManagedObject {
    //at bracket creation, create the match objects that will be associated with the bracket

    func generateMatches(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //single elimination tree only
        if singleElim == true {
            for index in 0...62
            {
                let entity = NSEntityDescription.entityForName("Match", inManagedObjectContext: managedContext)
                let createdMatch = Match(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                createdMatch.score_player1 = 0
                createdMatch.score_player2 = 0
                createdMatch.parent_bracket = currentBracket
                createdMatch.inProgress = false
                createdMatch.player1 = nil
                createdMatch.player2 = nil
                createdMatch.hasBye = 0 //assume all are un-byed at this point
                createdMatch.matchNumber = index
                createdMatch.playerDQ = 0
                
                createdMatch.next_loser = nil
                
                if index == 62 {
                    createdMatch.lastMatch = true
                }
                else{
                    createdMatch.lastMatch = false
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
        }
            //double elimination
        else {
            for index in 0...126
            {
                let entity = NSEntityDescription.entityForName("Match", inManagedObjectContext: managedContext)
                let createdMatch = Match(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                createdMatch.score_player1 = 0
                createdMatch.score_player2 = 0
                createdMatch.parent_bracket = currentBracket
                createdMatch.inProgress = false
                createdMatch.player1 = nil
                createdMatch.player2 = nil
                createdMatch.hasBye = 0
                createdMatch.matchNumber = index
                
                if index == 126 {
                    createdMatch.lastMatch = true
                }
                else{
                    createdMatch.lastMatch = false
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
            
        }
        
    }
    
    
}
