import SwiftUI

struct PriceListView: View {
    @StateObject private var viewModel: PriceListViewModel
    
    init(viewModel: PriceListViewModel = .init()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .loaded(let prices):
                    pricesView(with: prices)
                case .noPrices:
                    emptyResultView
                case .error:
                    errorView
                }
            }
            .navigationTitle(viewModel.screenTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.sendEvent(.onAppear)
        }
    }
    
    @ViewBuilder
    private func pricesView(with prices: [Price]) -> some View {
        List(prices, id: \.self) { price in
            NavigationLink {
                PriceDetails.view(for: price)
            } label: {
                PriceView(price: price)
            }
        }
    }
    
    private var emptyResultView: some View {
        Text("No prices found.")
    }
    
    private var errorView: some View {
        Text("An issue occurred, please try again later.")
    }
}

#Preview {
    PriceListView()
}
