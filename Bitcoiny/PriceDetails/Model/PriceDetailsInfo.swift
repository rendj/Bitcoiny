import Foundation

struct PriceDetailsInfo: Equatable {
    struct Value: Equatable {
        let currency: Currency
        let price: Decimal
    }
    let values: [Value]
}

extension PriceDetailsInfo {
    init(from dto: PriceDetailsDto) {
        self.values = [
            Value(currency: .EUR, price: dto.marketData.currentPrice.eur),
            Value(currency: .USD, price: dto.marketData.currentPrice.usd),
            Value(currency: .GBP, price: dto.marketData.currentPrice.gbp)
        ]
    }
}

extension PriceDetailsInfo {
    static let preview = PriceDetailsInfo(
        values: [
            Value(currency: .EUR, price: 10.0),
            Value(currency: .USD, price: 11.0),
            Value(currency: .GBP, price: 12.0)
        ]
    )
}
