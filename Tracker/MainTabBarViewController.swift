//
//  ViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarAppearance()
        setupViewControllers()
        
    }
    
    private func setupTabBarAppearance() {
        tabBar.tintColor = .blueYP //#3772E7
        tabBar.unselectedItemTintColor = .grayYP //#AEAFB4
        tabBar.backgroundColor = .whiteYP //#FFFFFF
        
        if #available(iOS 15.0, *) {
                    let appearance = UITabBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    tabBar.standardAppearance = appearance
                    tabBar.scrollEdgeAppearance = appearance
                }
    }
    
    private func setupViewControllers() {
        let trackersVC = TrackersViewController()
        let statisticsVC = StatisticsViewController()
        
        trackersVC.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trekersIcon"),
            tag: 0
        )
        
        statisticsVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "statisticIcon"),
            tag: 1
        )

        
        
        let trackersNC = UINavigationController(rootViewController: trackersVC)
        let statisticsNC = UINavigationController(rootViewController: statisticsVC)
        
        self.viewControllers = [trackersNC, statisticsNC]
    }


}

