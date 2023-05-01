//
//  MainTrackerView.swift
//  Tracker
//
//  Created by Luka Lešić on 30.04.2023..
//

import SwiftUI

struct MainTrackerView: View {
    @StateObject var viewModel: ExpenseViewModel = .init()
    @State private var animateGradient : Bool = false
    var isFiltered: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{

                VStack{
                    ScrollView {
                        NavigationLink {
                            DetailView()
                                .environmentObject(viewModel)
                        } label: {
                            expenseCard()
                        }

                        transactionsView()

                    }

                        .sheet(isPresented: $viewModel.addNew) {
                            viewModel.clearData()
                        } content: {
                            NewExpenseView()
                                .environmentObject(viewModel)
                    }
                }

            }
            .navigationTitle("My expenses")

        }
        
    }
    
    @ViewBuilder
    func transactionsView() -> some View {
        VStack{
            HStack{
                Text("Transactions")
                    .font (.title2.bold())
                    .opacity (0.7)
                    .frame(maxWidth: .infinity, alignment: .leading)
           

                
                Button {
                    viewModel.addNew = true

                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(
                        Circle()
                            .fill(
                                Color.cyan
                            )
                            
                        )
                }.shadow(radius: 12)

            }
            
        } .padding(.top)
            .padding(.horizontal)
            .padding(.bottom)
        
        ForEach(viewModel.expenses) {expense in
            TransactionCard(expense: expense)
                .environmentObject(viewModel)
        }
    }
    
    @ViewBuilder
    func expenseCard() -> some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .linearGradient(colors: [Color.blue, Color.yellow, Color.pink], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .topTrailing: .bottomTrailing)
                )
                .shadow(radius: 12)
                .hueRotation(.degrees(animateGradient ? 90 : 0))
                .onAppear {
                    withAnimation (.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            
            VStack{
                VStack{
                    Text(isFiltered ? viewModel.convertDateToString() : viewModel.currentMonthDateString())
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                        .padding(.bottom, 25)
                    Text("Available balance:")
                    Text(viewModel.convertExpensesToCurrency(expenses: viewModel.expenses))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                    Text("Tap for more info.")
                        .opacity(0.75)
                        .font(.system(size: 12))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }
        .frame(height: 180)
        .padding(.top)
        .padding(.horizontal)
    }
    
}
