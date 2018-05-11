//
//  BookDetailViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/26/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import CoreData

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookIDlbl: UILabel!
    @IBOutlet weak var bookNamelbl: UILabel!
    @IBOutlet weak var bookSubTitlelbl: UILabel!
    @IBOutlet weak var bookAuthorslbl: UILabel!
    @IBOutlet weak var bookAvailablelbl: UILabel!
    
    @IBOutlet weak var studentButton: RoundedWhiteButton!
    var book = [String:AnyObject]()
    var flag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<BookIssued> = BookIssued.fetchRequest()
        do{
            SingletonController.bookIssuedArray = try PersistenceService.context.fetch(fetchRequest)
        } catch {
            
        }
        
        
        
        bookAvailablelbl.text = "Available"
        for bi in SingletonController.bookIssuedArray {
            if bi.book?.id == book["id"] as! String{
                if bi.issued == true{
                    bookAvailablelbl.text = "Not Available"
                    studentButton.isEnabled = false
                    
                    
                } else {
                    bookAvailablelbl.text = "Available"
                    
                    
                }
            } else {
                
            }
        }
        
        bookIDlbl.text = book["id"] as! String
        if let volumeInfo = book["volumeInfo"] as? [String:AnyObject] {
            bookNamelbl.text=volumeInfo["title"] as! String
            if let subtitle = volumeInfo["subtitle"] as? String {
            bookSubTitlelbl.text=subtitle
            }
            if let authors:[String] = volumeInfo["authors"] as? [String]{
            var author = ""
            for a in authors{
                author = author + a
            }
            bookAuthorslbl.text=author
            }

        }
        
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookIssueViewController{
            destination.book = book
        }
    }
   
    @IBAction func handleNextFunction(_ sender: Any) {
        if bookAvailablelbl.text! == "Not Available"{
            print("NOTTTTT AVAILABLE!!!!")
            self.throwAlert(reason: "Book issued to someone else. Please come back later!!")
        } else if bookAvailablelbl.text == "Available"{
            performSegue(withIdentifier: "issueBook", sender: self)
        }
    }
    
    func throwAlert(reason :String){
        let alert = UIAlertController(title: "Library Management System", message:reason , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

}
