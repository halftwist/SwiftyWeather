//
//  WeatherViewModel.swift
//  SwiftyWeather
//
//  Created by John Kearon on 5/13/25.
//

import Foundation

@Observable
class WeatherViewModel {
//    current: {
//    time: 2025-05-13T09:45,
//    interval: 900,
//    temperature_2m: 67,
//    relative_humidity_2m: 41,
//    apparent_temperature: 62.2,
//    precipitation: 0,
//    weather_code: 0,
//    wind_speed_10m: 9.9
//    },
    
    struct Returned: Codable {
        var current: Current
        var daily: Daily
    }
    
    struct Current: Codable {
//        let time: String
//        let interval: Int
        var temperature_2m: Double
//        let relative_humidity_2m: Double
        var apparent_temperature: Double
//        let precipitation: Double
        var weather_code: Int
        var wind_speed_10m: Double
    }
    
    struct Daily: Codable {
        var time: [String] = []
        var weather_code: [Int] = []
        var temperature_2m_max: [Double] = []
        var temperature_2m_min: [Double] = []
    }

    var temperature = 0.0
    var feelsLike = 0.0
    var windspeed = 0.0
    var weatherCode = 0
    
    var date: [String] = []
    var dailyWeather_code: [Int] = []
    var dailyHighTemp: [Double] = []
    var dailyLowTemp: [Double] = []

    
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=42.33467401570891&longitude=-71.17007347605109&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&hourly=uv_index&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=auto"
    
    func getData() async {
        print("🕸️  We are accessing URL:\(urlString)")
        guard let url = URL(string: urlString) else {
//            fatalError("Invalid URL")
            print("😡  ERROR: Could not create a url from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Try to decode JSON into our own data structures
            guard let Returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡  ERROR: Could not decode JSON from \(urlString)")
                return
            }
            print("😎 JSON RETURNED! \(Returned)")
            temperature = Returned.current.temperature_2m
            feelsLike = Returned.current.apparent_temperature
            windspeed = Returned.current.wind_speed_10m
            weatherCode = Returned.current.weather_code
            date = Returned.daily.time
            dailyWeather_code = Returned.daily.weather_code
            dailyHighTemp = Returned.daily.temperature_2m_max
            dailyLowTemp = Returned.daily.temperature_2m_min


        } catch {
            print("😡  ERROR: Could not get data from \(urlString)")
        }
        
    }
}
