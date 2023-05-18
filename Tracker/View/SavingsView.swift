//
//  SavingsView.swift
//  Tracker
//
//  Created by Luka Lešić on 18.05.2023..
//

import SwiftUI

struct SavingsView: View {
    @StateObject var viewModel: SavingsViewModel = .init()
    var isFiltered: Bool = false
    
    var body: some View
    {
        NavigationView {
            ZStack{
                
                VStack{
                    ScrollView {
                        savingsCard()
                        
                        transactionsView()
                    }
                    
                    .sheet(isPresented: $viewModel.addNew) {
                        viewModel.clearData()
                    } content: {
                        NewSavingView()
                            .environmentObject(viewModel)
                    }
                }
                
            }
            .navigationTitle("My expenses")
            .onAppear {
                viewModel.fetchAllSavings()
            }
        }
        
    }
    
    @ViewBuilder
    func transactionsView() -> some View {
        VStack{
            HStack{
                Text("Savings")
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
        
        ForEach(viewModel.savings) {saving in
            SavingCard(saving: saving)
                .environmentObject(viewModel)
        }
    }
    
    @ViewBuilder
    func savingsCard() -> some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    Color.gray
                )
                .opacity(0.6)
                .shadow(radius: 12)
            
            
            VStack{
                VStack{
                    Text("Currently saved up:")
                    Text(viewModel.returnTotalSavings())
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom, 5)
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

