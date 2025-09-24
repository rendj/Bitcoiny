@testable import Bitcoiny

extension Endpoint {
    static var test: Endpoint {
        Endpoint(
            method: .get,
            path: "/path/test",
            body: nil,
            headers: nil,
            query: [
                "key1": "value1",
                "key2": "value2"
            ]
        )
    }
}
