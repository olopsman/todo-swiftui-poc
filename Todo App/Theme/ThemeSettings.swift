//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Paulo Orquillo on 2/05/21.
//

import SwiftUI

// MARK: Theme Settings

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
