extension Endpoint {
    static func details(for price: Price) -> Endpoint {
        Endpoint(
            method: .get,
            path: "/api/v3/coins/bitcoin/history",
            body: nil,
            headers: nil,
            query: [
                "localization": "false",
                "date": price.utcDate
            ]
        )
    }
}
