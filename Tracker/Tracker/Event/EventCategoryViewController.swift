//
//  Untitled.swift
//  Tracker
//
//  Created by Irina Gubina on 05.08.2025.
//

import UIKit

protocol EventCategoryDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class EventCategoryViewController: UIViewController {
    //private var selectedCategory: String?
    weak var delegate: EventCategoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
