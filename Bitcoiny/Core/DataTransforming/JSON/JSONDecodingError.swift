import Foundation

enum JSONDecodingError: Error {
    case dataInconsistency(String)
}

extension JSONDecodingError: Equatable {}
