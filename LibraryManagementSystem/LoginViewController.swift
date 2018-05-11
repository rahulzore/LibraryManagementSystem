//
//  LoginViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/25/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: RoundedWhiteButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        loginButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        
       
        // Do any additional setup after loading the view.
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func handleLogin(_ sender: UIButton) {
        
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)!{
            self.throwAlert(reason: "All Fields are mandatory")
        }
        
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                self.resetForm()
            }
            
        }
    }
    
    func resetForm(){
        let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    //    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func throwAlert(reason :String){
        let alert = UIAlertController(title: "Hotel Management App", message:reason , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

}
