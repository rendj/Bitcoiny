import Foundation

@MainActor
final class PriceListViewModel: ObservableObject {
    enum Event {
        case onAppear
        case onSelectPrice(Price)
        case onDisappear
    }
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Price])
        case noPrices
        case error
    }
    
    private let priceListRepository: PriceListRepositoryProtocol
    private let realtimePriceRepository: RealtimePriceRepositoryProtocol
    
    @Published var state: State = .idle
    
    init(
        priceListRepository: PriceListRepositoryProtocol = PriceListRepository(),
        realtimePriceRepository: RealtimePriceRepositoryProtocol = RealtimePriceRepository()
    ) {
        self.priceListRepository = priceListRepository
        self.realtimePriceRepository = realtimePriceRepository
    }
    
    func sendEvent(_ event: Event) {
        switch event {
        case .onAppear:
            fetchPrices()
        case .onSelectPrice(_):
            break
        case .onDisappear:
            unsubscribeFromRealtimeUpdates()
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
                    subscribeForRealtimeUpdates()
                }
            } catch {
                state = .error
            }
        }
    }
    
    private func subscribeForRealtimeUpdates() {
        realtimePriceRepository.start { recentPrice in
            Task { @MainActor in
                if case .loaded(var loadedPrices) = self.state {
                    loadedPrices.removeFirst()
                    loadedPrices.insert(recentPrice, at: 0)
                    self.state = .loaded(loadedPrices)
                }
            }
        }
    }
    
    private func unsubscribeFromRealtimeUpdates() {
        realtimePriceRepository.stop()
    }
}
