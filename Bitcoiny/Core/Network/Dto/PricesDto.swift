struct PricesDto: Decodable {
    let prices: PriceDto
}

struct PriceDto: Decodable {
    let data: [Int]
}
