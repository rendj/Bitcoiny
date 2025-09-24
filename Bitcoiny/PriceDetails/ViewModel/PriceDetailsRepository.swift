import Foundation

protocol PriceDetailsRepositoryProtocol {
    func details(for price: Price) async throws -> PriceDetailsInfo
}

final class PriceDetailsRepository: PriceDetailsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private var jsonDecoder: JSONDecoderProtocol
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        jsonDecoder: JSONDecoderProtocol = JSONDecoder()
    ) {
        self.networkService = networkService
        self.jsonDecoder = jsonDecoder
    }
    
    func details(for price: Price) async throws -> PriceDetailsInfo {
        let priceDetailsData = try await networkService.fetch(.details(for: price))
        do {
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let priceDetailsDto = try jsonDecoder.decode(PriceDetailsDto.self, from: priceDetailsData)
            return PriceDetailsInfo(from: priceDetailsDto)
        } catch {
            throw JSONDecodingError.dataInconsistency(error.localizedDescription)
        }
    }
}
