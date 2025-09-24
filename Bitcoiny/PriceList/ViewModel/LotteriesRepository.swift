import Foundation

protocol PriceListRepositoryProtocol {
    func prices() async throws -> [Price]
}

final class PriceListRepository: PriceListRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let jsonDecoder: JSONDecoderProtocol

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        jsonDecoder: JSONDecoderProtocol = JSONDecoder()
    ) {
        self.networkService = networkService
        self.jsonDecoder = jsonDecoder
    }
    
    func prices() async throws -> [Price] {
        let pricesData = try await networkService.fetch(.prices())
        do {
            let pricesDto = try jsonDecoder.decode(PricesDto.self, from: pricesData)
            return pricesDto
                .prices
                .map {
                    Price(from: $0)
                }
                .sorted {
                    $0.date > $1.date
                }
        } catch {
            throw JSONDecodingError.dataInconsistency(error.localizedDescription)
        }
    }
}
