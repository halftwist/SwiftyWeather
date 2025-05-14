//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by John Kearon on 5/13/25.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
    @Query var preferences: [Preference]
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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
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
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
    // We only want to save one element to the array, so delete all others before we save
                        if !preferences.isEmpty {
                            for preference in preferences {
                                modelContext.delete(preference)
                            }
                        }
                        let preference = Preference(
                            locationName: locationName,
                            latString: latString,
                            longString: longString,
                            selectedUnit: selectedUnit,
                            degreeUnitShowing: degreeUnitShowing
                        )
                        modelContext.insert(preference)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save on PrefernceView failed.")
                            return
                        }
                        
                        dismiss()
                    }
                }
            }
        }
        // .task outside the NavigationStack
        .task {  // grabs the data as soon as the view appears (similiar to onAppear(with a task modifier inside it)
            guard !preferences.isEmpty else { return }
            let preference = preferences.first!  // forced unwrap
            locationName = preference.locationName
            latString = preference.latString
            longString = preference.longString
            selectedUnit = preference.selectedUnit
            degreeUnitShowing = preference.degreeUnitShowing
        }

    }
}

#Preview {
    PreferenceView()
        .modelContainer(Preference.preview)
}
