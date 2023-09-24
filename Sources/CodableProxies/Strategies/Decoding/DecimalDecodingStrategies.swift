import Foundation

public extension DecodingStrategy {
    
    /// Decimal decoding strategy scope.
    enum Decimal {
    }
}

public extension DecodingStrategy.Decimal {
    
    static var `default`: DecodingStrategy {
        CodingStrategy.Decimal.default.decoding
    }
    
    /// Decimal coding strategy that tries to decode from a string if the value is not a number.
    static var tryDecodeFromString: DecodingStrategy {
        CodingStrategy.Decimal.tryDecodeFromString.decoding
    }
    
    /// Number
    static var number: DecodingStrategy {
        CodingStrategy.Decimal.number.decoding
    }
}
