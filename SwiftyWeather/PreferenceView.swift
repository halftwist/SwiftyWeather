//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by John Kearon on 5/13/25.
//

import SwiftUI

struct PreferenceView: View {
    @State private var locationName = ""
    @State private var latString = ""
    @State private var longString = ""
    @State private var selectedUnit = UnitSystem.imperial
    @State private var degreeUnitShowing = true
    var degreeUnit: String {
//        degreeUnitShowing ? "°F" : "°C"
        if degreeUnitShowing {
            return selectedUnit == .imperial ? "°F" : "°C"
        }
        return ""
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                TextField("Location:", text: $locationName)
                    .textFieldStyle(.roundedBorder)
                    .font(.title)
                    .padding(.bottom)
                
                Group {
                    Text("Lattitude:")
                        .bold()
                    TextField("Latitude:", text: $latString)
                    
                    Text("Longitude:")
                        .bold()
                    TextField("Longitude:", text: $longString)
                        .padding(.bottom)
                    
                }
                .font(.title2)
                
                HStack {
                   Text("Units:")
                        .bold()
                    Spacer()
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    .padding(.bottom)
                }
                .font(.title2)
                
                Toggle("Show F/C after temp vallue:", isOn: $degreeUnitShowing)
                    .font(.title2)
                    .bold()
                
                HStack {
                    Spacer()
                    Text("42\(degreeUnit)")
                        .font(.system(size: 150))
                        .fontWeight(.thin)
                    Spacer()
                }
                
                Spacer()

            }
            
        }
    }
}

#Preview {
    PreferenceView()
}
