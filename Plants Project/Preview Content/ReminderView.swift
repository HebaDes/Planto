//
//  ReminderView.swift
//  Plants Project
//
//  Created by Heba Almohaisn on 24/04/1446 AH.
//

import SwiftUI

struct ReminderView: View {
    @Binding var goToReminders: Bool
    @Binding var savedPlants: [Plant] // Updated to use Plant model
    @Binding var plantToEdit: Plant? // Updated to use Plant model
    
    @Environment(\.dismiss) var dismiss

    // Initialize state for plant details
    @State private var plantName: String = ""
    @State private var selectedRoom = "Bedroom"
    @State private var selectedLight = "Full Sun"
    @State private var selectedWateringDays = "Every day"
    @State private var selectedWaterAmount = "20-50 ml"

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lightOptions = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringDaysOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]

    // Handle initial plant loading for editing
    func loadPlantForEditing() {
        if let plant = plantToEdit {
            plantName = plant.name
            selectedRoom = plant.room
            selectedLight = plant.light
            selectedWateringDays = plant.wateringDays
            selectedWaterAmount = plant.waterAmount
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Plant Name Field
                HStack {
                    Text("Plant Name")
                        .foregroundColor(.white)
                    Spacer()
                    TextField("Pothos", text: $plantName)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(hex: "#2C2C2E"))
                .cornerRadius(10)

                // Room and Light Pickers
                VStack {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.white)
                        Text("Room")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("Room", selection: $selectedRoom) {
                            ForEach(rooms, id: \.self) {
                                Text($0)
                                    .foregroundColor(.gray)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.gray)
                    }
                    .padding(.vertical)

                    Divider()
                        .background(Color.gray)

                    HStack {
                        Image(systemName: "sun.max")
                            .foregroundColor(.white)
                        Text("Light")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("Light", selection: $selectedLight) {
                            ForEach(lightOptions, id: \.self) {
                                Text($0)
                                    .foregroundColor(.gray)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.gray)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                .background(Color(hex: "#2C2C2E"))
                .cornerRadius(10)

                // Watering Days and Water Amount Pickers
                VStack {
                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(.white)
                        Text("Watering Days")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("Watering Days", selection: $selectedWateringDays) {
                            ForEach(wateringDaysOptions, id: \.self) {
                                Text($0)
                                    .foregroundColor(.gray)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.gray)
                    }
                    .padding(.vertical)

                    Divider()
                        .background(Color.gray)

                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(.white)
                        Text("Water")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("Water", selection: $selectedWaterAmount) {
                            ForEach(waterAmounts, id: \.self) {
                                Text($0)
                                    .foregroundColor(.gray)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.gray)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                .background(Color(hex: "#2C2C2E"))
                .cornerRadius(10)

                // Show Delete Reminder button only when editing a plant
                if let _ = plantToEdit {
                    Button(action: {
                        // Remove the plant from the saved list
                        if let plant = plantToEdit, let index = savedPlants.firstIndex(where: { $0.id == plant.id }) {
                            savedPlants.remove(at: index)
                        }
                        dismiss() // Close the sheet
                    }) {
                        Text("Delete Reminder")
                            .foregroundColor(Color(hex: "#EA7166"))
                            .font(.headline)
                            .padding() // Add padding for better touch area
                            .frame(maxWidth: .infinity) // Make it full width
                            .background(Color(hex: "#2C2C2E")) // Rounded rectangle background
                            .cornerRadius(10) // Rounded corners
                    }
                    .padding(.top, 20)
                }

                Spacer()
            }
            .padding()
            .background(Color(hex: "#1C1C1E").ignoresSafeArea()) // Keep the current color for the sheet page
            .navigationBarTitle(plantToEdit != nil ? "Edit Reminder" : "Set Reminder", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                    .foregroundColor(Color(hex: "#29DFA8"))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let plant = plantToEdit, let index = savedPlants.firstIndex(where: { $0.id == plant.id }) {
                            // Update the plant information
                            savedPlants[index] = Plant(name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount, isCompleted: plant.isCompleted)
                        } else {
                            // Save the new plant information
                            let newPlant = Plant(name: plantName, room: selectedRoom, light: selectedLight, wateringDays: selectedWateringDays, waterAmount: selectedWaterAmount, isCompleted: false)
                            savedPlants.append(newPlant) // Add the new plant to the savedPlants list
                        }
                        dismiss() // Close the sheet
                        goToReminders = true
                    }
                    .foregroundColor(Color(hex: "#29DFA8"))
                }
            }
        }
        .onAppear {
            loadPlantForEditing() // Load the plant for editing when the sheet appears
        }
    }
}

