import SwiftUI

struct PriceDetailsView: View {
    private let currencyIconWidth = 120.0
    private let verticalSpacing = 32.0
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PriceDetailsViewModel
    
    init(viewModel: PriceDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let priceDetails):
                priceDetailsView(for: priceDetails)
            case .error:
                errorView
            }
        }
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .tint(.secondary)
                }
            }
        }
        .onAppear {
            viewModel.sendEvent(.onAppear)
        }
    }
    
    @ViewBuilder
    private func priceDetailsView(for priceDetails: PriceDetailsInfo) -> some View {
        VStack(spacing: verticalSpacing) {
            Image(systemName: "bitcoinsign.circle")
                .resizable()
                .frame(width: currencyIconWidth, height: currencyIconWidth)
            Grid {
                ForEach(priceDetails.values, id: \.currency) { value in
                    GridRow {
                        Text(value.currency.rawValue)
                        Text(value.price.formatted(.number))
                            .fontWeight(.semibold)
                    }
                    .padding(4)
                    Divider()
                        .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            Spacer()
        }
        .padding(.top, verticalSpacing)
    }
   
    private var errorView: some View {
        Text(Strings.issueMessage)
    }
}

#Preview {
    let viewModel = PriceDetailsViewModel(price: .preview)
    PriceDetailsView(viewModel: viewModel)
}
