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
    
    var body: some View {
        NavigationStack{
            ModalPresenter{
                if userID == "" {
                    content()
                } else
                {
                    ContentView()
                }
            }
        }
    }

}

extension LoginView {
    
    @ViewBuilder
    func content() -> some View {
        ZStack {
            VStack(spacing: 10){
                HStack{
                        welcomeText()
                }
                Spacer()
                helpText()
                emailInput()
                passwordInput()
                loginButton()
                
                ModalLink {dismiss in
                    RegistrationView.init(dismiss: dismiss)
                } label: {
                    Text("Don't have an account? Create one!")
                        .font(.footnote)
                        .buttonStyle(PlainButtonStyle())
                }
                
                    Spacer()
            }.padding(.horizontal)
        }
        
    }
    
    @ViewBuilder
    func welcomeText() -> some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
    }
    
    @ViewBuilder
    func helpText() -> some View {
        Text("Please login to access your budget tracker")
            .font(.footnote)
            .fontWeight(.bold)
            .padding(.bottom, 15)
    }
    
    @ViewBuilder
    func emailInput() -> some View {
        TextField("Email", text: $email)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func passwordInput() -> some View {
        SecureField("Password", text: $password)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func loginButton() -> some View {
        Button {
            login()
        } label: {
            Text("Firebase login")
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 12)
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

