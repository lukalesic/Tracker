//
//  ExpenseViewModel.swift
//  Tracker
//
//  Created by Luka Lešić on 30.04.2023..
//
import SwiftUI
import Foundation

@MainActor class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = sample_expenses
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    @Published var tabBarName : ExpenseType = .income
    
    //adding new expenses
    @Published var addNew: Bool = false
    @Published var amount : String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = Date()
    @Published var desc: String = ""
    
    init () {
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents ([.year, .month], from: Date())
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    
    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func returnIncome(type: ExpenseType = .income) -> String {
        var sum : Double = 0.0
        for expense in expenses {
            if expense.type == type {
                sum += expense.amount
            }
        }
        return convertNumberToPrice(value: sum)
    }
    
    
    func convertExpensesToCurrency(expenses: [Expense], type: ExpenseType = .expense) -> String {
        var value: Double = 0
        value = expenses.reduce(0, { partialResult, expense in
            return partialResult + (expense.type == .income ? expense.amount : -expense.amount)
        })
        return convertNumberToPrice(value: value)
    }
    
    func convertDateToString() -> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter.string(from: .init(value: value)) ?? "0 EUR"
    }
    
    func clearData() {
        date = Date()
        desc = ""
        type = .all
        amount = ""
    }
    
    func saveData(env: EnvironmentValues) {
        print ("Save")
        // MARK: This is For UI Demo
        let amountInDouble = (amount as NSString) .doubleValue
        let colors = ["Yellow", "Red", "Purple", "Green" ]
        let expense = Expense(description: desc, amount: amountInDouble, date: date, type: type, color: colors.randomElement () ?? "Yellow")
        withAnimation{expenses.append(expense)}
        expenses = expenses.sorted(by: { first, second in
        return second.date < first.date })
        env.dismiss ()
    }
}
