import SwiftUI

struct PlantReminderRow: View {
    var plant: Plant // Updated to use Plant model
    var onToggleCompleted: () -> Void
    var onEditPlant: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                // Circle indicator (checkbox replacement) with checkmark
                ZStack {
                    Circle()
                        .fill(plant.isCompleted ? Color(hex: "#28E0A8") : Color.clear)
                        .overlay(
                            Circle()
                                .stroke(plant.isCompleted ? Color(hex: "#28E0A8") : Color.gray, lineWidth: 2)
                        )
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            onToggleCompleted()
                        }
                    
                    if plant.isCompleted {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black) // Checkmark in black color
                    }
                }
                .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    // Room Info with Correct Location Icon
                    HStack {
                        Image(systemName: "location") // Correct location icon
                            .foregroundColor(.gray)
                        Text("in \(plant.room)") // Use plant's room
                            .font(.body)
                            .foregroundColor(.gray)
                    }

                    // Plant Name (larger size) - Clickable for editing
                    Text(plant.name) // Use plant's name
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(plant.isCompleted ? 0.5 : 1.0) // Low opacity if completed
                        .onTapGesture {
                            onEditPlant() // Trigger plant editing
                        }

                    // Sunlight and Water Tags with background
                    HStack(spacing: 4) {
                        // Light Label
                        Label {
                            Text(plant.light) // Use plant's light
                                .foregroundColor(Color(hex: "#CCC785"))
                        } icon: {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(Color(hex: "#CCC785"))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color(hex: "#2C2C2E")))
                        .opacity(plant.isCompleted ? 0.5 : 1.0) // Low opacity if completed

                        // Water Label
                        Label {
                            Text(plant.waterAmount) // Use plant's water amount
                                .foregroundColor(Color(hex: "#CAF3FB"))
                        } icon: {
                            Image(systemName: "drop.fill")
                                .foregroundColor(Color(hex: "#CAF3FB"))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color(hex: "#2C2C2E")))
                        .opacity(plant.isCompleted ? 0.5 : 1.0) // Low opacity if completed
                    }
                }

                Spacer()
            }
            Divider()
                .background(Color.gray) // Add a divider to separate plant reminders
                .padding(.vertical, 5) // Added padding to create space above and below the divider
        }
        .padding(.vertical, 10)
        .background(Color.clear) // No background for the row itself
    }
}
