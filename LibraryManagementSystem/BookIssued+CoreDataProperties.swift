//
//  BookIssued+CoreDataProperties.swift
//  
//
//  Created by Rahul Zore on 4/28/18.
//
//

import Foundation
import CoreData


extension BookIssued {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookIssued> {
        return NSFetchRequest<BookIssued>(entityName: "BookIssued")
    }

    @NSManaged public var issued: Bool
    @NSManaged public var issuedDate: Date?
    @NSManaged public var lateDays: Int16
    @NSManaged public var lateFee: Double
    @NSManaged public var returnDate: Date?
    @NSManaged public var returned: Bool
    @NSManaged public var id: String?
    @NSManaged public var book: Book?
    @NSManaged public var student: Student?

}
