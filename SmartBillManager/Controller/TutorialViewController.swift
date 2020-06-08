//
//  TutorialViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 08/06/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    let dataSource = ["Bill Management","Expense Management"]
    
    @IBOutlet weak var contentView: UIView!
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.title = "APP TUTORIAL"
        
        configurePageViewController()
    }
    
    func configurePageViewController(){
           
           guard let pageViewController = storyboard?.instantiateViewController(identifier: String(describing: TutorialPageViewController.self)) as? TutorialPageViewController else {
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

    
    func detailViewControllerAt(index: Int) -> PageDataViewController? {
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: PageDataViewController .self)) as? PageDataViewController else {
            return nil
            
        }
                                  
        dataViewController.index = index
        dataViewController.displayText = dataSource[index]
                        
                                  
        return dataViewController
        
    }

}

extension TutorialViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? PageDataViewController

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

        let dataViewController = viewController as? PageDataViewController
        guard var currentIndex = dataViewController?.index else {
                   return nil
        }
        if currentIndex == dataSource.count {
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex

        return detailViewControllerAt(index: currentIndex)
        
       
    }
    
    
}
