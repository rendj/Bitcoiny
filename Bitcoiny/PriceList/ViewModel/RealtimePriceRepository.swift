import Foundation

protocol RealtimePriceRepositoryProtocol {
    func start(_ callback: @Sendable @escaping (Price) -> Void)
    func stop()
}

final class RealtimePriceRepository: RealtimePriceRepositoryProtocol, @unchecked Sendable {
    private let networkService: NetworkServiceProtocol
    private let jsonDecoder: JSONDecoderProtocol
    private var timer: Timer?
    private let updateRate = 60.0
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        jsonDecoder: JSONDecoderProtocol = JSONDecoder()
    ) {
        self.networkService = networkService
        self.jsonDecoder = jsonDecoder
    }

    func start(_ callback: @Sendable @escaping (Price) -> Void) {
        if let timer, timer.isValid {
            timer.invalidate()
            self.timer = nil
        }
        timer = Timer.scheduledTimer(withTimeInterval: updateRate, repeats: true) { _ in
            Task {
                do {
                    let pricesData = try await self.networkService.fetch(.prices(days: 1))
                    let pricesDto = try self.jsonDecoder.decode(PricesDto.self, from: pricesData)
                    let prices = pricesDto.prices
                        .map {
                            Price(from: $0)
                        }
                    callback(prices.last!)
                } catch {
                    print("Cannot get realtime update for a price. Reason: ", error.localizedDescription)
                }
            }
        }
    }
    
    func stop() {
        if let timer, timer.isValid {
            timer.invalidate()
            self.timer = nil
        }
    }
}
