//
//  ViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/25/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if let user = Auth.auth().currentUser {
//            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
//        }
    }
}

