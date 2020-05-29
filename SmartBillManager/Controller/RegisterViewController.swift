//
//  RegisterViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class RegisterViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var tfRePassword: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func registerAccount(_ sender: UIButton) {
        
        //if both email and pass r not nil, OPTIONAL BINDING AND CHAINING
        if let email = tfEmail.text, let password = tfPassword.text, let repassword = tfRePassword.text, let name = tfName.text {
            if password == repassword {
                Auth.auth().createUser(withEmail: email, password: password ) { authResult, error in
                    if let e = error {
                        print(e.localizedDescription) //understandable errors without gibberish
                        self.errorLbl.alpha = 1.0
                        self.errorLbl.text = e.localizedDescription
                    }
                    
                    else {
                        //Save Profile Info To DB
                        let userID = Auth.auth().currentUser!.uid

                        let user = User(Email: email, Name: name, ProfileUrl: "None Chosen")
                        
                        self.ref = Database.database().reference().child("Users").child(userID)

                        self.ref.setValue(user.toDictionary(), withCompletionBlock: { err, ref in
                            if let error = err {
                                print("User Mode was not saved: \(error.localizedDescription)")
                                self.errorLbl.alpha = 1.0
                                self.errorLbl.text = "User Not Registered."
                            } else {
                                print("User Model saved successfully in DB!")
                                //Navigate to chat view controller
                                self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                            }
                        })
                    }
                    
                    
                }
            }
            else {
                self.errorLbl.alpha = 1.0
                self.errorLbl.text = "Passwords Dont Match!"
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
