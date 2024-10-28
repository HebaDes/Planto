import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PlantsViewModel() // Initialize the ViewModel
    
    // State for the glowing and pulsating effects
    @State private var glowingEffect: Bool = false
    @State private var pulsatingEffect: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black // Black background for the first page
                    .ignoresSafeArea()

                // Glowing effect
                Circle()
                    .fill(Color(hex: "#28E0A8").opacity(0.1))
                    .scaleEffect(glowingEffect ? 1.1 : 1.0)
                    .frame(width: 300, height: 300)
                    .position(x: 190, y: 320)
                    .opacity(glowingEffect ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: glowingEffect)
                    .onAppear {
                        glowingEffect = true // Start the glowing effect
                    }

                // Pulsating effect
                Circle()
                    .fill(Color(hex: "#28E0A8").opacity(0.2))
                    .scaleEffect(pulsatingEffect ? 1.05 : 1.0)
                    .frame(width: 300, height: 250)
                    .position(x: 190, y: 330)
                    .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulsatingEffect)
                    .onAppear {
                        pulsatingEffect = true // Start the pulsating effect
                    }

                VStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 20)

                    Divider()
                        .background(Color.white)
                        .padding(.horizontal, 20)

                    Spacer()

                    Image("Plant Full") // Replace with your actual image name
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

                    // Button to open Set Reminder as a sheet
                    Button(action: {
                        viewModel.selectedPlant = nil // Reset selected plant for adding a new reminder
                        viewModel.showSheet.toggle() // Open the reminder sheet immediately
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

                // NavigationLink to TodayReminderView
                NavigationLink(
                    destination: TodayReminderView(
                        plants: $viewModel.savedPlants,
                        onAddNewReminder: {
                            viewModel.showSheet = true // Open the sheet again to add a new reminder
                            viewModel.selectedPlant = nil // Reset selected plant
                        },
                        onToggleCompleted: { index in
                            viewModel.toggleCompletion(for: index) // Toggle completion
                        },
                        onEditPlant: { plant in
                            viewModel.selectedPlant = plant // Set the selected plant for editing
                            viewModel.showSheet = true // Open the Set Reminder page for editing
                        }
                    ),
                    isActive: $viewModel.navigateToTodayReminder
                ) {
                    EmptyView()
                }

                // NavigationLink to AllRemindersCompletedView
                NavigationLink(
                    destination: AllRemindersCompletedView(navigateToNewReminder: {
                        viewModel.selectedPlant = nil // Reset selected plant for adding a new reminder
                        viewModel.showSheet.toggle()
                    }),
                    isActive: $viewModel.navigateToCompletion
                ) {
                    EmptyView()
                }
            }
            // Present the Set Reminder as a sheet
            .sheet(isPresented: $viewModel.showSheet) {
                ReminderView(
                    goToReminders: $viewModel.navigateToTodayReminder,
                    savedPlants: $viewModel.savedPlants,
                    plantToEdit: $viewModel.selectedPlant // Pass selected plant for editing
                )
                .preferredColorScheme(.dark)
            }
        }
        .preferredColorScheme(.dark) // Force dark mode on the whole app
    }
}

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
