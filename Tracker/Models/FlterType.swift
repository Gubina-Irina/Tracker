//
//  FlterType.swift
//  Tracker
//
//  Created by Irina Gubina on 11.09.2025.
//

import Foundation

enum FilterType: Int, CaseIterable {
    case allTrackers
    case trackersToday
    case completed
    case incomplete
    
    var title: String {
        switch self {
        case .allTrackers: LocalizedStrings.allTrackers
        case .trackersToday: LocalizedStrings.trackersToday
        case .completed: LocalizedStrings.completed
        case .incomplete: LocalizedStrings.incomplete
        }
    }
}
