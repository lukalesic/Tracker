//
//  NewExpenseView.swift
//  Tracker
//
//  Created by Luka Lešić on 01.05.2023..
//

import SwiftUI

struct NewExpenseView: View {
    @EnvironmentObject var viewModel: ExpenseViewModel
    @Environment (\.self) var env
    var body: some View {
        VStack{
            VStack{
                Text("Add Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                    .padding(.top, 15)
                if let symbol = viewModel.convertNumberToPrice(value:0).first{
                    TextField("0", text: $viewModel.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color.cyan)
                        .multilineTextAlignment (.center)
                        .keyboardType(.numberPad)
                        . background{
                            Text(viewModel.amount == "" ? "EUR" : viewModel.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .trailing) {
                                Text("€")
                                        .opacity (0.5)
                                        .offset(x: 15, y: 0)
                                
                            }
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                }
                TextField("Description", text: $viewModel.desc)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                HStack{
                    Text("Date:")
                        .fontWeight(.semibold)
                        .opacity(0.7)

                    DatePicker.init("", selection: $viewModel.date, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                   
                }
                HStack(spacing: 10){
                    ForEach( [ExpenseType.income, ExpenseType.expense], id: \.self){type in
                        ZStack{
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.black, lineWidth: 2)
                                .opacity(0.5)
                                .frame(width: 20, height: 20)
                            if viewModel.type == type{
                                Image(systemName: "checkmark")
                                    .font(.caption.bold())
                                    .foregroundColor (Color.green)
                            }
                        }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        viewModel.type = type
                                    }
                        Text(type.rawValue)
                    }
                }.padding(.vertical)
                Spacer()
                Button {
                    viewModel.saveData(env: env)
                    env.dismiss()
                } label: {
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.desc == ""  || viewModel.type == .all || viewModel.amount == "")
                .opacity(viewModel.desc == "" || viewModel.type == .all || viewModel.amount == "" ? 0.6 : 1)
            }
            
        }
    }
}
