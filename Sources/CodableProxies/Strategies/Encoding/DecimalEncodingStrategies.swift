import Foundation

public extension EncodingStrategy {
    
    /// Decimal encoding strategy scope.
    enum Decimal {
    }
}

public extension EncodingStrategy.Decimal {
    
    static var `default`: EncodingStrategy {
        ValueCodingStrategy.Decimal.default.encoding
    }
    
    /// Quoted string
    static var string: EncodingStrategy {
        ValueCodingStrategy.Decimal.string.encoding
    }
    
    /// Number
    static var number: EncodingStrategy {
        ValueCodingStrategy.Decimal.number.encoding
    }
}
