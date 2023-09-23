import Foundation

public extension ValueCodingStrategy {
    
    /// Decimal coding strategy scope.
    enum Decimal {
    }
}

public extension ValueCodingStrategy.Decimal {
    
    static var `default`: ValueCodingStrategy = .Decimal.number
    
    /// Quoted string
    static var string: ValueCodingStrategy {
        ValueCodingStrategy(Decimal.self) {
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
    static var number: ValueCodingStrategy {
        ValueCodingStrategy(Decimal.self) {
            let container = try $0.singleValueContainer()
            let number = try container.decode(Double.self)
            return Decimal(number)
        } encode: { decimal, encoder in
            var container = encoder.singleValueContainer()
            try container.encode((decimal as NSDecimalNumber).doubleValue)
        }
    }
}
