//
//  TabBarView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI


struct WithTabBar<Content>: View where Content: View {
    @State private var selection: Tabs = .map
    @ViewBuilder var content: (Tabs) -> Content
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                content(selection)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .overlay(alignment: .bottom) {
                TabBarView(selection: $selection)
            }
        }
    }
}


struct TabBarView: View {
    @Binding var selection: Tabs
    @State private var symbolTrigger: Bool = true
    @Namespace private var tabItemNameSpace
    
    func changeTabTo(_ tab: Tabs) {
//        withAnimation(.bouncy(duration: 0.4, extraBounce: 0.15)) {
        withAnimation(.bouncy(duration: 0.4, extraBounce: 0.1)) {
            selection = tab
        }
//        }
        
        symbolTrigger.toggle()
    }
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Button(action: {
                    changeTabTo(tab)
                }) {
                    if tab == selection {
                        ActiveTabLabel(tabItem: tab.item)
                            .matchedGeometryEffect(id: "tabItem", in: tabItemNameSpace)
                    } else {
                        InActiveTabLabel(tabItem: tab.item)
                    }
                }
                .symbolEffect(.bounce.up.byLayer, value: symbolTrigger)
                .foregroundStyle(tab.item.color)
                .withTabButtonStyle()
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 35.0))
        .shadow(color: Color(hex: "#231D1129"), radius: 29, x: 0, y: 11)
    }
}

#Preview {
    WithTabBar { tab in
        Text(tab.item.title)
    }
}
