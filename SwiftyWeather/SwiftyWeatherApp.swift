//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by John Kearon on 5/13/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .modelContainer(for: Preference.self)
        }
    }
    
    init () {  // for debugging the SwiftData model
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
