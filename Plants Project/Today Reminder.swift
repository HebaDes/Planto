import SwiftUI

struct TodayReminderView: View {
    @Binding var plants: [(name: String, room: String, light: String, wateringDays: String, waterAmount: String, isCompleted: Bool)]
    var onAddNewReminder: () -> Void
    var onToggleCompleted: (Int) -> Void
    var onEditPlant: ((name: String, room: String, light: String, wateringDays: String, waterAmount: String, isCompleted: Bool)) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("My Plants 🌱")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding([.leading, .top])

            Divider()

            Text("Today")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading)

            List {
                ForEach(Array(plants.enumerated()), id: \.offset) { index, plant in
                    PlantReminderRow(
                        plantName: plant.name,
                        room: plant.room,
                        light: plant.light,
                        waterAmount: plant.waterAmount,
                        isCompleted: plant.isCompleted,
                        onToggleCompleted: { onToggleCompleted(index) },
                        onEditPlant: { onEditPlant(plant) }
                    )
                    .swipeActions {
                        Button(role: .destructive) {
                            plants.remove(at: index)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(PlainListStyle())

            Spacer()

            Button(action: { onAddNewReminder() }) {
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
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TodayReminderView_Previews: PreviewProvider {
    static var previews: some View {
        TodayReminderView(plants: .constant([]), onAddNewReminder: {}, onToggleCompleted: { _ in }, onEditPlant: { _ in })
    }
}
