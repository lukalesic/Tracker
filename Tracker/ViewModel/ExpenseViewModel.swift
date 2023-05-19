//
//  ExpenseViewModel.swift
//  Tracker
//
//  Created by Luka Lešić on 30.04.2023..
//
import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    @Published var tabBarName : ExpenseType = .income
    @Published var dataState: DataState = .empty
    
    //adding new expenses
    @Published var addNew: Bool = false
    @Published var amount : String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = Date()
    @Published var desc: String = ""
    @Published var detailDesc: String = ""
    let userID = Auth.auth().currentUser?.uid
    
    private let db = Firestore.firestore()
     
     func saveData(env: EnvironmentValues) {
         let expensesCollection = db.collection("expenses")
         let newExpense = Expense(description: desc, detailDescription: detailDesc, amount: Double(amount) ?? 0, date: date, type: type, color: "Yellow", userID: self.userID ?? "")
         let expenseDict: [String: Any] = [
             "description": newExpense.description,
             "detailDescription": newExpense.detailDescription,
             "amount": newExpense.amount,
             "date": newExpense.date,
             "type": newExpense.type.rawValue,
             "color": newExpense.color,
             "userID": newExpense.userID
         ]

         do {
             _ = try expensesCollection.addDocument(data: expenseDict)
             expenses.append(newExpense)
             env.dismiss()
             print(userID)
         } catch {
             print("Error writing expense to Firestore: \(error)")
         }
     }

    func fetchAllExpenses() {
        self.dataState = .loading
        Expense.fetchAll { [weak self] expenses in
            DispatchQueue.main.async {
                self?.expenses = expenses
                self?.dataState = .populated
            }
        }
    }

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

}
