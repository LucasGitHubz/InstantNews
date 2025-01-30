//
//  BundleExtension.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

extension Bundle {
    func apiKey(for key: String) -> String? {
        return object(forInfoDictionaryKey: key) as? String
    }
}
