import XCTest
@testable import Bitcoiny

class PriceListRepositoryTests: XCTestCase {
    func test_FetchShouldNotThrow_AndReturnSortedPrices_WhenThereIsNoErrors() async {
        let priceDto = PricesDto(
            prices: [
                [1758492000000, 1000.0],
                [1758578400000, 1001.0],
                [1758664800000, 1002.0]
            ]
        )
        let jsonDecoderMock = JSONDecoderMock(dto: priceDto, error: nil)
        let networkServiceMock = NetworkServiceMock(data: Data(), error: nil)
        
        let priceListRepository = PriceListRepository(
            networkService: networkServiceMock,
            jsonDecoder: jsonDecoderMock
        )
        do {
            let prices = try await priceListRepository.prices()
            XCTAssertEqual(prices.count, 3)
            XCTAssertEqual(prices[0].value, 1002.0)
            XCTAssertEqual(prices[1].value, 1001.0)
            XCTAssertEqual(prices[2].value, 1000.0)
            XCTAssertEqual(prices[0].utcDate, "23-09-2025")
            XCTAssertEqual(prices[1].utcDate, "22-09-2025")
            XCTAssertEqual(prices[2].utcDate, "21-09-2025")
        } catch {
            XCTFail("PriceListRepository should not throw any error when nor network service nor json decoder experienced errors.")
        }
    }
    
    func test_FetchShouldThrowNetworkServiceError_WhenThereIsAnErrorThrownByNetworking() async {
        let priceDto = PricesDto(
            prices: [
                [1758492000000, 1000.0],
                [1758578400000, 1001.0],
                [1758664800000, 1002.0]
            ]
        )
        let jsonDecoderMock = JSONDecoderMock(dto: priceDto, error: nil)
        let networkServiceMock = NetworkServiceMock(data: nil, error: NetworkServiceError.clientError)
        
        let priceListRepository = PriceListRepository(
            networkService: networkServiceMock,
            jsonDecoder: jsonDecoderMock
        )
        do {
            _ = try await priceListRepository.prices()
            XCTFail("PriceListRepository should throw .clientError error when network service throws one.")
        } catch let error as NetworkServiceError{
            XCTAssertEqual(error, .clientError)
        } catch {
            XCTFail("PriceListRepository should throw exactly .clientError error type when network service throws one.")
        }
    }
    
    func test_FetchShouldThrowJSONDecodingError_WhenThereIsAnErrorThrownByDecodingService() async {
        let error = NSError(
            domain: "Bitkoiny tests",
            code: 12345,
            userInfo: [NSLocalizedDescriptionKey: "test reason"]
        )
        let jsonDecoderMock = JSONDecoderMock(dto: nil, error: error)
        let networkServiceMock = NetworkServiceMock(data: Data(), error: nil)
        
        let priceListRepository = PriceListRepository(
            networkService: networkServiceMock,
            jsonDecoder: jsonDecoderMock
        )
        do {
            _ = try await priceListRepository.prices()
            XCTFail("PriceListRepository should throw .dataInconsistency error when decoding service throws one.")
        } catch let error as JSONDecodingError {
            XCTAssertEqual(error, .dataInconsistency("test reason"))
        } catch {
            XCTFail("PriceListRepository should throw .dataInconsistency error when decoding service throws one.")
        }
    }
}
