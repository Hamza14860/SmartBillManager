//
//  AddBillViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 07/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    @IBOutlet weak var lblScanProgress: UILabel!
    @IBOutlet weak var ivBillImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bill Text Scanner"
     
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
 
    
    @IBAction func infoOcrPressed(_ sender: UIBarButtonItem) {
        let title: String = "What Happens When you click Scan Image?"
               let infoMsg: String = "Using the Bill Text Scanner you will be able to scan bill images by capturing/uploading the image.\n Our AI based server extracts important bill text out of the image and stores it for you so that you dont have to it yourself."
               displayInfo(title: title, message: infoMsg)
    }
    
    func displayInfo( title: String, message: String) {
        let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadImagePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        ivBillImage.image = pickedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func scanImagePressed(_ sender: UIButton) {
        lblScanProgress.text = "Processing Image..Please Wait"
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
