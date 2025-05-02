//
//  FeelingHistoryView.swift
//  Soup
//
//  Created by Максим Алексеев  on 20.04.2025.
//

import SwiftUI

struct FeelingHistoryView: View {
    @State private var viewModel: FeelingHistoryViewModel
    @Environment(FirebaseDatabaseService.self) var databaseService

    // MARK: - Init

    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 22, weight: .bold),
        ]

        _viewModel = State(initialValue: FeelingHistoryViewModel())
    }

    // MARK: - View body

    var body: some View {
        NavigationStack {
            ZStack {
                Feeling.happy.colorScheme.primary
                    .ignoresSafeArea()

                ScrollView(.vertical) {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.feelingsByDate, id: \.date) { section in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(section.date)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 4)
                                ForEach(section.feelings) { response in
                                    FeelingHistoryCellView(feelingResponse: response, formattedTimeString: viewModel.convertTimestampToDateString(timestamp: response.timestamp))
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Emotion history")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("back")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Image("history")
                }
            }
        }
        .onAppear {
            viewModel = FeelingHistoryViewModel(databaseService: databaseService)
            viewModel.getFeelings()
            print(viewModel.feelings)
        }
    }
}

#Preview {
    FeelingHistoryView()
}
