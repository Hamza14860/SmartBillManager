//
//  ForgetPassScreenViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase

class ForgetPassScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailToReset: UITextField!
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
        if let email = emailToReset.text {
            Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
                       if error != nil{
                           let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                           resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                           self.present(resetFailedAlert, animated: true, completion: nil)
                       }else {
                           let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                           resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                           self.present(resetEmailSentAlert, animated: true, completion: nil)
                       }
                   })
        }
        
    }
    
    

}
