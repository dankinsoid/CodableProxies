import Foundation

public struct EncoderIntrospect: Encodable {
    
    let value: Encodable
    let strategy: EncodingStrategy
    
    public func encode(to encoder: Encoder) throws {
        let encoder = EncoderWrapper(encoder, strategy: strategy)
        try encoder.encode(value) { _ in
            try value.encode(to: encoder)
        }
    }
}
