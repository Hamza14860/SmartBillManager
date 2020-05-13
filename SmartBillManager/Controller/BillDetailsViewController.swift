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
    
    let dataSource = ["Bill Text","Bill Image", "Export Bill"]
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        // Do any additional setup after loading the view.
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
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index: Int) -> DataViewController? {
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        
        dataViewController.index = index
       // dataViewController.displayText = dataSource[index]
        dataViewController.displayText = selectedBill?.billCustomerName

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
       // dataViewController.displayText = dataSource[index]
        billImageViewController.displayText = selectedBill?.billCustomerName

        return billImageViewController
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

extension BillDetailsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
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
        
        
        
        let dataViewController = viewController as? BillImageViewController
        guard var currentIndex = dataViewController?.index else {
            print("Here")
            return nil
        }
        if currentIndex == dataSource.count {
            print("Here2")
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
               
        return detailImageViewControllerAt(index: currentIndex)
    }
    
    
}
