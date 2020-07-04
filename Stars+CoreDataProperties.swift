//
//  Stars+CoreDataProperties.swift
//  Landmarks
//
//  Created by User on 08.06.2020.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension Stars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stars> {
        return NSFetchRequest<Stars>(entityName: "Stars")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isFavorite: Bool

}
