//
//  LoginScreen.swift
//  Tracker
//
//  Created by Luka Lešić on 20.04.2023..
//

import SwiftUI
import Firebase
import ModalView

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @AppStorage("uid") var userID = ""
  //  @State private var userIsLoggedIn = false
    
    var body: some View {
        NavigationStack{
            ModalPresenter{
                if userID == "" {
                    loginScreen
                } else
                {
                    ContentView()
                }
            }
        }
    }
       
    
    var loginScreen: some View {
        ZStack {
            VStack(spacing: 10){
                HStack{
                    Text("Welcome!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 15)
                    
                }
                Spacer()
                Text("Please login to access your budget tracker")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding(.bottom, 15)
                TextField("Email", text: $email)
                    .frame(height: 55)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.horizontal], 10)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.horizontal], 24)
                
                SecureField("Password", text: $password)
                    .frame(height: 55)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.horizontal], 10)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.horizontal], 24)
                
                Button {
                    login()
                } label: {
                    Text("Firebase login")
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 12)
                
                ModalLink {dismiss in
                    
                    RegistrationView.init(dismiss: dismiss)
                } label: {
                    Text("Don't have an account? Create one!")
                        .font(.footnote)
                        .buttonStyle(PlainButtonStyle())
                }
                
                
                //                Button {
                //                    register()
                //                } label: {
                //                    Text("Firebase register")
                //                }
                //                .buttonStyle(.borderedProminent)
                
                
                //                .onAppear {
                //                    Auth.auth().addStateDidChangeListener { auth, user in
                //                        if user != nil {
                //                            userIsLoggedIn.toggle()
                //                        }
                //                    }
                //               }
                Spacer()
            }.padding(.horizontal)
        }
        
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
            if let result = result {
                withAnimation {
                    userID = result.user.uid
                }
            }
        }
    }
}

