import XCTest
@testable import Bitcoiny

class PriceListViewModelTests: XCTestCase {
    @MainActor
    func test_StateShouldBeSetToLoading_WhenOnAppearEventWasJustReceived() async {
        let priceListRepositoryMock = PriceListRepositoryMock(
            prices: [.preview],
            error: nil
        )
        let realtimePriceRepositoryMock = RealtimePriceRepositoryMock(price: nil)
        let viewModel = PriceListViewModel(
            priceListRepository: priceListRepositoryMock,
            realtimePriceRepository: realtimePriceRepositoryMock
        )
        
        viewModel.sendEvent(.onAppear)
        
        XCTAssertEqual(viewModel.state, .loading)
    }
    
    @MainActor
    func test_StateShouldBeSetToLoadedAndRealtimeUpdatesShouldStart_WhenPricesWereLoadedSuccessfully() async {
        let priceListRepositoryMock = PriceListRepositoryMock(
            prices: [.preview],
            error: nil
        )
        let realtimePriceRepositoryMock = RealtimePriceRepositoryMock(price: nil)
        let viewModel = PriceListViewModel(
            priceListRepository: priceListRepositoryMock,
            realtimePriceRepository: realtimePriceRepositoryMock
        )
        
        viewModel.sendEvent(.onAppear)
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(viewModel.state, .loaded([.preview]))
        XCTAssertEqual(realtimePriceRepositoryMock.startWasCalled, true)
    }
    
    @MainActor
    func test_StateShouldBeSetToNoPrices_WhenNoPricesWereLoaded() async {
        let priceListRepositoryMock = PriceListRepositoryMock(
            prices: [],
            error: nil
        )
        let realtimePriceRepositoryMock = RealtimePriceRepositoryMock(price: nil)
        let viewModel = PriceListViewModel(
            priceListRepository: priceListRepositoryMock,
            realtimePriceRepository: realtimePriceRepositoryMock
        )
        
        viewModel.sendEvent(.onAppear)
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(viewModel.state, .noPrices)
    }
    
    @MainActor
    func test_RealtimeUpdatesShouldStop_WhenOnDisappearEventReceived() async {
        let priceListRepositoryMock = PriceListRepositoryMock(
            prices: [.preview],
            error: nil
        )
        let realtimePriceRepositoryMock = RealtimePriceRepositoryMock(price: nil)
        let viewModel = PriceListViewModel(
            priceListRepository: priceListRepositoryMock,
            realtimePriceRepository: realtimePriceRepositoryMock
        )
        
        viewModel.sendEvent(.onDisappear)
        
        XCTAssertEqual(realtimePriceRepositoryMock.stopWasCalled, true)
    }
    
    @MainActor
    func test_StateShouldBeSetToError_WhenThereIsAnErrorDuringPricesLoading() async {
        let priceListRepositoryMock = PriceListRepositoryMock(
            prices: nil,
            error: NetworkServiceError.backendError
        )
        let realtimePriceRepositoryMock = RealtimePriceRepositoryMock(price: nil)
        let viewModel = PriceListViewModel(
            priceListRepository: priceListRepositoryMock,
            realtimePriceRepository: realtimePriceRepositoryMock
        )
        
        viewModel.sendEvent(.onAppear)
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(viewModel.state, .error)
    }
}
