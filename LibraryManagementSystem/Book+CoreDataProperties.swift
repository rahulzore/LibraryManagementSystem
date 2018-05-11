//
//  Book+CoreDataProperties.swift
//  
//
//  Created by Rahul Zore on 4/27/18.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var authors: String?
    @NSManaged public var id: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}
