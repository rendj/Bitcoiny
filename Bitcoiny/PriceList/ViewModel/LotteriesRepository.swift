import Foundation

protocol PriceListRepositoryProtocol {
    func prices() async throws -> [PriceInfo]
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
    
    func prices() async throws -> [PriceInfo] {
        []
    }
}
