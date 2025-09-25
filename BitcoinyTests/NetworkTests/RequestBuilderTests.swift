import XCTest
@testable import Bitcoiny

class RequestBuilderTests: XCTestCase {
    func test_RequestURLShouldBeValid_WhenCorrectEndpointIsProvided() async {
        let requestBuilder = RequestBuilder()
        let endpoint = Endpoint.test
        
        do {
            let request = try requestBuilder.request(from: endpoint, for: "https://api.coingecko.com")
            XCTAssertNotNil(request.url, "RequestBuilder´s url should not be nil")
            XCTAssertTrue(
                [
                    "https://api.coingecko.com/path/test?key1=value1&key2=value2",
                    "https://api.coingecko.com/path/test?key2=value2&key1=value1"
                ].contains([request.url!.absoluteString])
                , "RequestBuilder should make a request with an expected url"
            )
        } catch {
            XCTFail("RequestBuilder should not throw error when endpoint and baseUrlString are valid")
        }
    }
}
