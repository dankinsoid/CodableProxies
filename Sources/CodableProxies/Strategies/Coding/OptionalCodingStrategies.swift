import Foundation

public extension CodingStrategy {

	/// Optional coding strategies scope.
	enum Optional {}
}

public extension CodingStrategy.Optional {

	/// Encodes `nil` if value is missed.
	static var encodeNull: CodingStrategy {
		CodingStrategy(decoding: DecodingStrategy(), encoding: .Optional.null)
	}
}
