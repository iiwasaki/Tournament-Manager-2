//
//  Participant+CoreDataProperties.swift
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

extension Participant {

    @NSManaged var losses: NSNumber?
    @NSManaged var name: String?
    @NSManaged var seed: NSNumber?
    @NSManaged var wins: NSNumber?
    @NSManaged var parent_bracket: Bracket?
    @NSManaged var result_bracket: Bracket? 
    @NSManaged var rank: NSNumber?
}
