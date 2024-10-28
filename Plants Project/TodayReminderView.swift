//
//  TodayReminderView.swift
//  Plants Project
//
//  Created by Heba Almohaisn on 24/04/1446 AH.
//

import SwiftUI

struct TodayReminderView: View {
    @Binding var plants: [Plant] // Updated to use Plant model
    var onAddNewReminder: () -> Void
    var onToggleCompleted: (Int) -> Void
    var onEditPlant: ((Plant) -> Void) // Updated to use Plant model

    var body: some View {
        VStack(alignment: .leading) {
            // Header Title Section
            Text("My Plants 🌱")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding([.leading, .top])

            Divider()

            // Spacing between "My Plants" and "Today"
            Text("Today")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading)

            List {
                ForEach(Array(plants.enumerated()), id: \.element.id) { index, plant in // Update id to plant's id
                    PlantReminderRow(
                        plant: plant, // Pass whole plant object
                        onToggleCompleted: {
                            onToggleCompleted(index)
                        },
                        onEditPlant: {
                            onEditPlant(plant)
                        }
                    )
                    .swipeActions {
                        Button(role: .destructive) {
                            // Delete the plant reminder
                            plants.remove(at: index)
                        } label: {
                            Image(systemName: "trash") // Delete icon
                        }
                        .tint(.red) // Set the color for the delete action
                    }
                }
            }
            .listStyle(PlainListStyle())

            Spacer()

            // New Reminder Button
            Button(action: {
                onAddNewReminder() // Trigger adding a new reminder
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color(hex: "#29DFA8"))
                    Text("New Reminder")
                        .foregroundColor(Color(hex: "#29DFA8"))
                        .font(.headline)
                }
            }
            .padding(.bottom, 30)
            .padding(.leading)
        }
        .background(Color.black.ignoresSafeArea()) // Black background for the third page
        .navigationBarBackButtonHidden(true) // Remove the back button
        .navigationBarTitleDisplayMode(.inline)
    }
}

