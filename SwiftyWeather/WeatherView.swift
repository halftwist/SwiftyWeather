//
//  WeatherView.swift
//  SwiftyWeather
//
//  Created by John Kearon on 5/13/25.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherVM = WeatherViewModel() // initializes the WeatherViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {  // layer views on top of each other
                Color(.cyan.opacity(0.75))  // background color
                    .ignoresSafeArea() // covers the toolbar
                
                VStack (spacing: 0) {
                    Image(systemName: getWeatherIcon(for: weatherVM.weatherCode))
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                        .symbolRenderingMode(.multicolor)
                    
                    Text(getWeatherDescription(for: weatherVM.weatherCode))
                        .font(.largeTitle)
                        .foregroundStyle(.white) // makes Images & Text white
                    
                    Text("\(Int(weatherVM.temperature))°F") // degree is Shift/Option/8
                        .font(.system(size: 150))
                        .fontWeight(.thin)
                        .foregroundStyle(.white) // makes Images & Text white
                    
                    Text("Wind \(Int(weatherVM.windspeed))mph - Feels Like \(Int(weatherVM.feelsLike))°F")
                        .font(.title2)
                        .padding(.bottom)
                        .foregroundStyle(.white) // makes Images & Text white
                    
                    List(0..<weatherVM.dailyWeatherCode.count, id: \.self) { index in
                        HStack (alignment: .top){
                            Image(systemName: getWeatherIcon(for: weatherVM.dailyWeatherCode[index]))
                            Text(getWeekDay(value: index+1))
                            
                            Spacer()
                            
                            Text("\(Int(weatherVM.dailyLowTemp[index]))°F")
                            Text("\(Int(weatherVM.dailyHighTemp[index]))°F")
                                .font(.title)
                                .bold()
                        }
                        .font(.title2)
                        .foregroundStyle(.white)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
//                .foregroundStyle(.white) // makes Images & Text white
                
                .toolbar {  // within the NavigationStack
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {  // Action/Label
                            //TODO: Add gear click here
                        } label: {
                            Image(systemName: "gear")
                        }
                        .tint(.white) // makes button white
                    }
                    
                }
            }
        }
        .task {
            await weatherVM.getData()
        }
    }
}

#Preview {
    WeatherView()
}

extension WeatherView {
    
    func getWeekDay(value: Int) -> String {
        // Increase date by "value" days
        let date = Calendar.current.date(byAdding: .day, value: value, to: Date.now)!
        // Find the day number 1 = Sunday... 7 = Saturday
        let dayNumber = Calendar.current.component(.weekday, from: date)
        // Convert dayNumber to the weekday & return that String
        let weekday = Calendar.current.weekdaySymbols[value - 1] // remember array is zero indexed, and we got dayNumber 1-7
        print("dayNumber: \(dayNumber) - weekday: \(weekday)")
        
        return weekday
    }
    
    // to select a range click on first item then SHIFT click on last item
    func getWeatherDescription(for code: Int) -> String {
        switch code {
        case 0:
            return "Clear sky"
        case 1:
            return "Mainly clear sky"
        case 2:
            return "Partly cloudy"
        case 3:
            return "Overcast"
        case 4:
            return "Rain showers"
        case 5:
            return "Snow showers"
        case 6:
            return "Hail"
        case 7:
            return "Snowfall"
        case 8:
            return "Freezing rain"
        case 9:
            return "Rain"
        case 10:
            return "Snow"
        case 11:
            return "Thunderstorm"
        case 12:
            return "Thunderstorm with rain"
        case 13:
            return "Thunderstorm with snow"
        case 14:
            return "Thunderstorm with hail"
        case 15:
            return "Blizzard"
        case 16:
            return "Clear night"
        case 17:
            return "Mainly clear night"
        case 18:
            return "Partly cloudy night"
        case 19:
            return "Overcast night"
        case 20:
            return "Light rain"
        case 21:
            return "Light snow"
        case 22:
            return "Light rain with thunder"
        case 23:
            return "Light snow with thunder"
        case 24:
            return "Rain showers during day"
        case 25:
            return "Rain showers during night"
        case 26:
            return "Snow showers during day"
        case 27:
            return "Snow showers during night"
        case 28:
            return "Light to moderate snow"
        case 29:
            return "Thunderstorm with heavy rain"
        case 30:
            return "Clear morning"
        case 31:
            return "Clear night"
        case 32:
            return "Partly cloudy morning"
        case 33:
            return "Partly cloudy night"
        case 34:
            return "Mainly clear morning"
        case 35:
            return "Mainly clear night"
        case 36:
            return "Rain with thunder"
        case 37:
            return "Light hail"
        case 38:
            return "Light snow"
        case 39:
            return "Light thunderstorms"
        case 40:
            return "Moderate thunderstorms"
        case 41:
            return "Heavy snow"
        case 42:
            return "Thunderstorms with snow"
        case 43:
            return "Heavy snowfall"
        case 44:
            return "Heavy hail"
        case 45:
            return "Severe thunderstorm"
        case 46:
            return "Very heavy snow"
        case 47:
            return "Severe hail"
        case 48:
            return "Rain showers"
        case 49:
            return "Light snow"
        case 50:
            return "Rain showers during day"
        case 51:
            return "Light rain during day"
        case 52:
            return "Light snow during day"
        case 53:
            return "Light rain with thunder during day"
        case 54:
            return "Light snow with thunder during day"
        case 55:
            return "Thunderstorm with rain during day"
        case 56:
            return "Thunderstorm with snow during day"
        case 57:
            return "Moderate snow"
        case 58:
            return "Moderate snow with thunder"
        case 59:
            return "Moderate rain"
        case 60:
            return "Severe thunderstorms"
        case 61:
            return "Moderate snow"
        case 62:
            return "Rain showers during night"
        case 63:
            return "Moderate snow"
        case 64:
            return "Moderate thunderstorm with rain"
        case 65:
            return "Moderate snow with thunder"
        case 66:
            return "Moderate snowfall"
        case 67:
            return "Light rain"
        case 68:
            return "Heavy thunderstorm with rain"
        case 69:
            return "Heavy snow"
        case 70:
            return "Heavy snow"
        case 71:
            return "Heavy rain"
        case 72:
            return "Heavy snow"
        case 73:
            return "Rain showers during night"
        case 74:
            return "Heavy snow"
        case 75:
            return "Moderate hail"
        case 76:
            return "Light snow"
        case 77:
            return "Moderate thunderstorm"
        case 78:
            return "Heavy hail"
        case 79:
            return "Severe thunderstorms"
        case 80:
            return "Rain showers"
        case 81:
            return "Light snow"
        case 82:
            return "Thunderstorms"
        case 83:
            return "Snow with thunder"
        case 84:
            return "Snow with thunder"
        case 85:
            return "Blizzard"
        case 86:
            return "Rain showers"
        case 87:
            return "Light snow"
        case 88:
            return "Light rain"
        case 89:
            return "Light snow"
        case 90:
            return "Heavy snow"
        case 91:
            return "Rain showers"
        case 92:
            return "Snowfall"
        case 93:
            return "Snow with thunder"
        case 94:
            return "Light rain"
        case 95:
            return "Light snow"
        case 96:
            return "Heavy snow"
        case 97:
            return "Heavy snow"
        case 98:
            return "Light snow"
        case 99:
            return "Light snow"
        default:
            return "Unknown weather condition"
        }
    }
    
    func getWeatherIcon(for code: Int) -> String {
        switch code {
        case 0:
            return "cloud.sun.fill" // Clear sky
        case 1:
            return "cloud.sun.fill" // Mostly clear sky
        case 2:
            return "cloud.fill" // Partly cloudy
        case 3:
            return "cloud.fill" // Cloudy
        case 4:
            return "cloud.rain.fill" // Showers of rain
        case 5:
            return "cloud.snow.fill" // Snow showers
        case 6:
            return "cloud.hail.fill" // Hail
        case 7:
            return "cloud.snow.fill" // Snowfall
        case 8:
            return "cloud.rain.fill" // Freezing rain
        case 9:
            return "cloud.rain.fill" // Rain
        case 10:
            return "cloud.snow.fill" // Snow
        case 11:
            return "cloud.bolt.rain.fill" // Thunderstorm
        case 12:
            return "cloud.bolt.rain.fill" // Thunderstorms with rain
        case 13:
            return "cloud.bolt.snow.fill" // Snow with thunder
        case 14:
            return "cloud.hail.fill" // Hail with thunder
        case 15:
            return "cloud.snow.fill" // Blizzard
        case 16:
            return "cloud.sun.fill" // Clear night
        case 17:
            return "cloud.moon.fill" // Mostly clear night
        case 18:
            return "cloud.fill" // Partly cloudy night
        case 19:
            return "cloud.fill" // Cloudy night
        case 20:
            return "cloud.rain.fill" // Light rain
        case 21:
            return "cloud.snow.fill" // Light snow
        case 22:
            return "cloud.bolt.rain.fill" // Light rain with thunder
        case 23:
            return "cloud.bolt.snow.fill" // Light snow with thunder
        case 24:
            return "cloud.sun.rain.fill" // Showers of rain (day)
        case 25:
            return "cloud.moon.rain.fill" // Showers of rain (night)
        case 26:
            return "cloud.sun.snow.fill" // Snow showers (day)
        case 27:
            return "cloud.moon.snow.fill" // Snow showers (night)
        case 28:
            return "cloud.snow.fill" // Snow (light or moderate)
        case 29:
            return "cloud.bolt.rain.fill" // Thunderstorms with heavy rain
        case 30:
            return "cloud.sun.fill" // Clear skies (morning)
        case 31:
            return "cloud.moon.fill" // Clear skies (night)
        case 32:
            return "cloud.fill" // Partly cloudy (morning)
        case 33:
            return "cloud.fill" // Partly cloudy (night)
        case 34:
            return "cloud.sun.fill" // Mostly clear sky (morning)
        case 35:
            return "cloud.moon.fill" // Mostly clear sky (night)
        case 36:
            return "cloud.rain.fill" // Rain with thunder
        case 37:
            return "cloud.hail.fill" // Hail (light)
        case 38:
            return "cloud.snow.fill" // Snow (light)
        case 39:
            return "cloud.bolt.rain.fill" // Thunderstorms (light)
        case 40:
            return "cloud.bolt.rain.fill" // Thunderstorms (moderate)
        case 41:
            return "cloud.snow.fill" // Snow (heavy)
        case 42:
            return "cloud.bolt.rain.fill" // Thunderstorms with snow
        case 43:
            return "cloud.bolt.snow.fill" // Heavy snow
        case 44:
            return "cloud.hail.fill" // Hail (heavy)
        case 45:
            return "cloud.bolt.rain.fill" // Thunderstorm (heavy)
        case 46:
            return "cloud.snow.fill" // Snow (very heavy)
        case 47:
            return "cloud.hail.fill" // Hail (severe)
        case 48:
            return "cloud.rain.fill" // Showers of rain
        case 49:
            return "cloud.snow.fill" // Snow (light)
        case 50:
            return "cloud.rain.fill" // Showers of rain (day)
        case 51:
            return "cloud.rain.fill" // Light rain (day)
        case 52:
            return "cloud.snow.fill" // Light snow (day)
        case 53:
            return "cloud.bolt.rain.fill" // Light rain with thunder (day)
        case 54:
            return "cloud.bolt.snow.fill" // Light snow with thunder (day)
        case 55:
            return "cloud.bolt.rain.fill" // Thunderstorms with rain (day)
        case 56:
            return "cloud.bolt.snow.fill" // Thunderstorms with snow (day)
        case 57:
            return "cloud.snow.fill" // Snow (moderate)
        case 58:
            return "cloud.snow.fill" // Snow with thunder (moderate)
        case 59:
            return "cloud.rain.fill" // Rain (moderate)
        case 60:
            return "cloud.bolt.rain.fill" // Heavy thunderstorms
        case 61:
            return "cloud.snow.fill" // Snow (moderate)
        case 62:
            return "cloud.rain.fill" // Showers of rain (night)
        case 63:
            return "cloud.snow.fill" // Snow (moderate)
        case 64:
            return "cloud.bolt.rain.fill" // Thunderstorm with rain (moderate)
        case 65:
            return "cloud.snow.fill" // Snow with thunder (moderate)
        case 66:
            return "cloud.snow.fill" // Snowfall (moderate)
        case 67:
            return "cloud.rain.fill" // Rain (light)
        case 68:
            return "cloud.bolt.rain.fill" // Thunderstorm with rain (heavy)
        case 69:
            return "cloud.snow.fill" // Heavy snow (moderate)
        case 70:
            return "cloud.snow.fill" // Snow (heavy)
        case 71:
            return "cloud.rain.fill" // Rain (heavy)
        case 72:
            return "cloud.snow.fill" // Snow (heavy)
        case 73:
            return "cloud.rain.fill" // Showers of rain (night)
        case 74:
            return "cloud.snow.fill" // Snow (heavy)
        case 75:
            return "cloud.hail.fill" // Hail (moderate)
        case 76:
            return "cloud.snow.fill" // Snow (light)
        case 77:
            return "cloud.bolt.rain.fill" // Thunderstorm (moderate)
        case 78:
            return "cloud.hail.fill" // Hail (heavy)
        case 79:
            return "cloud.bolt.rain.fill" // Heavy thunderstorms
        case 80:
            return "cloud.rain.fill" // Showers of rain
        case 81:
            return "cloud.rain.fill" // Light snow
        case 82:
            return "cloud.bolt.rain.fill" // Thunderstorms
        case 83:
            return "cloud.snow.fill" // Snow with thunder
        case 84:
            return "cloud.snow.fill" // Snow with thunder
        case 85:
            return "cloud.snow.fill" // Blizzard
        case 86:
            return "cloud.rain.fill" // Showers of rain
        case 87:
            return "cloud.snow.fill" // Snow (light)
        case 88:
            return "cloud.rain.fill" // Rain (light)
        case 89:
            return "cloud.snow.fill" // Snow (light)
        case 90:
            return "cloud.snow.fill" // Snow (heavy)
        case 91:
            return "cloud.rain.fill" // Showers of rain
        case 92:
            return "cloud.snow.fill" // Snowfall
        case 93:
            return "cloud.snow.fill" // Snow with thunder
        case 94:
            return "cloud.rain.fill" // Rain (light)
        case 95:
            return "cloud.snow.fill" // Snow (light)
        case 96:
            return "cloud.snow.fill" // Snow (heavy)
        case 97:
            return "cloud.snow.fill" // Heavy snow
        case 98:
            return "cloud.snow.fill" // Light snow
        case 99:
            return "cloud.snow.fill" // Snow (light)
        default:
            return "questionmark.circle.fill" // Unknown code
        }
    }
}
