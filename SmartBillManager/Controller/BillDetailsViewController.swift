//
//  BillDetailsViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 13/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class BillDetailsViewController: UIViewController {
    var selectedBill: Bill? {
           didSet{
           }
       }
    
    
    @IBOutlet weak var contentView: UIView!
    
    let dataSource = ["Bill Text","Bill Image"]
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(dataSource.count)
        configurePageViewController()
        
        self.title = "Bill Details"

    }
    
    @IBAction func exportTextPressed(_ sender: UIBarButtonItem) {
        // text to share
        var text = "."
        if let catB = selectedBill?.billCategory, let amountB = selectedBill?.billAmount, let dateB = selectedBill?.billDate, let cnameB = selectedBill?.billCustomerName {
            text = " Category: " + catB + "\n Customer Name: " + cnameB + "\n Date: "
                   text += dateB + "\n Amount: " + amountB
        }
        else {
            text = "NAN"
        }
       

               // set up activity view controller
               let textToShare = [ text ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

               // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

               // present the view controller
               self.present(activityViewController, animated: true, completion: nil)
    }
    func configurePageViewController(){
        
        guard let pageViewController = storyboard?.instantiateViewController(identifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        
        pageViewController.didMove(toParent: self)
        
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view]
        
        //container for our pageViewCont flushed to edges of our container
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                      metrics: nil, views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
    }
    
    
    
    func detailViewControllerAt(index: Int) -> BillTextViewController? {
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: BillTextViewController.self)) as? BillTextViewController else {
            return nil
        }
        
        dataViewController.index = index
        dataViewController.displayText = dataSource[index]
        dataViewController.selectedBill = selectedBill
        //dataViewController.displayText = selectedBill?.billCustomerName"

        
      
        return dataViewController
    }
    
    func detailImageViewControllerAt(index: Int) -> BillImageViewController? {
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let billImageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: BillImageViewController.self)) as? BillImageViewController else {
            return nil
        }
        
        billImageViewController.index = index
        billImageViewController.displayText = dataSource[index]
        billImageViewController.selectedBill = selectedBill
        //billImageViewController.displayText = selectedBill?.billCustomerName

      
        
        return billImageViewController
    }
    

    

}

extension BillDetailsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        let dataViewController = viewController as? DataViewController
//
//        guard var currentIndex = dataViewController?.index else {
//            return nil
//        }
//
//        currentViewControllerIndex = currentIndex
//
//        if currentIndex == 0 {
//            return nil
//        }
//
//        currentIndex -= 1
//
//        return detailViewControllerAt(index: currentIndex)
        
        if currentViewControllerIndex == 0 {
            return nil
        }

        if currentViewControllerIndex == 1 {
            return detailViewControllerAt(index: currentViewControllerIndex)
        }
        currentViewControllerIndex -= 1
        
        return nil
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//        let dataViewController = viewController as? DataViewController
//        guard var currentIndex = dataViewController?.index else {
//                   return nil
//        }
//        if currentIndex == dataSource.count {
//            return nil
//        }
//        currentIndex += 1
//        currentViewControllerIndex = currentIndex
//
//        return detailViewControllerAt(index: currentIndex)
        
               
        if currentViewControllerIndex == dataSource.count {
            return nil
        }
        currentViewControllerIndex += 1

        print(currentViewControllerIndex)

        if currentViewControllerIndex == 1 {
            return detailImageViewControllerAt(index: currentViewControllerIndex)
        }
        
                
        return nil
    }
    
    
}
