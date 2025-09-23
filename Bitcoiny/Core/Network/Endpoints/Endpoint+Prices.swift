extension Endpoint {
    static var prices: Endpoint {
        Endpoint(
            method: .get,
            path: "/api/v3/coins/bitcoin/market_chart",
            body: nil,
            headers: nil,
            query: [
                "vs_currency": "eur",
                "interval": "daily",
                "days": "14"
            ]
        )
    }
}
