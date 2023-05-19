//
//  HomeScreenView.swift
//  Tracker
//
//  Created by Luka Lešić on 20.04.2023..
//

import SwiftUI
import Firebase

struct HomeScreenView: View {
    @AppStorage("uid") var userID = ""
    @State private var isActive = false
    
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            userID = ""
            withAnimation {
                LoginView(userID: "")
                isActive = true
            }
        }
        catch let signOutError as NSError {
            print("Error signing out")
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                Button("Log out") {
                    withAnimation {
                        logOut()
                        isActive = true
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
    
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
