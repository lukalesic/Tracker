import SwiftUI

struct SavingCard: View {
    var saving: Saving
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(convertNumberToPrice(value: saving.amount))
                .font(.headline)
                .foregroundColor(.green)
            Spacer()
            Text(saving.date.formatted(date: .numeric, time: .omitted))
                .font(.caption)

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.linearGradient(colors: [Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                .opacity(colorScheme == .light ? 0.1 : 0.2))
        .padding(.horizontal)
    }
    
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter.string(from: .init(value: value)) ?? "0 EUR"
    }
}
