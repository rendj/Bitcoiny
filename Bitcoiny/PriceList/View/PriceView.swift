import SwiftUI

struct PriceView: View {
    private let iconHeight: Double = 40.0
    private let price: Price
    
    init(price: Price) {
        self.price = price
    }
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: "bitcoinsign.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: iconHeight, height: iconHeight)
            VStack(alignment: .leading) {
                Text(
                    price.value.formatted(.currency(code: Currency.EUR.rawValue))
                )
                    .font(.headline)
                Text(price.displayDate)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    PriceView(price: .preview)
}
