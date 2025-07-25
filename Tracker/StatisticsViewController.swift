//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    private var staticticLabel: UILabel!
    
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
        staticticLabel = UILabel()
        staticticLabel.text = "Статистика"
        staticticLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        staticticLabel.textColor = .blackYP
        
        staticticLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(staticticLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Trackers label
            staticticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            staticticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44)
        ])
    }
}
