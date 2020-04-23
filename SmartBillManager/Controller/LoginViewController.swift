//
//  LoginViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var charIndex = 0.0
        titleLbl.text = ""
        let titleText = "BillMan"
        for letter in titleText {
            //delay each letter by 0.1 of a sec increase
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLbl.text?.append(letter)
            }
            charIndex += 1.0
        }

    }
    
    @IBOutlet weak var errorLoginLbl: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true //hide nav bar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false //unhide nav bar
    }
    @IBAction func loginAccount(_ sender: UIButton) {
        if let email = tfEmail.text, let password = tfPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    self.errorLoginLbl.alpha = 1.0
                    self.errorLoginLbl.text  = e.localizedDescription
                } else {
                    //Navigate to Home View controller
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
              
            }
        }
        
    }
    


}
