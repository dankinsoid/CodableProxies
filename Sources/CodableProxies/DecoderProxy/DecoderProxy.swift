import Foundation

/// A proxy structure that wraps a decoder, offering enhanced functionality via custom decoding strategies.
///
/// `DecoderProxy` provides a standardized interface for decoding, but with the added flexibility of specifying decoding strategies.
/// This allows for modification of decoding behavior without creating entirely new decoder implementations.
///
/// - Generic Parameter `Source`: The type of the source from which values will be decoded.
public struct DecoderProxy<Source>: ValueDecoder {

	private let decoder: any ValueDecoder<Source>
	public var strategy: DecodingStrategy

	/// Initializes a new instance of `DecoderProxy` using a provided decoder and an optional decoding strategy.
	///
	/// - Parameters:
	///   - decoder: A decoder that conforms to `ValueDecoder<Source>`.
	///   - strategy: The decoding strategy to be employed. Defaults to `.default`.
	public init(_ decoder: any ValueDecoder<Source>, strategy: DecodingStrategy = .default) {
		self.decoder = decoder
		self.strategy = strategy
	}

	/// Decodes an instance of the specified type `T` from the provided source using the set strategy.
	///
	/// - Parameters:
	///   - type: The type of the value to decode.
	///   - source: The source from which to decode.
	/// - Returns: A decoded instance of type `T`.
	/// - Throws: An error if decoding fails.
	public func decode<T: Decodable>(_ type: T.Type, from source: Source) throws -> T {
		DecodingStrategy.current = strategy
		DecodingStrategy.currentIgnoring = nil
		return try decoder.decode(DecoderIntrospect<T>.self, from: source).value
	}

	/// Decodes an instance of a type inferred from context from the provided source using the set strategy.
	///
	/// - Parameter source: The source from which to decode.
	/// - Returns: A decoded instance of the inferred type.
	/// - Throws: An error if decoding fails.
	public func decode<T: Decodable>(from source: Source) throws -> T {
		try decode(T.self, from: source)
	}
}
