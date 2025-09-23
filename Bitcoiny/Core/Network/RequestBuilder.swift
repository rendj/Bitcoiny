import Foundation

protocol RequestBuilderProtocol {
    func request(from endpoint: Endpoint, for baseUrlString: String) throws -> URLRequest
}

struct RequestBuilder: RequestBuilderProtocol {
    func request(from endpoint: Endpoint, for baseUrlString: String) throws -> URLRequest {
        var urlComponents = URLComponents(string: baseUrlString)
        urlComponents?.path = endpoint.path
        if let query = endpoint.query {
            urlComponents?.queryItems = query.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = urlComponents?.url else {
            throw NetworkServiceError.malformedRequestUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        if let headers = endpoint.headers {
            headers.forEach {
                urlRequest.addValue($1, forHTTPHeaderField: $0)
            }
        }
        
        return urlRequest
    }
}


