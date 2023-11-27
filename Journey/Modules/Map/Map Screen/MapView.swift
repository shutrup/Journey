//
//  MapView.swift
//  Journey
//
//  Created by Шарап Бамматов on 19.11.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        VStack {
            Map {
                
            }
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MapView()
}
