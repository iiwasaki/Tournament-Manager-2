//
//  Bracket+CoreDataProperties.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/28/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bracket {

    @NSManaged var active: NSNumber?
    @NSManaged var creationDate: String?
    @NSManaged var name: String?
    @NSManaged var numParts: NSNumber?
    @NSManaged var singleElim: NSNumber?
    @NSManaged var players: NSSet?
    @NSManaged var results: NSSet?
    @NSManaged var started: NSNumber? //started bracket or not, for editing participants
    @NSManaged var winner: Participant? 
    @NSManaged var matches: NSSet?
    @NSManaged var stations: NSSet?
    @NSManaged var bracketType: NSNumber?
    @NSManaged var gameName: String?
    /* Bracket Types:
    0: 4-person, single-elimination
    1: 4-person, double-elimination
    2: 8-person, single-elim
    3: 8-person, double-elim
    4: 16-person, single-elim
    5: 16-person, double-elim
    6: 32-person, single-elim
    7: 32-person, double-elim
    8: 64-person, single-elim
    9: 64-person, double-elim
    */
}
