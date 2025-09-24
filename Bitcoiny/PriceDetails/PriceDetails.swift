import SwiftUI

@MainActor
struct PriceDetails {
    static func view(for price: Price) -> some View {
        let viewModel = PriceDetailsViewModel(price: price)
        return PriceDetailsView(viewModel: viewModel)
    }
}
