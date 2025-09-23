import Foundation

extension DateFormatter {
    static let medium: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = .current
        return dateFormatter
    }()
}
