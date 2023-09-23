import Foundation

public extension EncodingStrategy {
    
    /// URL encoding strategy scope.
    enum URL {
    }
}

public extension EncodingStrategy.URL {
    
    static var `default`: EncodingStrategy {
        ValueCodingStrategy.URL.default.encoding
    }
    
    /// URI string.
    static var uri: EncodingStrategy {
        ValueCodingStrategy.URL.uri.encoding
    }
}
