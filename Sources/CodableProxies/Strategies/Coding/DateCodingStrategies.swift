import Foundation

public extension CodingStrategy {
    
    /// Date coding strategy scope.
    enum Date {
    }
}

public extension CodingStrategy.Date {
    
    static var `default`: CodingStrategy = .Date.iso8601

    /// full-date notation as defined by RFC 3339, section 5.6, for example, 2017-07-21.
    static var date: CodingStrategy {
        .Date.custom { container in
            let date = try CodingStrategy.Date.dateFormatter.date(from: container.decode(Swift.String.self))
            guard let date else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid date format."
                )
            }
            return date
        } encode: { date, container in
            try container.encode(CodingStrategy.Date.dateFormatter.string(from: date))
        }
    }

    /// the date-time notation as defined by RFC 3339, section 5.6, for example, 2017-07-21T17:32:28Z.
    static var iso8601: CodingStrategy {
        .Date.custom { container in
            let date = try isoFormatter.date(from: container.decode(Swift.String.self))
            guard let date else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid date format. Expected ISO8601 string."
                )
            }
            return date
        } encode: { date, container in
            try container.encode(isoFormatter.string(from: date))
        }
    }

    /// the interval between the date value and 00:00:00 UTC on 1 January 1970.
    static var timestamp: CodingStrategy {
        .Date.custom { container in
            try Foundation.Date(timeIntervalSince1970: container.decode(TimeInterval.self))
        } encode: { date, container in
            try container.encode(date.timeIntervalSince1970)
        }
    }

    /// Custom date coding strategy.
    static func custom(
        decode: @escaping (SingleValueDecodingContainer) throws -> Foundation.Date,
        encode: @escaping (Foundation.Date, inout SingleValueEncodingContainer) throws -> Void
    ) -> CodingStrategy {
        CodingStrategy(Foundation.Date.self) {
            try decode($0.singleValueContainer())
        } encode: {
            var container = $1.singleValueContainer()
            try encode($0, &container)
        }
    }
}

extension CodingStrategy.Date {

    static var dateFormatter: DateFormatter {
        _dateFormatter.dateFormat = "yyyy-MM-dd"
        return _dateFormatter
    }
}

private let isoFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    return formatter
}()

private let _dateFormatter = DateFormatter()
