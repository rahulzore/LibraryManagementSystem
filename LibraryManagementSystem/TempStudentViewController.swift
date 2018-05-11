//
//  TempStudentViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/28/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class TempStudentViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLABEL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        do{
            SingletonController.bookIssuedArray = try PersistenceService.context.fetch(fetchRequest)
        } catch{
            
        }
        
        var username:String?
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child("profile").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            //print(snapshot)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                username = dictionary["username"] as? String
                print(username!)
                self.usernameLABEL.text = username
                
                
                
                
            }
            
        }, withCancel: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        try! Auth.auth().signOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StudentTableViewController {
            destination.username = usernameLABEL.text
        }
    }
    
    @IBAction func showPendingBooks(_ sender: Any) {
        
        performSegue(withIdentifier: "tempStudentSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
