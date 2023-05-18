//
//  TransactionDetailView.swift
//  Tracker
//
//  Created by Luka Lešić on 18.05.2023..
//

import SwiftUI

struct TransactionDetailScreen: View {
    var expense: Expense
    
    var body: some View {
        VStack {
            expenseDescription()
            expenseAmount()
            expenseType()
            expenseDate()
            Spacer()
        }
    }
}

private extension TransactionDetailScreen {
    @ViewBuilder
    func expenseDescription() -> some View {
        Text(expense.description)
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
    
    @ViewBuilder
    func expenseAmount() -> some View {
        HStack {
            Text("Amount:")
                .font(.headline)
            Text("\(expense.amount)")
                .font(.body)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func expenseType() -> some View {
        HStack {
            Text("Type:")
                .font(.headline)
            Text(expense.type == .expense ? "Expense" : "Income")
                .font(.body)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func expenseDate() -> some View {
        HStack {
            Text("Date:")
                .font(.headline)
            Text(expense.date.formatted(date: .long, time: .omitted))
                .font(.body)
        }
        .padding(.vertical)
    }
}
