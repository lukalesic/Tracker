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
                registrationContent()
            }
        }
        .onAppear{
            self.userIsLoggedIn = false
        }
    }
}

extension RegistrationView {
    
    @ViewBuilder
    func registrationContent() -> some View {
        ZStack {
            VStack(spacing: 10){
                title()
                Spacer()
                emailField()
                passwordField()
                registerButton()
                Spacer()
            }.padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func title() -> some View {
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
    }
    
    @ViewBuilder
    func emailField() -> some View {
        TextField("Email", text: $email)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func passwordField() -> some View {
        SecureField("Password", text: $password)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func registerButton() -> some View {
        Button {
            register()
        } label: {
            Text("Register")
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 12)
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
