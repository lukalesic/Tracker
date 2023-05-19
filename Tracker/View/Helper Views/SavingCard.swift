import SwiftUI

struct SavingCard: View {
    var saving: Saving
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel : SavingsViewModel

    var body: some View {
        HStack {
            Text(viewModel.convertNumberToPrice(value: saving.amount))
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
}
