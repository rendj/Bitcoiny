import Foundation

struct PriceInfo {
    let date: Date
    let value: Decimal
}

extension PriceInfo: Identifiable, Hashable {
    var id: String {
        //TODO: - check if the value is unique
        date.description
    }
}



extension PriceInfo {
    init(from dto: PriceDto) {
        self.date = .now
        self.value = 1.0
    }
}

extension PriceInfo {
    static let preview = PriceInfo(
        date: .now,
        value: 10000.99999
    )
}
