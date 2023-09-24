import Foundation

public extension EncodingStrategy {
    
    /// Key encoding strategy scope.
    enum Key {
    }
}

public extension EncodingStrategy.Key {
    
    static var `default`: EncodingStrategy = .Key.useDefaultKeys

    /// Does not change the key.
    static var useDefaultKeys: EncodingStrategy = .Key.custom { $0 }

    /// Custom key encoding strategy.
    static func custom(_ encode: @escaping (Swift.String) -> Swift.String) -> EncodingStrategy {
        EncodingStrategy(encodeKey: encode)
    }

    /// Encodes from camelCase to snake_case.
    static var convertToSnakeCase: EncodingStrategy {
        CodingStrategy.Key.camelCase.encoding
    }

    /// Encodes from camelCase to snake_case with a custom separator.
    static func convertToSnakeCase(separator: Swift.String) -> EncodingStrategy {
        CodingStrategy.Key.camelCase(separator: separator).encoding
    }
    
    /// Encodes from snake_case to camelCase.
    static var convertToCamelCase: EncodingStrategy {
        CodingStrategy.Key.snakeCase.encoding
    }
    
    /// Encodes from snake_case to camelCase with a custom separator.
    static func convertToCamelCase(separator: Swift.String) -> EncodingStrategy {
        CodingStrategy.Key.snakeCase(separator: separator).encoding
    }
}
