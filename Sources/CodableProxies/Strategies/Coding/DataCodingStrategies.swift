import Foundation

public extension ValueCodingStrategy {
    
    /// Data coding strategy scope.
    enum Data {
    }
}

public extension ValueCodingStrategy.Data {
    
    static var `default`: ValueCodingStrategy = .Data.base64
    
    /// Base64 string.
    static var base64: ValueCodingStrategy {
        .Data.base64()
    }
    
    /// Base64 string,.
    static func base64(
        decodingOptions: Foundation.Data.Base64DecodingOptions = [],
        encodingOptions: Foundation.Data.Base64EncodingOptions = []
    ) -> ValueCodingStrategy {
        ValueCodingStrategy(Data.self) { decoder in
            let container = try decoder.singleValueContainer()
            let base64String = try container.decode(String.self)
            guard let data = Data(base64Encoded: base64String, options: decodingOptions) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid base64 string: \(base64String)"
                )
            }
            return data
        } encode: { data, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(data.base64EncodedString(options: encodingOptions))
        }
    }
}
