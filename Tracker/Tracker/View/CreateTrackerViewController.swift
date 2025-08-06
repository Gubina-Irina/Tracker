//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 01.08.2025.
//

import UIKit

protocol CreateTrackerViewControllerDelegate: AnyObject {
    func didCreateTracker(_ tracker: Tracker, categoryTitle: String)
}

class CreateTrackerViewController: UIViewController {
    
    weak var delegate: CreateTrackerViewControllerDelegate?
    
    private lazy var habitButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackYP
        button.setTitle("Привычка", for: .normal)
        button.setTitleColor(.whiteYP, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(habitButtonTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var irrigularEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blackYP
        button.setTitle("Нерегулярное событие", for: .normal)
        button.setTitleColor(.whiteYP, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(irrigularEventButtonTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc func habitButtonTapped() {
        let habbitVC = NewHabitViewController()
        habbitVC.delegate = self
        let habbitNC = UINavigationController(rootViewController: habbitVC)
        habbitNC.modalPresentationStyle = .pageSheet
        present(habbitNC, animated: true)
        
    }
    
    @objc func irrigularEventButtonTapped() {
        let irrigularEventVC = IrrigularEventViewController()
        let irrigularEventNC = UINavigationController(rootViewController: irrigularEventVC)
        irrigularEventNC.modalPresentationStyle = .pageSheet
        present(irrigularEventNC, animated: true)
    }
    
    private func setupUI() {
        configureView()
        addSubviews()
        setupConstraints()
        
    }
    
    func addSubviews() {
        [habitButton, irrigularEventButton].forEach { view.addSubview($0) }
    }
    
    private func configureView() {
        view.backgroundColor = .whiteYP
        title = "Создание трекера"
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Habit Button
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            habitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 281),
            habitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Irrigular event Button
            irrigularEventButton.heightAnchor.constraint(equalToConstant: 60),
            irrigularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            irrigularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            irrigularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension CreateTrackerViewController: CreateTrackerViewControllerDelegate {
    func didCreateTracker(_ tracker: Tracker, categoryTitle: String) {
        delegate?.didCreateTracker(tracker, categoryTitle: categoryTitle)
        dismiss(animated: true)
    }
}
