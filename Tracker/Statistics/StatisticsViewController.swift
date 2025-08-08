//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    private var statisticsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }
    
    private func setupUI() {
        configureView()
        setupStatisticLabel()
        setupConstraints()
        
    }
    
    private func configureView() {
        view.backgroundColor = .whiteYP
        
    }
    
    private func setupStatisticLabel() {
        statisticsLabel = UILabel()
        statisticsLabel.text = "Статистика"
        statisticsLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        statisticsLabel.textColor = .blackYP
        
        statisticsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statisticsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Trackers label
            statisticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
}
