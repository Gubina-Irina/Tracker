//
//  OnboardingViewController.swift
//  Tracker
//
//  Created by Irina Gubina on 24.08.2025.
//

import UIKit

final class OnboardingViewController: UIPageViewController {
    
    private lazy var pages: [UIViewController] = [
        createOnboardingPage(
            description: "Отслеживайте только то, что хотите",
            imagePage: "firstPageOnboarding",
            isLastPage: false),
        createOnboardingPage(
            description: "Даже если это не литры воды и йога",
            imagePage: "secondPageOnboarding",
            isLastPage: true)]
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        pageControl.currentPageIndicatorTintColor = .blackYP
        pageControl.pageIndicatorTintColor = .grayYP
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private var skipButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Вот это технологии!", for: .normal)
        button.setTitleColor(.whiteYP, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .blackYP
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
           super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteYP
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(pageControl)
        view.addSubview(skipButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Skip Button
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.heightAnchor.constraint(equalToConstant: 60),
            
            //Page Control
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -24),
        ])
    }
    
    @objc func skipButtonTapped(){
        finishOnboarding()
    }
    
    private func createOnboardingPage(description: String, imagePage: String, isLastPage: Bool) -> UIViewController {
        
        let viewController = UIViewController()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imagePage)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(imageView)
        viewController.view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -270),
            descriptionLabel.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16)
        ])
        
        return viewController
    }
    
    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        
        let tabBarController = MainTabBarViewController()
        
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = tabBarController
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return pages.last
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else {
            return pages.first
        }
        
        return pages[nextIndex]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)  {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}
