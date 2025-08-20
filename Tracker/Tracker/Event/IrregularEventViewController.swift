//
//  i.swift
//  Tracker
//
//  Created by Irina Gubina on 03.08.2025.
//

import UIKit

class IrregularEventViewController: UIViewController {
    
    weak var delegate: CreateTrackerViewControllerDelegate?
    private var selectedCategory: String?
    
    private var selectedEmoji: String?
    private var selectedColor: UIColor?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var nameTrackerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название трекера"
        textField.textColor = .blackYP
        textField.tintColor = .grayYP
        textField.backgroundColor = .lightGrayYP
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.layer.cornerRadius = 16
        textField.leftView = UIView(frame: CGRect (x:16, y: 0, width: 17, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.delegate = self
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightGrayYP
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.title = "Категория"
            configuration.baseForegroundColor = .blackYP
            configuration.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 16, bottom: 0, trailing: 30)
            let forwardArrowImage = UIImage(resource: .forwardArrow)
            configuration.image = forwardArrowImage
            configuration.imageColorTransformer = UIConfigurationColorTransformer { _ in
                return .grayYP
            }
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 8
            
            button.configuration = configuration
        } else {
            button.setTitle("Категория", for: .normal)
            button.setTitleColor(.blackYP, for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 30)
            
            let forwardArrowImage = UIImageView(image: UIImage(resource: .forwardArrow))
            forwardArrowImage.tintColor = .grayYP
            forwardArrowImage.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(forwardArrowImage)
            
            NSLayoutConstraint.activate([
                forwardArrowImage.heightAnchor.constraint(equalToConstant: 24),
                forwardArrowImage.widthAnchor.constraint(equalToConstant: 24),
                forwardArrowImage.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                forwardArrowImage.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16)
            ])
        }
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
            button.contentHorizontalAlignment = .leading
            button.contentVerticalAlignment = .center
            button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.redYP.cgColor
        button.backgroundColor = .clear
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.redYP, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.backgroundColor = .grayYP
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.whiteYP, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var emojiCollectionView: EmojiCollectionView = {
        let collectionView = EmojiCollectionView()
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var colorCollectionView: ColorCollectionView = {
        let collectionView = ColorCollectionView()
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var emojiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Emoji"
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var colorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTapGesture()
        
        //TODO: тут пока принудительно стоит категория. как в тз нужно будет реализовать, убрать
       selectedCategory = "Спорт"
    }
    
    private func updateCreateButtonState() {
        let isNameTextField = !(nameTrackerTextField.text?.isEmpty ?? true)
        let isSelectedCategory = selectedCategory != nil
        let isSelectedEmoji = selectedEmoji != nil
        let isSelectedColor = selectedColor != nil
        
        let isResultEmpty = isNameTextField && isSelectedCategory && isSelectedEmoji && isSelectedColor
        createButton.isEnabled = isResultEmpty
        createButton.backgroundColor = isResultEmpty ? .blackYP : .grayYP
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Позволяет одновременно обрабатывать другие тапы
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureView() {
        view.backgroundColor = .whiteYP
        title = "Новое нерегулярное событие"
        
    }
    
    private func setupUI() {
        configureView()
        addSubviews()
        setupConstraints()
        //selectedCategory = "Срочное"
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [nameTrackerTextField, categoryButton, cancelButton, createButton, emojiTitleLabel, emojiCollectionView, colorTitleLabel, colorCollectionView, ].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Name Tracker Text Field
            nameTrackerTextField.heightAnchor.constraint(equalToConstant: 75),
            nameTrackerTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameTrackerTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTrackerTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            //Category and Schedule TableView
            categoryButton.heightAnchor.constraint(equalToConstant: 75),
            categoryButton.topAnchor.constraint(equalTo: nameTrackerTextField.bottomAnchor, constant: 24),
            categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            //Emoji Title Label
            emojiTitleLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 32),
            emojiTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            
            // Emoji Collection View
            emojiCollectionView.topAnchor.constraint(equalTo: emojiTitleLabel.bottomAnchor, constant: 24),
            emojiCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiCollectionView.heightAnchor.constraint(equalToConstant: 204),
            
            //Color Title Label
            colorTitleLabel.topAnchor.constraint(equalTo: emojiCollectionView.bottomAnchor, constant: 16),
            colorTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            
            // Color Collection View
            colorCollectionView.topAnchor.constraint(equalTo: colorTitleLabel.bottomAnchor, constant: 24),
            colorCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorCollectionView.heightAnchor.constraint(equalToConstant: 204),
            colorCollectionView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -24),
            
            // Cancel Button
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalToConstant: 166),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            //Create Button
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            createButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            
//            // Cancel Button
//            cancelButton.heightAnchor.constraint(equalToConstant: 60),
//            cancelButton.widthAnchor.constraint(equalToConstant: 166),
//            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            
//            //Create Button
//            createButton.heightAnchor.constraint(equalToConstant: 60),
//            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            createButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8),
//            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func categoryButtonTapped() {
        let eventCategoryVC = EventCategoryViewController()
        eventCategoryVC.delegate = self
        let eventCategoryNC = UINavigationController(rootViewController: eventCategoryVC)
        eventCategoryNC.modalPresentationStyle = .pageSheet
        present(eventCategoryNC, animated: true)
    }
    
    @objc private func cancelButtonTapped () {
        dismiss(animated: true)
    }
    
    @objc private func createButtonTapped () {
        guard let name = nameTrackerTextField.text, !name.isEmpty,
        let category = selectedCategory,
        let emoji = selectedEmoji,
        let color = selectedColor else { return }
        
        let newTracker = Tracker(id: UUID(),
                                 name: name,
                                 color: color,
                                 emoji: emoji,
                                 schedule: [])
        delegate?.didCreateTracker(newTracker, categoryTitle: category)
        
        presentingViewController?.presentingViewController?.dismiss(animated: true)
        //dismiss(animated: true)
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func textFieldChanged() {
        updateCreateButtonState()
    }
    
}


extension IrregularEventViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension IrregularEventViewController: EventCategoryDelegate {
    func didSelectCategory(_ category: String) {
        selectedCategory = category
        updateCreateButtonState()
    }
}

extension IrregularEventViewController: EmojiSelectionDelegate {
    func didSelectEmoji(_ emoji: String) {
        selectedEmoji = emoji
        updateCreateButtonState()
    }
}

extension IrregularEventViewController: ColorSelectionDelegate {
    func didSelectColor(_ color: UIColor) {
        selectedColor = color
        updateCreateButtonState()
    }
}
