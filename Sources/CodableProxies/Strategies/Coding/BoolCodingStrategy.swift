import Foundation

public extension CodingStrategy {
    
    /// Bool coding strategy scope.
    enum Bool {
    }
}

public extension CodingStrategy.Bool {
    
    /// Decodes booleans from strings if the value is not a boolean.
    static var tryDecodeFromString: CodingStrategy {
        CodingStrategy(decoding: .Bool.tryDecodeFromString, encoding: EncodingStrategy())
    }
    
    /// Encodes booleans as strings and decodes booleans from strings if the value is not a boolean.
    static var string: CodingStrategy {
        CodingStrategy(decoding: .Bool.tryDecodeFromString, encoding: .Bool.string)
    }
}
