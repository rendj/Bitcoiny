import Foundation

struct Price {
    let date: Date
    let value: Decimal
}

extension Price: Identifiable, Hashable {
    var id: String {
        date.description
    }
}

extension Price {
    init(from values: [Decimal]) {
        let doubleTimeInterval = ((values.first ?? 0.0) as NSDecimalNumber).doubleValue / 1000
        self.date = Date(timeIntervalSince1970: doubleTimeInterval)
        self.value = values.last ?? 0.0
   }
    
    var displayDate: String {
        DateFormatter.medium.string(from: date)
    }
}

extension Price {
    static let preview = Price(
        date: .now,
        value: 10000.99999
    )
}
