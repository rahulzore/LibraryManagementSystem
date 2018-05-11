//
//  BookIssueViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/27/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import CoreData

class BookIssueViewController: UIViewController {

    @IBOutlet weak var bookIssueIDField: UITextField!
    @IBOutlet weak var nuidFiled: UITextField!
    @IBOutlet weak var returnDateField: UIDatePicker!
    @IBOutlet weak var issueBookBtn: RoundedWhiteButton!
    
    var book = [String:AnyObject]()
    var issuedStudent : Student?
    var issuedBook = NSEntityDescription.insertNewObject(forEntityName: "Book", into: PersistenceService.context) as! Book
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        do{
            SingletonController.studentArray = try PersistenceService.context.fetch(fetchRequest)
        }catch{
            
        }
        
        for s in SingletonController.studentArray{
            print(s.name)
        }
        
        let id=book["id"] as! String
        var subtitles:String?
        var authors:String?
        if let volumeInfo = book["volumeInfo"] as? [String:AnyObject]{
            let title=volumeInfo["title"] as? String
            if let subtitle = volumeInfo["subtitle"] as? String {
               let subtitles=subtitle
            }
            var authorss:[String] = volumeInfo["authors"] as! [String]
            var author = ""
            for a in authorss{
                author = author + a
            }
           authors=author
            
            
            
//            issuedBook.id=id
//            issuedBook.title=title
//            issuedBook.subtitle=subtitles
//            issuedBook.authors=authors
            
            if id != nil {
                issuedBook.id = id
            }
                
            if title != nil {
                issuedBook.title = title
            } else {
                issuedBook.title = ""
            }
            if subtitles != nil {
                issuedBook.subtitle = subtitles
            } else {
                issuedBook.subtitle = ""
            }
            if authors != nil {
                issuedBook.authors = authors
            } else {
                issuedBook.authors = ""
            }
            
                
            
            
           
            
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        returnDateField.minimumDate = Date()
        
    }
    @IBAction func issueBookButton(_ sender: Any) {
        
        if (bookIssueIDField.text?.isEmpty)! || (nuidFiled.text?.isEmpty)!{
            self.throwAlert(reason: "All fields are mandatory")
            return
        }
        guard let nuid = nuidFiled.text else {return}
        var returndate = returnDateField.date
        var flag:Bool = false
        for student in SingletonController.studentArray{
            if student.nuid == nuid{
                issuedStudent = student
                flag = true
                break
            }
        }
        
        if flag == false {
            self.throwAlert(reason: "Student not found")
            return
        }
        
        let issuedDate = Date()
        let returnDate = returnDateField.date
        let id = bookIssueIDField.text
        print(issuedBook.id)
        SingletonController.createBookIssuance(student: issuedStudent!, book: issuedBook, issued: true, returned: false, issuedDate: issuedDate, returnedDate: returnDate, lateDays: 0, lateFee: 0, id: id!)
        self.throwAlert(reason: "Book issued successfully")
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func throwAlert(reason :String){
        let alert = UIAlertController(title: "Library Management System", message:reason , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

}
