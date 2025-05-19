//
//  SetCountdownView.swift
//  Soup
//
//  Created by Максим Алексеев  on 19.05.2025.
//

import SwiftUI

struct SetCountdownView: View {
    // MARK: - Layout Constants
    private enum Constants {
        static let horizontalPadding: CGFloat = 20
        static let verticalSpacing: CGFloat = 40
        static let textFieldTopPadding: CGFloat = 39
        static let cornerRadius: CGFloat = 16
        static let textFieldHeight: CGFloat = 42
        static let calendarSpacing: CGFloat = 10
        static let buttonVerticalPadding: CGFloat = 15
        static let buttonHorizontalPadding: CGFloat = 30
    }

    // MARK: - Properties

    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.dismiss) private var dismiss

    var viewModel: CountdownViewModel
    @State private var eventName: String = ""
    @State private var selectedDate: Date = .init()
    @State private var selectedTime: Date = .init()

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.verticalSpacing) {
                // Event name text field
                TextField("Event name", text: $eventName)
                    .padding()
                    .frame(height: Constants.textFieldHeight)
                    .background(Color.white)
                    .cornerRadius(50)
                    .padding(.horizontal, Constants.horizontalPadding)
                    .padding(.top, Constants.textFieldTopPadding)
                
                // Calendar view
                calendarView
                    .padding(.horizontal, Constants.horizontalPadding)

                Spacer()

                // Create meeting button
                ButtonView(withStroke: false, action: {
//                    // Combine date and time components
//                    let calendar = Calendar.current
//                    let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
//                    let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
//
//                    var combinedComponents = DateComponents()
//                    combinedComponents.year = dateComponents.year
//                    combinedComponents.month = dateComponents.month
//                    combinedComponents.day = dateComponents.day
//                    combinedComponents.hour = timeComponents.hour
//                    combinedComponents.minute = timeComponents.minute
//
//                    if let combinedDate = calendar.date(from: combinedComponents) {
//                        let timeInterval = combinedDate.timeIntervalSince(Date())
//                        viewModel.startTimer(duration: timeInterval > 0 ? timeInterval : 0)
//                    }

                    viewModel.setCountdownt(to: selectedDate)
                    dismiss()
                }, text: "Create meeting")
                    .padding(.bottom, Constants.verticalSpacing)
            }
            .navigationTitle("Set countdown")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("back")
                            .foregroundColor(.white)
                    }
                }
            }
            .background(themeManager.currentScheme.background)
        }
    }

    // MARK: - Subviews

    private var calendarView: some View {
        VStack(alignment: .leading, spacing: Constants.calendarSpacing) {
            
            DatePicker("Enter your meet date", selection: $selectedDate)
                           .datePickerStyle(GraphicalDatePickerStyle())
                           .frame(maxHeight: 400)
                           .background(.white)
                           .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    

    // MARK: - Helper Methods

    private var formattedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: date)
    }
}


#Preview {
    SetCountdownView(viewModel: CountdownViewModel(dbService: nil))
        .environment(ThemeManager(databaseService: FirebaseDatabaseService()))
}
