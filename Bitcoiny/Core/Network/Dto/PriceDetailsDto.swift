import Foundation

struct PriceDetailsDto: Decodable {
    let marketData: MarketDataDto
}

struct MarketDataDto: Decodable {
    let currentPrice: CurrentPriceDto
}

struct CurrentPriceDto: Decodable {
    let eur: Decimal
    let usd: Decimal
    let gbp: Decimal
}
