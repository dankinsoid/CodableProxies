import Foundation
import os.lock

struct DecoderIntrospect<Value: Decodable>: Decodable {
    
    let value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let decoderWrapper = DecoderWrapper(
            decoder,
            strategy: .current,
            ignoreStrategy: DecodingStrategy.currentIgnoring
        )
        value = try decoderWrapper.decode(Value.self) {
            try DecoderIntrospect(Value(from: decoderWrapper))
        }
    }
}

private let atomicQueue = DispatchQueue(label: "com.global.vars")

private var _strategy: DecodingStrategy = .default
private var _ignoreStrategy: PartialKeyPath<DecodingStrategy>?

extension DecodingStrategy {
    
    static var current: DecodingStrategy {
        get {
            return atomicQueue.sync { _strategy }
        }
        set {
            atomicQueue.sync { _strategy = newValue }
        }
    }
    
    static var currentIgnoring: PartialKeyPath<DecodingStrategy>? {
        get {
            return atomicQueue.sync { _ignoreStrategy }
        }
        set {
            atomicQueue.sync { _ignoreStrategy = newValue }
        }
    }
}
