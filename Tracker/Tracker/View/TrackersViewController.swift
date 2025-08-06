//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.07.2025.
//

import UIKit

protocol TrackerCreationDelegate: AnyObject {
    func didCreateTracker(_ tracker: Tracker, categoryTitle: String)
}

class TrackersViewController: UIViewController {
    
    //MARK: - Private properties
    private var currentDate = Date()
    private var visibleCategories: [TrackerCategory] = []
    private var categories: [TrackerCategory] = [] {
        didSet {
            showPlaceholder()
            collectionView.reloadData()
        }
    }
    
    private var completedTrackers: [TrackerRecord] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - UI Elements
    private var trackerAddingButton: UIButton!
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "ru_RU")
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    private lazy var trackersLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .blackYP
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var searchField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    private lazy var placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trackerPlaceholderImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .blackYP
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var placeholderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeholderImageView, placeholderLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 167, height: 90)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: TrackerCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    //private var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.title = nil
        
        datePicker.date = Date()
        addSubviews()
        setupUI()
    }
    
    func addTrackerCategory(_ tracker: Tracker, to categoryTitle: String) {
        var updatedCategories = categories
        
        if let index = updatedCategories.firstIndex(where: {$0.title == categoryTitle }) {
            let updatedTrackers = updatedCategories[index].trackers + [tracker]
            updatedCategories[index] = TrackerCategory(title: categoryTitle, trackers: updatedTrackers)
        } else {
            let newCategory = TrackerCategory(title: categoryTitle, trackers: [tracker])
            updatedCategories.append(newCategory)
        }
        categories = updatedCategories
    }
    
    func toggleCompletion(for trackerID: UUID, date: Date, isCompleted: Bool) {
        let dateStart = Calendar.current.startOfDay(for: date)
        let today = Calendar.current.startOfDay(for: Date())
        
        guard dateStart <= today else { return }
        
        guard let tracker = (visibleCategories.flatMap { $0.trackers }).first(where: { $0.id == trackerID }) else { return }
        
        let dayOfWeek = Calendar.current.component(.weekday, from: date)
            let currentWeekday = Weekday(rawValue: dayOfWeek) ?? .monday
            
            // Для нерегулярных событий
            guard tracker.schedule.isEmpty || tracker.schedule.contains(currentWeekday) else {
                return
            }
        
        if isCompleted {
            let record = TrackerRecord(trackerId: trackerID, date: dateStart)
            if !completedTrackers.contains(where: {
                $0.trackerId == trackerID && Calendar.current.isDate($0.date, inSameDayAs: dateStart)
            }) {
                completedTrackers.append(record)
            }
        } else {
            completedTrackers.removeAll {
                $0.trackerId == trackerID && Calendar.current.isDate($0.date, inSameDayAs: dateStart)
            }
        }
        
        collectionView.reloadData()
    }
    
    private func setupUI() {
        configureView()
        setupBarButtonItem()
        addSubviews()
        //setupDate()
        
        setupConstraints()
        
    }
    
    func addSubviews() {
        [trackersLabel, searchField, placeholderStack, collectionView].forEach { view.addSubview($0) }
    }
    
    private func configureView() {
        view.backgroundColor = .whiteYP
        
    }
    
    private func setupBarButtonItem() {
        guard let trackerAddingImage = UIImage(named: "trackerAddingImage") else {
            assertionFailure("Failed to load tracker adding image")
            return
        }
        trackerAddingButton = UIButton.systemButton(
            with: trackerAddingImage,
            target: self,
            action: #selector(Self.addTrackersButton))
        trackerAddingButton.tintColor = .blackYP
        
        trackerAddingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackerAddingButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: trackerAddingButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
    }
    
    // TODO: Подумать над реализацией даты, как в фигме. Сделать текст филд (например) и сделать пикер прозрачным.
    //    private func setupDate() {
    //        datePicker = UIDatePicker()
    //        datePicker.datePickerMode = .date
    //        datePicker.preferredDatePickerStyle = .compact
    //        datePicker.locale = Locale(identifier: "ru_RU")
    //        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    //        
    //        datePicker.translatesAutoresizingMaskIntoConstraints = false
    //
    //        dateTextField = UITextField()
    //        //dateTextField.inputView = datePicker
    //        dateTextField.text = formatDate(datePicker.date)
    //        dateTextField.textColor = .blackYP
    //        dateTextField.tintColor = .grayYP
    //        dateTextField.font = UIFont.systemFont(ofSize: 17)
    //        //view.addSubview(datePicker)
    //        
    //        dateTextField.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(dateTextField)
    //        
    //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dateTextField)
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Trackers label
            trackersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            // Search Field
            searchField.heightAnchor.constraint(equalToConstant: 36),
            searchField.leadingAnchor.constraint(equalTo: trackersLabel.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchField.topAnchor.constraint(equalTo: trackersLabel.bottomAnchor, constant: 7),
            
            //Placeholder Image
            placeholderImageView.heightAnchor.constraint(equalToConstant: 80),
            placeholderImageView.widthAnchor.constraint(equalToConstant: 80),
            
            // Placeholder stack
            placeholderStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            placeholderStack.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 220),
            
            //Collection view
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func showPlaceholder() {
        //TODO: if the tracker is empty, then show placeholder
        let isEmpty = categories.flatMap{$0.trackers}.isEmpty
        placeholderStack.isHidden = !isEmpty
    }
    
    private func filterTrackers(for date: Date) -> [TrackerCategory] {
        let dayOfWeek = Calendar.current.component(.weekday, from: date)
        let currentWeekday = Weekday(rawValue: dayOfWeek) ?? .monday
        
        return categories.compactMap { category in
            let filteredTrackers = category.trackers.filter { tracker in
                if tracker.schedule.isEmpty {
                    return true
                }
                return tracker.schedule.contains(currentWeekday)
            }
            
            return filteredTrackers.isEmpty ? nil :
                TrackerCategory(title: category.title, trackers: filteredTrackers)
        }
    }
    
    @objc private func addTrackersButton(_ sender: UIButton) {
        let createTrackerVC = CreateTrackerViewController()
        createTrackerVC.delegate = self
        
        let createTrackerNC = UINavigationController(rootViewController: createTrackerVC)
        createTrackerNC.modalPresentationStyle = .pageSheet
        present(createTrackerNC, animated: true)
        
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        currentDate = sender.date
            visibleCategories = filterTrackers(for: currentDate)
            collectionView.reloadData()
            showPlaceholder()
        // dateTextField.text = formatDate(sender.date)
    }
    // TODO: Подумать над реализацией даты, как в фигме. Сделать текст филд (например) и сделать пикер прозрачным.
    //    private func formatDate(_ date: Date) -> String {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "dd.MM.yyyy"
    //        return formatter.string(from: date)
    //    }
}


extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return visibleCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard visibleCategories.indices.contains(section) else { return 0 }
        return visibleCategories[section].trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCollectionViewCell.identifier, for: indexPath) as? TrackerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let tracker = visibleCategories[indexPath.section].trackers[indexPath.item]
        let selectedDate = datePicker.date
        
        let isCompletedToday = completedTrackers.contains { record in
            record.trackerId == tracker.id &&
            Calendar.current.isDate(record.date, inSameDayAs: selectedDate)
        }
        
        let completedDays = completedTrackers.filter { $0.trackerId == tracker.id }.count
        
        cell.configure( with: tracker, completedDays: completedDays, isCompletedToday: isCompletedToday, currentDate: selectedDate)
        
        cell.onCompletion = { [weak self] trackerId, date, isCompleted in
            self?.toggleCompletion(for: trackerId, date: date, isCompleted: isCompleted)
        }
        
        return cell
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.bounds.width - (padding * 3)
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 148) // 90 (карточка) + 16 + 34 (кнопка) + 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

//extension Date {
//    func startOfDay() -> Date {
//        return Calendar.current.startOfDay(for: self)
//    }
//}


extension TrackersViewController: CreateTrackerViewControllerDelegate {
    func didCreateTracker(_ tracker: Tracker, categoryTitle: String) {
        addTrackerCategory(tracker, to: categoryTitle)
        collectionView.reloadData()
        dismiss(animated: true)
    }
}
