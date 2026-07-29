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
            CharacterListView()
                .tabItem { Label("Characters", systemImage: "person.2.fill") }
             /*LocationListView()
                 .tabItem { Label("Locations", systemImage: "map.fill") }
             
             EpisodeListView()
                 .tabItem { Label("Episodes", systemImage: "tv.fill") }  */
        }
    }
}
