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
            HomeExpenseView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
            }
            SavingsView()
                .tabItem {
                    Label("Savings", systemImage: "dollarsign")
                }
            ExchangeView()
                .tabItem{
                    Label("Exchange", systemImage: "dollarsign.arrow.circlepath")
                }
            HomeScreenView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
         
            
        }        .environmentObject(viewModel) // set the environmentObject modifier on the TabView

    }
}


