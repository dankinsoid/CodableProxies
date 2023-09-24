import Foundation

public extension DecodingStrategy {
    
    /// Bool decoding strategy scope.
    enum Bool {
    }
}

public extension DecodingStrategy.Bool {
    
    /// Decodes booleans from strings if the value is not a boolean.
    static var tryDecodeFromString: DecodingStrategy {
        .Bool.tryDecodeFromString {
            defaultTrueString.contains($0.lowercased())
        }
    }
    
    /// Decodes booleans from strings if the value is not a boolean.
    static func tryDecodeFromString(_ condition: @escaping (Swift.String) -> Swift.Bool) -> DecodingStrategy {
        DecodingStrategy(
            decodeBool: {
                let container = try $0.singleValueContainer()
                let string: Swift.String
                do {
                    string = try container.decode(Swift.String.self)
                } catch {
                    return try container.decode(Swift.Bool.self)
                }
                return condition(string)
            }
        )
    }
}

private extension DecodingStrategy.Bool {
    
    static let defaultTrueString: Set<Swift.String> = ["true", "yes", "1"]
}
