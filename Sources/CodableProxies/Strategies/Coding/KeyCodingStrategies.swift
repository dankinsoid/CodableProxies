import Foundation

public extension CodingStrategy {
    
    /// Key coding strategy scope.
    enum Key {
    }
}

public extension CodingStrategy.Key {
    
    static var `default`: CodingStrategy = .Key.useDefaultKeys
    
    /// Does not change the key.
    static var useDefaultKeys: CodingStrategy {
        .Key.custom { $0 } encode: { $0 }
    }
    
    /// Custom key coding strategy.
    static func custom(
        decode: @escaping (String) -> String,
        encode: @escaping (String) -> String
    ) -> CodingStrategy {
        CodingStrategy(
            decoding: .Key.custom(decode),
            encoding: .Key.custom(encode)
        )
    }
    
    /// Encodes from camelCase to snake_case.
    static var snakeCase: CodingStrategy {
        .Key.snakeCase(separator: "_")
    }
    
    /// Encodes from camelCase to snake_case with a custom separator.
    static func snakeCase(separator: String) -> CodingStrategy {
        .Key.custom {
            $0.fromSnakeCase(separator: CharacterSet(charactersIn: separator))
        } encode: {
            $0.toSnakeCase(separator: separator)
        }
    }
    
    
    /// Encodes from snake_case to camelCase.
    static var camelCase: CodingStrategy {
        .Key.camelCase(separator: "_")
    }
    
    /// Encodes from snake_case to camelCase with a custom separator.
    static func camelCase(separator: String) -> CodingStrategy {
        .Key.custom {
            $0.toSnakeCase(separator: separator)
        } encode: {
            $0.fromSnakeCase(separator: CharacterSet(charactersIn: separator))
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
    
    func fromSnakeCase(separator: CharacterSet = ["_", "-"]) -> String {
        guard !isEmpty else { return self }
        let components = self.components(separatedBy: separator)
        guard components.count > 1 else { return self }
        let joined = components.enumerated().reduce("") { result, current in
            result + (current.offset == 0 ? current.element : current.element.capitalized)
        }
        return joined
    }
}
