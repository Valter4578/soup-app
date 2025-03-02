//
//  FeelingsGridView.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import SwiftUI

struct FeelingsGridView: View {
    let viewModel: FeelingsViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 10),
                    GridItem(.flexible(), spacing: 10)
                ],
                spacing: 10
            ) {
                ForEach(viewModel.feelings, id: \.name) { feeling in
                    FeelingCellView(feeling: feeling)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    FeelingsGridView(viewModel: FeelingsViewModel())
}
