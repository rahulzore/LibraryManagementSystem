//
//  SingUpViewController.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/25/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit
import Firebase

class SingUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var phoneFiled: UITextField!
    @IBOutlet weak var nuidFiled: UITextField!
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var signUpButton: RoundedWhiteButton!
    @IBOutlet weak var tapToChangeButton: RoundedWhiteButton!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        signUpButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        tapToChangeButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProfileImage(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func signUpFunction(_ sender: UIButton) {
        
         let username = usernameField.text!
        let email = emailField.text!
         let password = passwordField.text!
        guard let image = profileImageView.image else {return}
         let phonenumber = phoneFiled.text!
         let nuid = nuidFiled.text!
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User Created")
                
                // Upload the image to firebase storage
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                
                                self.saveProfile(username: username, profileImageURL: url!) { success in
                                    if success{
                                        SingletonController.addStudent(name: username, email: email, phoneNumber: phonenumber, nuid: nuid)
                                        self.dismiss(animated: true, completion: nil)
                                        self.throwAlert(reason: "Student registered successfully")
                                        for student in SingletonController.studentArray{
                                            print(student.name)
                                            print(student.nuid)
                                            print(student.email)
                                            print(student.phonenumber)
                                        }
                                    } else {
                                        self.throwAlert(reason: "Error signing up")
                                    }
                                    
                                }
                                //self.dismiss(animated: true, completion: nil)
                            } else {
                                self.throwAlert(reason: "Error signing up")
                            }
                        }
                        
                        
                    } else {
                        //Unable to upload profile image
                        self.throwAlert(reason: "Error signing up")
                    }
                        
                    }
                    
                
                //Save the profile data to firebase database
                
                //dissmiss the view
                
                
            } else {
                print("Error creating user: \(error!.localizedDescription)")
                self.throwAlert(reason: "Error signing up")
            }
            
            
        }
        
        for student in SingletonController.studentArray{
            print(student.name)
        }
        
        
    }
    
    
    
    func throwAlert(reason :String){
        let alert = UIAlertController(title: "Library Management System", message:reason , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping((_ url:URL?)->())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else {return}
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil{
                if let url = metaData?.downloadURL(){
                    
                    completion(url)
                } else {
                    completion(nil)
                }
                //success
            } else {
                //failed
            }
            
        }
    }
    
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping((_ success:Bool)->())){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        let userObject = [
            "username":username,
            "photoURL":profileImageURL.absoluteString,
            "role":"student"
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
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

}

extension SingUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
