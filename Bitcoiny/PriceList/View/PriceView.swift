import SwiftUI

struct PriceView: View {
    private let price: PriceInfo
    
    init(price: PriceInfo) {
        self.price = price
    }
    
    var body: some View {
        Text("Price")
    }
}

#Preview {
    PriceView(price: .preview)
}
