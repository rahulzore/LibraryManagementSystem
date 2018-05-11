//
//  Student+CoreDataProperties.swift
//  
//
//  Created by Rahul Zore on 4/27/18.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var nuid: String?
    @NSManaged public var phonenumber: String?

}
