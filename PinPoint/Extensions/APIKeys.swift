//
//  APIKeys.swift
//  PinPoint
//
//  Created by Linnea on 2025-10-29.
//

import Foundation

extension Bundle {
    var googleAPIKey: String {
        guard let url = self.url(forResource: "ignore", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil
              ) as? [String: Any],
              let key = plist["GOOGLE_PLACES_API_KEY"] as? String else {
            fatalError("Missing GOOGLE_PLACES_API_KEY in ignore.plist")
        }
        return key
    }
}
