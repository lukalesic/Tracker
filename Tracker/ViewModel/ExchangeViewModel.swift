//
//  ExchangeViewModel.swift
//  Tracker
//
//  Created by Luka Lešić on 06.05.2023..
//

import Foundation
import SwiftUI

@MainActor
class ExchangeViewModel: ObservableObject {
    
    @Published var results: Welcome?

    func getExchangeRates() async {
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=USD&amount=1000") else {return}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.results = try JSONDecoder().decode(Welcome.self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
}

