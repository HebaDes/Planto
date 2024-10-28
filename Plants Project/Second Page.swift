import SwiftUI

struct ReminderView: View {
    @Binding var goToReminders: Bool
    @Binding var savedPlants: [(name: String, room: String, light: String, wateringDays: String, waterAmount: String, isCompleted: Bool)]
    @Binding var plantToEdit: (name: String, room: String, light: String, wateringDays: String, waterAmount: String, isCompleted: Bool)?

    @Environment(\.dismiss) var dismiss

    @State private var plantName: String = ""
    @State private var selectedRoom = "Bedroom"
    @State private var selectedLight = "Full Sun"
    @State private var selectedWateringDays = "Every day"
    @State private var selectedWaterAmount = "20-50 ml"

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lightOptions = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringDaysOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]

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

                VStack {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.white)
                        Text("Room")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("Room", selection: $selectedRoom) {
                            ForEach(rooms, id: \.self) {
                                Text($0).foregroundColor(.gray)
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
                                Text($0).foregroundColor(.gray)
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

                VStack {
                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(.white)
                        Text("Watering Days")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("Watering Days", selection: $selectedWateringDays) {
                            ForEach(wateringDaysOptions, id: \.self) {
                                Text($0).foregroundColor(.gray)
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
                                Text($0).foregroundColor(.gray)
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

                if plantToEdit != nil {
                    Button(action: {
                        if let plant = plantToEdit, let index = savedPlants.firstIndex(where: { $0.name == plant.name }) {
                            savedPlants.remove(at: index)
                        }
                        dismiss()
                    }) {
                        Text("Delete Reminder")
                            .foregroundColor(Color(hex: "#EA7166"))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#2C2C2E"))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }

                Spacer()
            }
            .padding()
            .background(Color(hex: "#1C1C1E").ignoresSafeArea())
            .navigationBarTitle(plantToEdit != nil ? "Edit Reminder" : "Set Reminder", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Color(hex: "#29DFA8"))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let plant = plantToEdit, let index = savedPlants.firstIndex(where: { $0.name == plant.name }) {
                            savedPlants[index] = (plantName, selectedRoom, selectedLight, selectedWateringDays, selectedWaterAmount, plant.isCompleted)
                        } else {
                            let newPlant = (plantName, selectedRoom, selectedLight, selectedWateringDays, selectedWaterAmount, false)
                            savedPlants.append(newPlant)
                        }
                        dismiss()
                        goToReminders = true
                    }
                    .foregroundColor(Color(hex: "#29DFA8"))
                }
            }
        }
        .onAppear { loadPlantForEditing() }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(goToReminders: .constant(false), savedPlants: .constant([]), plantToEdit: .constant(nil))
    }
}
