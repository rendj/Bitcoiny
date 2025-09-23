import Foundation

@MainActor
final class PriceListViewModel: ObservableObject {
    enum Event {
        case onAppear
    }
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([PriceInfo])
        case noPrices
        case error
    }
    
    private let priceListRepository: PriceListRepositoryProtocol
    
    @Published var state: State = .idle
    
    init(priceListRepository: PriceListRepositoryProtocol = PriceListRepository()) {
        self.priceListRepository = priceListRepository
    }
    
    func sendEvent(_ event: Event) {
        switch event {
        case .onAppear:
            fetchPrices()
        }
    }
    
    private func fetchPrices() {
        guard state != .loading else {
            return
        }
        state = .loading
        Task { [priceListRepository] in
            do {
                let prices = try await priceListRepository.prices()
                if prices.isEmpty {
                    state = .noPrices
                } else {
                    state = .loaded(prices)
                }
            } catch {
                state = .error
            }
        }
    }
}
