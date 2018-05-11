//
//  HomeViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/25/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        // Do any additional setup after loading the view.
    }

    @IBAction func handleLogOut(_ sender: UIBarButtonItem) {
        
        try! Auth.auth().signOut()
        
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

}
