//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    private lazy var statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = "Статистика"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .blackYP
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }
    
    private func setupUI() {
        configureView()
        view.addSubview(statisticsLabel)
        setupConstraints()
        
    }
    
    private func configureView() {
        view.backgroundColor = .whiteYP
        
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Trackers label
            statisticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
}
