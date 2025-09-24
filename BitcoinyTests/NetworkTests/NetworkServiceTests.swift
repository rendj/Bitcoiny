import XCTest
@testable import Bitcoiny

class NetworkServiceTests: XCTestCase {
    func test_FetchShouldNotThrow_WhenHTTPStatusCodeIs200() async {
        let projectConfigMock = ProjectConfigMock()
        let transportMock = TransportMock(statusCode: 200)
        let networkService = NetworkService(
            config: projectConfigMock,
            transport:  transportMock
        )
        do {
            _ = try await networkService.fetch(.test)
            XCTAssert(true)
        } catch {
            XCTFail("NetworkService should not throw error when HTTP status code is 200")
        }
    }
    
    func test_FetchShouldThrowClientError_WhenHTTPStatusCodeIs400() async {
        let projectConfigMock = ProjectConfigMock()
        let transportMock = TransportMock(statusCode: 400)
        let networkService = NetworkService(
            config: projectConfigMock,
            transport:  transportMock
        )
        do {
            _ = try await networkService.fetch(.test)
            XCTFail("NetworkService should throw an error when HTTP status code is 400")
        } catch let error as NetworkServiceError {
            switch error {
            case .clientError:
                XCTAssertTrue(true)
            default:
                XCTFail("NetworkService should throw a .clientError when HTTP status code is 400")
            }
        } catch {
            XCTFail("NetworkService should throw NetworkServiceError type")
        }
    }
    
    func test_FetchShouldThrowBackendError_WhenHTTPStatusCodeIs500() async {
        let projectConfigMock = ProjectConfigMock()
        let transportMock = TransportMock(statusCode: 500)
        let networkService = NetworkService(
            config: projectConfigMock,
            transport:  transportMock
        )
        do {
            _ = try await networkService.fetch(.test)
            XCTFail("NetworkService should throw an error when HTTP status code is 500")
        } catch let error as NetworkServiceError {
            switch error {
            case .backendError:
                XCTAssertTrue(true)
            default:
                XCTFail("NetworkService should throw a .backendError when HTTP status code is 500")
            }
        } catch {
            XCTFail("NetworkService should throw NetworkServiceError type")
        }
    }
    
    func test_FetchShouldThrowUnknownError_WhenHTTPStatusCodeIsNotKnown() async {
        let projectConfigMock = ProjectConfigMock()
        let transportMock = TransportMock(statusCode: 9999)
        let networkService = NetworkService(
            config: projectConfigMock,
            transport:  transportMock
        )
        do {
            _ = try await networkService.fetch(.test)
            XCTFail("NetworkService should throw an error when HTTP status code is 600")
        } catch let error as NetworkServiceError {
            switch error {
            case .unknownError:
                XCTAssertTrue(true)
            default:
                XCTFail("NetworkService should throw an .unknownError when HTTP status code is 600")
            }
        } catch {
            XCTFail("NetworkService should throw NetworkServiceError type")
        }
    }
}
