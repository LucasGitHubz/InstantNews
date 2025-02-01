//
//  StringExtension.swift
//  InstantNews
//
//  Created by Lucas on 31/01/2025.
//

import Foundation

extension String {
    func formattedAsNewsDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = isoFormatter.date(from: self) else {
            return "Invalid Date"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = Locale(identifier: "fr_FR")
        
        return formatter.string(from: date)
    }
}
