//
//  Songs+CoreDataProperties.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 09/01/24.
//
//

import Foundation
import CoreData


extension Songs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Songs> {
        return NSFetchRequest<Songs>(entityName: "Songs")
    }

    @NSManaged public var artistName: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var imagePath: String?
    @NSManaged public var title: String?
    @NSManaged public var album: String?

}

extension Songs : Identifiable {

}
