//
//  StudentViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/26/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class StudentViewController: UIViewController {
    var student : Student?
    var books = [Book]()
    var bi1 = [BookIssued]()
    @IBOutlet weak var studentNamelbl: UILabel!
    @IBAction func handleLogout(_ sender: UIBarButtonItem) {
        
         try! Auth.auth().signOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        do{
            SingletonController.studentArray = try PersistenceService.context.fetch(fetchRequest)
        } catch{
            
        }
        
        let fetchRequest1: NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        do{
            SingletonController.bookIssuedArray = try PersistenceService.context.fetch(fetchRequest1)
        } catch {
            
        }
        
        let uid = Auth.auth().currentUser?.uid
        var username:String?
        Database.database().reference().child("users").child("profile").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            //print(snapshot)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                username = (dictionary["username"] as? String)!
                //print(username)
                self.studentNamelbl.text = "Welcome \(username!)"
                
                
            }
            
        }, withCancel: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    

}
