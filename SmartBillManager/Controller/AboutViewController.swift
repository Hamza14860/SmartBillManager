//
//  AboutViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase

class AboutViewController: UIViewController {
    @IBOutlet weak var ivProfilePic: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        let userID = Auth.auth().currentUser?.uid
        
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user model
            let value = snapshot.value as? NSDictionary
            let name = value?["Name"] as? String ?? ""
            self.lblName.text = name
            
            let email = value?["Email"] as? String ?? ""
            self.lblEmail.text = email

          }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            //Navigate back to login screen, pop out everything from navigation stack
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
