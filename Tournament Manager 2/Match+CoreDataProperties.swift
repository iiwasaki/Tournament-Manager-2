//
//  Match+CoreDataProperties.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/29/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Match {

    @NSManaged var score_player1: NSNumber?
    @NSManaged var score_player2: NSNumber?
    @NSManaged var lastMatch: NSNumber?
    @NSManaged var inProgress: NSNumber?
    @NSManaged var next_winner: Match?
    @NSManaged var next_loser: Match?
    @NSManaged var player1: Participant?
    @NSManaged var player2: Participant?
    @NSManaged var parent_bracket: Bracket?
    @NSManaged var hasBye: NSNumber?
    // has bye: 0 means 
    @NSManaged var matchNumber: NSNumber? //the number for the match
    @NSManaged var current_station: Station?
    @NSManaged var playerDQ: NSNumber?
}
