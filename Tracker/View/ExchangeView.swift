//
//  ExchangeView.swift
//  Tracker
//
//  Created by Luka Lešić on 06.05.2023..
//

import SwiftUI

struct ExchangeView: View {
    
    @ObservedObject var viewModel = ExchangeViewModel()
    @State private var amount = ""
    @State private var baseCurrency = "USD"
    @State private var secondCurrency = "EUR"
    @State private var showBaseCurrencyPicker = false
    @State private var result = ""
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                 amountTextField()
                 initialCurrencyPicker()
                    Text("to")
                destinationCurrencyPicker()
                }.padding(.horizontal)
                convertButton()
                resultText()
                Spacer()
            }
            .padding(.top, 12)
            .onAppear{
                Task{
                    await viewModel.getExchangeRates()
                }
            }
            .navigationTitle("Currency converter")
        }
    }    
}

extension ExchangeView {
    
    @ViewBuilder
    func initialCurrencyPicker() -> some View {
        Picker("Initial currency", selection: $baseCurrency) {
            ForEach(viewModel.results?.rates.keys.sorted() ?? [], id: \.self) { key in
                Text(key)
            }
        }
    }
    
    @ViewBuilder
    func destinationCurrencyPicker() -> some View {
        Picker("Destination currency", selection: $secondCurrency){
            ForEach(viewModel.results?.rates.keys.sorted() ?? [], id: \.self) {key in
                Text(key)
            }
        }
        .pickerStyle(.menu)
    }
    
    @ViewBuilder
    func amountTextField() -> some View {
        TextField("Enter amount", text: $amount)
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
    }
    
   @ViewBuilder
    func convertButton() -> some View {
        Button("Convert") {
            convert()
        }
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.results == nil || amount == "")
    }
    
    @ViewBuilder
    func resultText() -> some View {
        Text("\(result)")
            .padding(.top, 12)
            .font(.largeTitle)
    }
    
    func convert()  {
        guard let amount = Double(amount),
              let baseRate = viewModel.results?.rates[baseCurrency], let destinationRate = viewModel.results?.rates[secondCurrency]
        else {return}
        
        var doubleResult = 0.0
        doubleResult = ((amount / baseRate) * destinationRate)
        let formattedString = String(format: "%.2f", doubleResult)
        result = "\(formattedString) \(secondCurrency)"
    }
}
