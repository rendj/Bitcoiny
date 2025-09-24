import Foundation
@testable import Bitcoiny

final class JSONDecoderMock: JSONDecoderProtocol {
    private let dto: Decodable?
    private let error: Error?
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase

    init(dto: Decodable?, error: Error?) {
        self.dto = dto
        self.error = error
    }
        
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let dto = dto as? T {
            return dto
        } 
        throw error ?? MockError.invalidConfiguration
    }
}
