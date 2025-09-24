import SwiftUI

struct PriceListView: View {
    @StateObject private var viewModel: PriceListViewModel
    @State private var selectedPrice: Price? = nil
    
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
            .navigationTitle(Strings.defaultTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.sendEvent(.onAppear)
        }
        .onDisappear {
            selectedPrice = nil
            viewModel.sendEvent(.onDisappear)
        }
        .onChange(of: selectedPrice) {
            if let selectedPrice = $0 {
                viewModel.sendEvent(.onSelectPrice(selectedPrice))
            }
        }
    }
    
    @ViewBuilder
    private func pricesView(with prices: [Price]) -> some View {
        List(prices, id: \.self, selection: $selectedPrice) {
            PriceView(price: $0)
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
