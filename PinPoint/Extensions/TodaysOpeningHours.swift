//
//  TodaysOpeningHours.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-19.
//

import GooglePlaces

extension GMSOpeningHours {
    /// Returns today's line from `weekdayText`, or nil if unavailable.
    func todayText() -> String? {
        guard let weekdayText = self.weekdayText else { return nil }
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        //let todayIndex = calendar.component(.weekday, from: Date()) - 1
        
        let googleIndex = (weekday + 5) % 7
        
        guard weekdayText.indices.contains(googleIndex) else { return nil }
        
        let todayLine = weekdayText[googleIndex]
        
        let parts = todayLine.split(separator: ":", maxSplits: 1).map { String($0) }
        
        guard parts.count == 2 else { return todayLine }
        
        let hours = parts[1].trimmingCharacters(in: .whitespaces)
        
        return "Today: \(hours)"
    }
}
