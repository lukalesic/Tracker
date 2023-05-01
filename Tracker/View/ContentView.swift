//
//  ContentView.swift
//  Tracker
//
//  Created by Luka Lešić on 20.04.2023..
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ExpenseViewModel = .init()

    var body: some View {
        TabView {
            MainTrackerView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
            }
//            DetailView()
//                .tabItem {
//                    Label("Details", systemImage: "gearshape.fill")
//                }
//            DetailView()
//                .tabItem {
//                    Label("Mjenacnica", systemImage: "gearshape.fill")
//                }
            
            HomeScreenView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
         
            
        }        .environmentObject(viewModel) // set the environmentObject modifier on the TabView

    }
}


