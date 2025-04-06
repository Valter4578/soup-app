//
//  MapView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(ThemeManager.self) private var themeManager
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        ZStack {
            Map(position: $position)
                .mapStyle(.hybrid(elevation: .realistic))
            VStack {
                
                HStack {
                    Spacer()
                    Text("You are located 8,541 km away from each other")
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            themeManager.currentScheme.gradient
//                            AppColors.Gradients.primaryGradient
                            
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    Spacer()
                }
                Spacer()
            }
            
            
        }

    }
}

#Preview {
    MapView()
}
