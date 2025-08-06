//
//  Weekday.swift
//  Tracker
//
//  Created by Irina Gubina on 04.08.2025.
//

extension Weekday {
    static var fullName: [String] {
        return allCases.map { $0.fullName }
    }
}
