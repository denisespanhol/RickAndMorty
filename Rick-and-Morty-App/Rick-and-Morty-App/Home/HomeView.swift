//
//  HomeView.swift
//  Rick-and-Morty-App
//
//  Created by Denis Guilherme Ferreira Espanhol on 28/07/26.
//

import SwiftUI
import DSM

struct HomeView: View {
    
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        
        TabView {
            DSM.DSMTabView(nameLabel: "Characters", systemImage: "person.2.fill") {
                CharacterListView()
            }
            
            DSM.DSMTabView(nameLabel: "Locations", systemImage: "map.fill") {
                LocationListView()
            }
            
            DSM.DSMTabView(nameLabel: "Episodes", systemImage: "tv.fill") {
                EpisodeListView()
            }
        }
        .tint(DSMColors.secondary)
    }
}
