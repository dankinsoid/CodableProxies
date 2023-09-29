import Foundation

public extension EncodingStrategy {

	/// URL encoding strategy scope.
	enum URL {}
}

public extension EncodingStrategy.URL {

	static var `default`: EncodingStrategy {
		.URL.default
	}

	/// URI string.
	static var uri: EncodingStrategy {
		CodingStrategy.URL.uri.encoding
	}
}
