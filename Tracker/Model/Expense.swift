//
//  Expense.swift
//  Tracker
//
//  Created by Luka Lešić on 30.04.2023..
//

import Foundation

struct Expense: Identifiable, Hashable {
    var id = UUID().uuidString
    var description: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "Expense"
    case all = "All"
}

var sample_expenses: [Expense] = [
    Expense(description: "test1desc", amount: 3123, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Yellow"),
    Expense(description: "test1desc", amount: 12222, date: Date(timeIntervalSince1970: 1652987245), type: .income, color: "Yellow"),
    Expense(description: "test1desc", amount: 3123, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Yellow"),
    Expense(description: "test1desc", amount: 12222, date: Date(timeIntervalSince1970: 1652987245), type: .income, color: "Yellow"),

]
