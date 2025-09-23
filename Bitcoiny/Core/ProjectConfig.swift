import Foundation

protocol ProjectConfigProtocol {
    var baseUrlString: String { get }
}

struct ProjectConfig: ProjectConfigProtocol {
    let baseUrlString = "https://api.coingecko.com"
}
