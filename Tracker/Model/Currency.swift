//
//  Currency.swift
//  Tracker
//
//  Created by Luka Lešić on 06.05.2023..
//

import Foundation

//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let motd: MOTD
    let success: Bool
    let base, date: String
    let rates: [String: Double]
}

// MARK: - MOTD
struct MOTD: Codable {
    let msg: String
    let url: String
}
