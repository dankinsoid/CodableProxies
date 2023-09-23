import Foundation

public extension ValueCodingStrategy {
    
    /// URL encoding strategy scope.
    enum URL {
    }
}

public extension ValueCodingStrategy.URL {
    
    static var `default`: ValueCodingStrategy = .URL.uri
    
    /// URI string.
    static var uri: ValueCodingStrategy {
        ValueCodingStrategy(URL.self) { decoder in
            let container = try decoder.singleValueContainer()
            let urlString = try container.decode(String.self)
            guard let url = URL(string: urlString) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid url string: \(urlString)"
                )
            }
            return url
        } encode: { url, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(url.absoluteString)
        }
    }
}
