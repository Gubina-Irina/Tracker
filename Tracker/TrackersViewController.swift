//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

class TrackersViewController: UIViewController {
    
    //MARK: - UI Elements
    private var trackerAddingButton: UIButton!
    private var trackersLabel: UILabel!
    private var placeholderImageView: UIImageView!
    private var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        showPlaceholder()
    }
    
    private func setupUI() {
        configureView()
        setupTrackerAddingButton()
        setupTrackersLabel()
        setupplaceholderImage()
        setupplaceholderLabel()
        
        setupConstraints()
        
    }
    
    private func configureView() {
        view.backgroundColor = .whiteYP
        
    }

    
    private func setupTrackerAddingButton() {
        guard let trackerAddingImage = UIImage(named: "trackerAddingImage") else {
            assertionFailure("Failed to load tracker adding image")
            return
        }
        trackerAddingButton = UIButton.systemButton(
            with: trackerAddingImage,
            target: self,
            action: #selector(Self.addTrackersButton))
        trackerAddingButton.tintColor = .black
        
        trackerAddingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackerAddingButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: trackerAddingButton)
    }
    
    private func setupTrackersLabel() {
        trackersLabel = UILabel()
        trackersLabel.text = "Трекеры"
        trackersLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        trackersLabel.textColor = .blackYP
        
        trackersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackersLabel)
    }
    
    private func setupplaceholderLabel() {
        placeholderLabel = UILabel()
        placeholderLabel.text = "Что будем отслеживать?"
        placeholderLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        placeholderLabel.textColor = .blackYP
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeholderLabel)
    }
    
    private func setupplaceholderImage() {
        placeholderImageView = UIImageView()
        placeholderImageView.image = UIImage(named: "trackerPlaceholderImage")
        
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeholderImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Trackers label
            trackersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            
            // Placeholder image
            placeholderImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            placeholderImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            //Placeholder Label
            placeholderLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            placeholderLabel.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor, constant: 8)
        ])
    }
    private func showPlaceholder() {
        //TODO: if the tracker is empty, then show placeholder
        placeholderImageView.isHidden = false
        placeholderLabel.isHidden = false
    }
    @objc private func addTrackersButton(_ sender: UIButton) {}
}
