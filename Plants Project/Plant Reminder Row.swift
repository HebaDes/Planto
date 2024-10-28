//
//  Plant Reminder Row.swift
//  Plants Project
//
//  Created by Heba Almohaisn on 24/04/1446 AH.
//

import SwiftUI

struct PlantReminderRow: View {
    var plantName: String
    var room: String
    var light: String
    var waterAmount: String
    var isCompleted: Bool
    var onToggleCompleted: () -> Void
    var onEditPlant: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? Color(hex: "#28E0A8") : Color.clear)
                        .overlay(
                            Circle()
                                .stroke(isCompleted ? Color(hex: "#28E0A8") : Color.gray, lineWidth: 2)
                        )
                        .frame(width: 25, height: 25)
                        .onTapGesture { onToggleCompleted() }
                    
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                    }
                }
                .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.gray)
                        Text("in \(room)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }

                    Text(plantName)
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(isCompleted ? 0.5 : 1.0)
                        .onTapGesture { onEditPlant() }

                    HStack(spacing: 4) {
                        Label {
                            Text(light)
                                .foregroundColor(Color(hex: "#CCC785"))
                        } icon: {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(Color(hex: "#CCC785"))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color(hex: "#2C2C2E")))
                        .opacity(isCompleted ? 0.5 : 1.0)

                        Label {
                            Text(waterAmount)
                                .foregroundColor(Color(hex: "#CAF3FB"))
                        } icon: {
                            Image(systemName: "drop.fill")
                                .foregroundColor(Color(hex: "#CAF3FB"))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(Color(hex: "#2C2C2E")))
                        .opacity(isCompleted ? 0.5 : 1.0)
                    }
                }

                Spacer()
            }
            Divider().background(Color.gray).padding(.vertical, 5)
        }
        .padding(.vertical, 10)
    }
}

