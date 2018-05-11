//
//  SingletonController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/26/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit

class SingletonController: NSObject {
    
    static var studentArray: [Student] = []
    static var bookArray: [Book] = []
    static var bookIssuedArray: [BookIssued] = []
    static var tempBookIssuedArray: [BookIssued] = []
    
    class func addStudent(name:String, email:String, phoneNumber:String, nuid:String){
        let student = Student(context: PersistenceService.context)
        student.name=name
        student.email=email
        student.phonenumber=phoneNumber
        student.nuid=nuid
        PersistenceService.saveContext()
        studentArray.append(student)
    }
    
    class func addBook(id:String, title:String, subtitle:String, authors:String){
        let book = Book(context: PersistenceService.context)
        book.id=id
        book.title=title
        book.subtitle=subtitle
        book.authors=authors
        PersistenceService.saveContext()
        bookArray.append(book)
    }
    
    class func createBookIssuance(student:Student, book:Book, issued:Bool, returned:Bool, issuedDate:Date, returnedDate:Date, lateDays:Int16, lateFee:Double, id:String){
        let bookIssued = BookIssued(context: PersistenceService.context)
        bookIssued.student=student
        bookIssued.book=book
        bookIssued.issued=issued
        bookIssued.returned=returned
        bookIssued.issuedDate=issuedDate
        bookIssued.returnDate=returnedDate
        bookIssued.lateDays=lateDays
        bookIssued.lateFee=lateFee
        bookIssued.id=id
        PersistenceService.saveContext()
        bookIssuedArray.append(bookIssued)
    }
    
    func lateDaysCalculator(startDate: Date, endDate: Date) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = .day
        formatter.unitsStyle = .full
        let result = formatter.string(from: startDate, to: endDate)
        return result!
        
    }

}
