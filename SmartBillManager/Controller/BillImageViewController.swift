//
//  BillImageViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 13/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase

class BillImageViewController: UIViewController {
    
    var selectedBill: Bill? {
        didSet{
        }
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var index: Int?
    var displayText: String?
    @IBOutlet weak var ivBillImage: UIImageView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
        ivBillImage.image = selectedBill?.billImage
        
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self

    }
    

    @IBAction func sharePressed(_ sender: UIButton) {
        let imageToShare = [ ivBillImage.image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension BillImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivBillImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = ivBillImage.image {
                let ratioW = ivBillImage.frame.width / image.size.width
                let ratioH = ivBillImage.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > ivBillImage.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - ivBillImage.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > ivBillImage.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - ivBillImage.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
