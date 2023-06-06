//
//  LoginViewModel.swift
//  Tracker
//
//  Created by Luka Lešić on 20.04.2023..
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI

class AccountViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @AppStorage("uid") var userID = ""
    @Published var loginError: String?
    @Published var registrationError: String?
    @Published var successMessage: String?

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.loginError = error?.localizedDescription ?? ""
            } else {
                self.loginError = nil

            }
            if let result = result {
                withAnimation {
                    self.userID = result.user.uid
                }
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            if error != nil {
                self.registrationError = error?.localizedDescription ?? ""
            } else {
                self.registrationError = nil
                self.successMessage = "Successfully registered! You may now login."
            }
        }
    }
}
