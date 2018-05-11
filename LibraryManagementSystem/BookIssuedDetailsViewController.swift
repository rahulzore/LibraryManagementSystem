//
//  BookIssuedDetailsViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/27/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit

class BookIssuedDetailsViewController: UIViewController {

    @IBOutlet weak var studentNamelbl: UILabel!
    @IBOutlet weak var bookNamelbl: UILabel!
    @IBOutlet weak var issuedDatelbl: UILabel!
    @IBOutlet weak var returnDateLbl: UILabel!
    @IBOutlet weak var returnedlbl: UILabel!
    @IBOutlet weak var lateDayslbl: UILabel!
    @IBOutlet weak var lateFeesLbl: UILabel!
    
    @IBOutlet weak var id: UILabel!
    var bookIssued : BookIssued?
    override func viewDidLoad() {
        super.viewDidLoad()
        let lateDays = self.lateDaysCalculator(startDate: (bookIssued?.returnDate)!, endDate: Date())
        
        
        studentNamelbl.text = bookIssued?.student?.name
        bookNamelbl.text = bookIssued?.book?.title
        issuedDatelbl.text = bookIssued?.issuedDate?.toString(dateFormat: "yyyy/MMM/dd HH:mm:ss")
        returnDateLbl.text = bookIssued?.returnDate?.toString(dateFormat: "yyyy/MMM/dd HH:mm:ss")
        if bookIssued?.returned == false{
            returnedlbl.text = "No"
            if lateDays <= 0 {
                lateDayslbl.text = "0"
                lateFeesLbl.text = "$ 0"
            } else {
                lateDayslbl.text = String(lateDays)
                let temp = String(lateDays*20)
                lateFeesLbl.text = "$\(temp)"
            }

        } else if bookIssued?.returned == true {
            returnedlbl.text = "Yes"
            if lateDays <= 0 {
                lateDayslbl.text = "0"
                lateFeesLbl.text = "$ 0"
            } else {
                lateDayslbl.text = String(lateDays)
                let temp = String(lateDays*20)
                lateFeesLbl.text = "$\(temp)"
            }
        }
        id.text = bookIssued?.id
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func lateDaysCalculator(startDate: Date, endDate: Date) -> Int{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = .day
        formatter.unitsStyle = .full
        let result = formatter.string(from: startDate, to: endDate)
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
        
        return days!
        
    }

}


