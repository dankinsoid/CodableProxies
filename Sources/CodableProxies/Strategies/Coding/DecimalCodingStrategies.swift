import Foundation

public extension CodingStrategy {
    
    /// Decimal coding strategy scope.
    enum Decimal {
    }
}

public extension CodingStrategy.Decimal {
    
    static var `default`: CodingStrategy = .Decimal.number
    
    /// Quoted string
    static var string: CodingStrategy {
        CodingStrategy(Decimal.self) {
            let container = try $0.singleValueContainer()
            let string = try container.decode(String.self)
            guard let decimal = Decimal(string: string) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid decimal string: \(string)"
                )
            }
            return decimal
        } encode: { decimal, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(decimal.description)
        }
    }
    
    /// Number
    static var number: CodingStrategy {
        CodingStrategy(Decimal.self) {
            let container = try $0.singleValueContainer()
            let number = try container.decode(Double.self)
            return Decimal(number)
        } encode: { decimal, encoder in
            var container = encoder.singleValueContainer()
            try container.encode((decimal as NSDecimalNumber).doubleValue)
        }
    }
}
