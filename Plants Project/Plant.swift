//
//  Plant.swift
//  Plants Project
//
//  Created by Heba Almohaisn on 24/04/1446 AH.
//

import Foundation

// Plant model to encapsulate plant data and behavior
struct Plant: Identifiable {
    var id = UUID() // Unique identifier for each plant
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isCompleted: Bool
}
