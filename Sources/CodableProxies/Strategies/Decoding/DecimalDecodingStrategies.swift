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
    
    /// Quoted string
    static var string: DecodingStrategy {
        CodingStrategy.Decimal.string.decoding
    }
    
    /// Number
    static var number: DecodingStrategy {
        CodingStrategy.Decimal.number.decoding
    }
}
