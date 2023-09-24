import Foundation

public extension DecodingStrategy {
    
    /// Key decoding strategy scope.
    enum Key {
    }
}

public extension DecodingStrategy.Key {
    
    static var `default`: DecodingStrategy = .Key.useDefaultKeys

    /// Does not change the key.
    static var useDefaultKeys: DecodingStrategy = .Key.custom { $0 }

    /// Custom key decoding strategy.
    static func custom(_ decode: @escaping (Swift.String) -> Swift.String) -> DecodingStrategy {
        DecodingStrategy(decodeKey: decode)
    }

    /// Decodes from snake_case to camelCase.
    static var convertFromSnakeCase: DecodingStrategy {
        CodingStrategy.Key.snakeCase.decoding
    }

    /// Decodes from camelCase to snake_case with a custom separator.
    static func convertFromSnakeCase(separator: Swift.String) -> DecodingStrategy {
        CodingStrategy.Key.snakeCase(separator: separator).decoding
    }
    
    /// Decodes from camelCase to snake_case .
    static var convertFromCamelCase: DecodingStrategy {
        CodingStrategy.Key.camelCase.decoding
    }
    
    /// Decodes from camelCase to snake_case with a custom separator.
    static func convertFromCamelCase(separator: Swift.String) -> DecodingStrategy {
        CodingStrategy.Key.camelCase(separator: separator).decoding
    }
}
