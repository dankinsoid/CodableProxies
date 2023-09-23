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
    static func custom(_ encode: @escaping (String) -> String) -> EncodingStrategy {
        EncodingStrategy(encodeKey: encode)
    }

    /// Encodes from camelCase to snake_case.
    static var convertToSnakeCase: EncodingStrategy {
        .Key.convertToSnakeCase(separator: "_")
    }

    /// Encodes from camelCase to snake_case with a custom separator.
    static func convertToSnakeCase(separator: String) -> EncodingStrategy {
        .Key.custom {
            $0.toSnakeCase(separator: separator)
        }
    }
}

private extension String {
    
    func toSnakeCase(separator: String = "_") -> String {
        var result = ""

        for character in self {
            if character.isUppercase {
                result += separator + character.lowercased()
            } else {
                result += String(character)
            }
        }

        return result
    }
}
