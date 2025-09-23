import SwiftUI

struct PriceView: View {
    private let iconHeight: Double = 40.0
    private let price: PriceInfo
    
    init(price: PriceInfo) {
        self.price = price
    }
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: "bitcoinsign.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: iconHeight, height: iconHeight)
            VStack(alignment: .leading) {
                Text(price.value.formatted(.currency(code: "EUR")))
                    .font(.headline)
                Text(price.displayDate)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    PriceView(price: .preview)
}
