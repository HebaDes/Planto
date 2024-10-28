//
//  All Reminder Completed .swift
//  Plants Project
//
//  Created by Heba Almohaisn on 24/04/1446 AH.
//

import SwiftUI

struct AllRemindersCompletedView: View {
    var navigateToNewReminder: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
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

                VStack {
                    Image("Group")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .position(x: 190, y: 240)

                    Text("All Done 🎉!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .position(x: 200, y: 240)

                    Text("Now all reminders completed")
                        .font(.system(size: 18))
                        .foregroundColor(Color(white: 0.8))
                        .position(x: 200, y: 170)
                }
                
                Spacer()

                Button(action: { navigateToNewReminder() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(hex: "#29DFA8"))
                        Text("New Reminder")
                            .foregroundColor(Color(hex: "#29DFA8"))
                            .font(.headline)
                    }
                }
                .position(x: 90, y: 299)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AllRemindersCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        AllRemindersCompletedView(navigateToNewReminder: {})
    }
}

