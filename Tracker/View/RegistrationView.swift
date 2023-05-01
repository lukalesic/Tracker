//
//  RegistrationView.swift
//  Tracker
//
//  Created by Luka Lešić on 20.04.2023..
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    var dismiss: () -> ()

    var body: some View {
        NavigationStack{
            if userIsLoggedIn {
                ContentView()
            } else
            {
                content
            }
        }
        .onAppear{
            self.userIsLoggedIn = false
        }
    }
    
    var content: some View {
        ZStack {
            VStack(spacing: 10){
                HStack{
                    Text("Registration")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 15)
                    Spacer()
                    Button(action: dismiss) {
                              Text("Cancel")
                          }
                    .padding(.top, 15)

                }
                Spacer()
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
                    register()
                } label: {
                    Text("Register")
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 12)
                
                
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
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
}
