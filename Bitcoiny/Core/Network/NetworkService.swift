import Foundation

protocol NetworkServiceProtocol {
    func fetch(_ endpoint: Endpoint) async throws(NetworkServiceError) -> Data
}

final class NetworkService: NetworkServiceProtocol {
    let config: ProjectConfigProtocol
    let transport: TransportProtocol
    let requestBuilder: RequestBuilderProtocol
    
    init(
        config: ProjectConfigProtocol = ProjectConfig(),
        transport: TransportProtocol = URLSession.shared,
        requestBuilder: RequestBuilderProtocol = RequestBuilder()
    ) {
        self.config = config
        self.transport = transport
        self.requestBuilder = requestBuilder
    }
    
    func fetch(_ endpoint: Endpoint) async throws(NetworkServiceError) -> Data {
        guard let urlRequest = try? requestBuilder.request(from: endpoint, for: config.baseUrlString) else {
            throw NetworkServiceError.malformedRequestUrl
        }
        
        guard let (data, response) = try? await transport.data(for: urlRequest, delegate: nil) else {
            throw NetworkServiceError.transportError
        }
        switch (response as? HTTPURLResponse)?.statusCode {
        case (200..<210)?:
            return data
        case (400..<500)?:
            throw NetworkServiceError.clientError
        case (500..<599)?:
            throw NetworkServiceError.backendError
        default:
            throw NetworkServiceError.unknownError
        }
    }
}
