//
//  MainTrackerView.swift
//  Tracker
//
//  Created by Luka Lešić on 30.04.2023..
//

import SwiftUI

struct DetailView: View {
   // @StateObject var viewModel: ExpenseViewModel = .init()
    @EnvironmentObject var viewModel: ExpenseViewModel
    @Namespace var animation
    @Environment(\.colorScheme) var colorScheme
    @State private var animateGradient : Bool = false
    
    var body: some View {
      //  NavigationView {
            ScrollView {
                expenseSegmentedControl()
                    .padding(.bottom)
                VStack{
                    Text(viewModel.convertDateToString())
                        .opacity(0.7)
                        .font(.footnote)
                        .foregroundColor(.white)

                    Text("Total \(viewModel.tabBarName == .income ? "income" : "expenses"):")
                        .foregroundColor(.white)
                    Text(viewModel.returnIncome(type: viewModel.tabBarName))
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .foregroundColor(.white)

                }
                    .padding()
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(
                                .linearGradient(colors: [Color.blue, Color.cyan], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .topTrailing: .bottomTrailing)
                            )
                            .shadow(color: .blue, radius: 10)
                            .padding(.horizontal)
                            .hueRotation(.degrees(animateGradient ? 90 : 0))
                            .onAppear {
                                withAnimation (.easeInOut(duration: 7).repeatForever(autoreverses: true)) {
                                    animateGradient.toggle()
                                }
                            }
                    }
                
                VStack{
                    Text("Filter")
                        .font (.title2.bold())
                        .opacity (0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } .padding(.top)
                    .padding(.horizontal)
                    .padding(.bottom)

                
                HStack {
                    HStack{
                        Text("From")
                            .font(.caption)
                        DatePicker("", selection: $viewModel.startDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("To")
                            .font(.caption)
                        DatePicker("", selection: $viewModel.endDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)

                    }
                    .padding(.horizontal)
                }
                
                VStack{
                    Text("\(viewModel.tabBarName == .income ? "Income" : "Expenses"):")
                        .font (.title2.bold())
                        .opacity (0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } .padding(.top)
                    .padding(.horizontal)
                    .padding(.bottom)

                
                ForEach(viewModel.expenses.filter{return $0.type == viewModel.tabBarName}) {expense in
//                ForEach(viewModel.expenses) {expense in
// TODO: ovdje se samo ne refresha array kad dodajem novoo
                    TransactionCard(expense: expense)
                        .environmentObject(viewModel)
                }
                
                    .navigationTitle("Expense details")
            }
      //  }
    }
        @ViewBuilder
        func expenseSegmentedControl () -> some View {
            HStack{
                ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { tab in
                    
                    Text(tab.rawValue)
                        .fontWeight(.semibold)
                        .opacity(viewModel.tabBarName == tab ? 1 : 0.6)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity, maxHeight: 27)
                        .background{
                            if viewModel.tabBarName == tab {
                                RoundedRectangle (cornerRadius: 10, style: .continuous )
                                    .fill(
                                        LinearGradient(colors: [Color.gray, Color.gray],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing))
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                viewModel.tabBarName = tab
                            }
                        }
                }
            }.padding(5)
                .background(
                    RoundedRectangle (cornerRadius: 10, style: .continuous)
                        .fill(colorScheme == .light ? .gray : .gray)
                        .opacity(colorScheme == .light ? 0.1 : 0.2)
                    
                )
            
        }
    }

