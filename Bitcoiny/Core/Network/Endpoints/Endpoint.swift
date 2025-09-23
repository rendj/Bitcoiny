import Foundation

enum HTTPMethod: String {
    case get
    case post
}

struct Endpoint {
    let method: HTTPMethod
    let path: String
    let body: Data?
    let headers: [String: String]?
    let query: [String: String]?
}
