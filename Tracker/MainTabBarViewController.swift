//
//  ViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarAppearance()
        setupViewControllers()
        
    }
    
    private func setupTabBarAppearance() {
        tabBar.tintColor = .blueYP
        tabBar.unselectedItemTintColor = .grayYP
        tabBar.backgroundColor = .whiteYP
        
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
            image: UIImage(resource: .trackersIcon),
            tag: 0
        )
        
        statisticsVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(resource: .statisticIcon),
            tag: 1
        )
        
        let trackersNC = UINavigationController(rootViewController: trackersVC)
        let statisticsNC = UINavigationController(rootViewController: statisticsVC)
        
        viewControllers = [trackersNC, statisticsNC]
    }
}

