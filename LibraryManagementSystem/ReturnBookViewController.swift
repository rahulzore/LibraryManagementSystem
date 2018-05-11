//
//  ReturnBookViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/28/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import CoreData

class ReturnBookViewController: UIViewController {

    @IBOutlet weak var bookIssueIDField: UITextField!
    @IBOutlet weak var bookIssueDetailsFiled: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        do{
           SingletonController.bookIssuedArray = try PersistenceService.context.fetch(fetchRequest)
        } catch {
            
        }
        
   
        

        // Do any additional setup after loading the view.
    }

    @IBAction func findBook(_ sender: Any) {
        
        if (bookIssueIDField.text?.isEmpty)!{
            self.throwAlert(reason: "All fields are mandatory")
        }
        
        let fetchRequest : NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [bookIssueIDField.text])
        let temp = try! PersistenceService.context.fetch(fetchRequest)
        var flag: Bool = false
        for data in temp as [NSManagedObject]{
            let id = data.value(forKey: "id") as! String
            if id == bookIssueIDField.text{
                flag = true
                let bi = data as! BookIssued
                bookIssueDetailsFiled.text = "Book Name: \((bi.book?.title)!)\nStudent Name: \((bi.student?.name)!)\nIssued Date: \((bi.issuedDate)!)\nReturn Date: \((bi.returnDate)!)\nLate Days: \((bi.lateDays))"
                
                
            } else {
                
                
            }
            
            
        }
        if flag == false{
            self.throwAlert(reason: "Book Issue ID not found!!")
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var returnBookFunction: RoundedWhiteButton!
    @IBAction func returnBookHandler(_ sender: Any) {
        let fetchRequest : NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [bookIssueIDField.text])
        let temp = try! PersistenceService.context.fetch(fetchRequest)
        for data in temp as [NSManagedObject]{
            let id = data.value(forKey: "id") as! String
            if id == bookIssueIDField.text{
                data.setValue(true, forKey: "returned")
                data.setValue(false, forKey: "issued")
                
                do{
                    try PersistenceService.context.save()
                    self.throwAlert(reason: "Book Returned Successfully!!")
                } catch{
                    
                }
            } else {
                self.throwAlert(reason: "Book Issue ID not found!!")
                
            }
            
            
        }
        
        
        
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
