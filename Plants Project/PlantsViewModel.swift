//
//  PlantsViewModel.swift
//  Plants Project
//
//  Created by Heba Almohaisn on 24/04/1446 AH.
//


import Combine

class PlantsViewModel: ObservableObject {
    @Published var savedPlants: [Plant] = []
    @Published var selectedPlant: Plant?
    @Published var navigateToTodayReminder = false
    @Published var navigateToCompletion = false
    @Published var showSheet = false

    // Function to add a new plant
    func addPlant(name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        let newPlant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount, isCompleted: false)
        savedPlants.append(newPlant)
    }

    // Function to update an existing plant
    func updatePlant(name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        if let index = savedPlants.firstIndex(where: { $0.id == selectedPlant?.id }) {
            savedPlants[index] = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount, isCompleted: savedPlants[index].isCompleted)
        }
    }

    // Function to toggle completion status of a plant
    func toggleCompletion(for index: Int) {
        savedPlants[index].isCompleted.toggle()
        checkForCompletion()
    }

    // Function to check if all reminders are completed
    private func checkForCompletion() {
        if savedPlants.allSatisfy({ $0.isCompleted }) {
            navigateToCompletion = true
        }
    }

    // Function to remove a plant
    func removePlant(at index: Int) {
        savedPlants.remove(at: index)
    }
}

