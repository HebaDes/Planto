import SwiftUI

struct MyPlantsView: View {
    @State private var showSheet = false
    @State private var navigateToTodayReminder = false
    @State private var navigateToCompletion = false
    @State private var savedPlants: [Plant] = [] // Updated to use Plant model
    @State private var selectedPlant: Plant? // Updated to use Plant model

    @State private var glowingEffect: Bool = false
    @State private var pulsatingEffect: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                Circle()
                    .fill(Color(hex: "#28E0A8").opacity(0.1))
                    .scaleEffect(glowingEffect ? 1.1 : 1.0)
                    .frame(width: 300, height: 300)
                    .position(x: 190, y: 320)
                    .opacity(glowingEffect ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: glowingEffect)
                    .onAppear { glowingEffect.toggle() }

                Circle()
                    .fill(Color(hex: "#28E0A8").opacity(0.2))
                    .scaleEffect(pulsatingEffect ? 1.05 : 1.0)
                    .frame(width: 300, height: 250)
                    .position(x: 190, y: 330)
                    .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulsatingEffect)
                    .onAppear { pulsatingEffect.toggle() }

                VStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 20)

                    Divider().background(Color.white).padding(.horizontal, 20)

                    Spacer()

                    Image("Plant Full")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding(.bottom, 30)

                    Text("Start your plant journey!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)

                    Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                        .font(.system(size: 18))
                        .foregroundColor(Color(white: 0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    Button(action: {
                        selectedPlant = nil
                        showSheet.toggle()
                    }) {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#29DFA8"))
                            .cornerRadius(12)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding(.top)
                .navigationBarHidden(true)

                NavigationLink(
                    destination: TodayReminderView(
                        plants: $savedPlants, // Pass Binding of Plant array
                        onAddNewReminder: { showSheet = true; selectedPlant = nil },
                        onToggleCompleted: { index in
                            savedPlants[index].isCompleted.toggle()
                            checkForCompletion()
                        },
                        onEditPlant: { plant in
                            selectedPlant = plant
                            showSheet = true
                        }
                    ),
                    isActive: $navigateToTodayReminder
                ) {
                    EmptyView()
                }

                NavigationLink(
                    destination: AllRemindersCompletedView(navigateToNewReminder: {
                        selectedPlant = nil
                        showSheet.toggle()
                    }),
                    isActive: $navigateToCompletion
                ) {
                    EmptyView()
                }
            }
            .sheet(isPresented: $showSheet) {
                ReminderView(goToReminders: $navigateToTodayReminder, savedPlants: $savedPlants, plantToEdit: $selectedPlant) // Pass updated types
                    .preferredColorScheme(.dark)
            }
        }
        .preferredColorScheme(.dark)
    }

    private func checkForCompletion() {
        if savedPlants.allSatisfy({ $0.isCompleted }) {
            navigateToCompletion = true
        }
    }
}

struct MyPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlantsView()
    }
}
