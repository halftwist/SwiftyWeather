//
//  Preference.swift
//  SwiftyWeather
//
//  Created by John Kearon on 5/14/25.
//

import Foundation
import SwiftData

@MainActor
@Model
class Preference {
    // Shift/Control/Click enables the creation of multiple cursors so that you can edit multiple lines at the same time
    var locationName = ""
    var latString = ""
    var longString = ""
    var selectedUnit = UnitSystem.imperial
    var degreeUnitShowing = true
    
    init(locationName: String = "", latString: String = "", longString: String = "", selectedUnit: UnitSystem = UnitSystem.imperial, degreeUnitShowing: Bool = true) {
        self.locationName = locationName
        self.latString = latString
        self.longString = longString
        self.selectedUnit = selectedUnit
        self.degreeUnitShowing = degreeUnitShowing
    }
}

extension Preference {
    static var preview: ModelContainer {  // static means no need to create an instance of this class
        let container = try! ModelContainer(for: Preference.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // Add mock data
        container.mainContext.insert(
            // When selecting the code from code completion, tap OPTION-RETURN to get all the parameters displayed

            Preference( // CTRL-M will format a multi-parameter statement across several lines, one value per line, making it easier to read
                locationName: "Dublin, Ireland",
                latString: "53.33880",
                longString: "-6.2551",
                selectedUnit: .metric,
                degreeUnitShowing: true
            )
        )

        return container
    }
}
