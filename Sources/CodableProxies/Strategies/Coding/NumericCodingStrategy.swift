import Foundation

public extension CodingStrategy {
    
    /// Numeric coding strategies scope.
    enum Numeric {
    }
}

public extension CodingStrategy.Numeric {
    
    /// Numeric coding strategy that tries to decode from a string if the value is not a number.
    static var tryDecodeFromString: CodingStrategy {
        CodingStrategy(
            decoding: .Numeric.tryDecodeFromString,
            encoding: EncodingStrategy()
        )
    }
    
    /// Numeric coding strategy that encodes numbers as strings and tries to decode from a quoted string if the value is not a number.
    static var string: CodingStrategy {
        CodingStrategy(
            decoding: .Numeric.tryDecodeFromString,
            encoding: .Numeric.string
        )
    }
}
