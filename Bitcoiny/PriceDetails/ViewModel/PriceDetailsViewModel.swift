import Foundation

@MainActor
final class PriceDetailsViewModel: ObservableObject {
    enum Event {
        case onAppear
    }
    
    enum State: Equatable {
        case idle
        case loading
        case loaded(PriceDetailsInfo)
        case error
    }
    
    private let priceDetailsRepository: PriceDetailsRepositoryProtocol
    private let price: Price
    
    @Published var state: State = .idle
    
    init(
        price: Price,
        priceDetailsRepository: PriceDetailsRepositoryProtocol = PriceDetailsRepository()
    ) {
        self.price = price
        self.priceDetailsRepository = priceDetailsRepository
    }
    
    var screenTitle: String {
        String(localized: "Prices for ") + DateFormatter.short.string(from: price.date)
    }
    
    func sendEvent(_ event: Event) {
        switch event {
        case .onAppear:
            fetchPriceDetails()
        }
    }
    
    private func fetchPriceDetails() {
        guard state != .loading else {
            return
        }
        state = .loading
        Task { [priceDetailsRepository] in
            do {
                let priceDetails = try await priceDetailsRepository.details(for: price)
                state = .loaded(priceDetails)
            } catch {
                state = .error
            }
        }
    }
}
