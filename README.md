# CodableProxies

`CodableProxies` provides powerful encoding and decoding strategies for Swift's `Codable` types. By wrapping your encoders and decoders in `DecoderProxy` and `EncoderProxy`, you can easily apply these strategies for a more flexible and versatile encoding/decoding experience.

## Features

- 🚀 Flexible Encoding/Decoding strategies.
- 🔄 Symmetric Encoding and Decoding support through union types.
- 🐍 Convert from/to SnakeCase, CamelCase keys.
- 🔢 Custom strategies for numbers, dates, URLs, etc.
- 📦 Easily extensible.

## Usage

### Example

```swift
struct User: Codable {
    let isActive: Bool
    let birthDate: Date
    ...
}

let userJSON = """
{
    "isActive": "yes",
    "birthDate": "1990-01-01T00:00:00Z",
    ...
}
"""

let decoder = DecoderProxy(JSONDecoder(), strategy: [.default, .Bool.string, .Date.iso8601])
let user = try decoder.decode(User.self, from: userJSON.data(using: .utf8)!)
```

### Initialization

Wrap your encoders and decoders:

```swift
let encoder = EncoderProxy(JSONEncoder(), strategy: [.Bool.string, .Date.iso8601])
let decoder = DecoderProxy(JSONDecoder(), strategy: [.Bool.string, .Date.iso8601])
```

### Encoding Strategies

- **Bool**
  - `.Bool.string`: Encode booleans as "true"/"false".
  - `.Bool.string(true: String, false: String)`: Provide custom representations for booleans.

- **Data**
  - `.Data.base64(options: Data.Base64EncodingOptions)`: Encode data as Base64.

- **Date**
  - `.Date.date`: Default representation.
  - `.Date.iso8601(_ option: ISO8601DateFormatter.Options)`: ISO8601 formatted dates.
  - `.Date.formatted(_ formatter: DateFormatter)`: Custom date formats.
  - `.Date.timestamp`: Unix timestamps.
  
- **Data**
  - `.Data.base64`
  - `.Data.base64(options: Data.Base64EncodingOptions)`
  
- **Decimal** 
  - `.Decimal.string`
  - `.Decimal.number`
  
- **Key**
  - `.Key.useDefaultKeys`
  - `.Key.toSnakeCase`
  - `.Key.toSnakeCase(separator: String)`
  - `.Key.toCamelCase`
  - `.Key.toCamelCase(separator: String)`
    
- **Numbers**
  - `.Numeric.string`
    
- **Optional**
  - `.Optional.null`

- **URL**
  - `.URL.uri`

### Decoding Strategies

- **Bool**
  - `.Bool.string`: Attempt to decode booleans from a string representation.
  - `.Bool.string(_ condition: (String) -> Bool)`: Attempt to decode booleans from a string representation.

- **Data**  
  - `.Data.base64`
  - `.Data.base64(options: Foundation.Data.Base64DecodingOptions)`

- **Date** 
  - `.Date.date`
  - `.Date.iso8601`
  - `.Date.iso8601(_ options: ISO8601DateFormatter.Options)`
  - `.Date.iso8601(formats options: [ISO8601DateFormatter.Options])`
  - `.Date.formatted(_ formatter: DateFormatter)`
  - `.Date.formatted(_ format: String, locale: Locale, timeZone: TimeZone)`
  - `.Date.formatted(formats: Set<String>, locale: Locale, timeZone: TimeZone)`
  - `.Date.timestamp`

- **Decimal** 
  - `.Decimal.string`
  - `.Decimal.number`

- **Keys**
  - `.Key.fromSnakeCase`
  - `.Key.fromSnakeCase(separator: String)`
  - `.Key.fromCamelCase`
  - `.Key.fromCamelCase(separator: String)`

- **Numbers**
  - `.Numeric.string`

- **URL**
  - `.URL.uri`

### Union Types

The library offers `CodingProxy` and `CodingStrategy` that bring together both encoding and decoding for symmetrical operations.

## 📝 Combining Encoding and Decoding Strategies

When setting multiple strategies, the behavior varies between encoding and decoding:

### Encoding:
If you combine multiple encoding strategies for the same type, only the **last strategy specified** will be applied. Strategies specified earlier will be overridden.

**Example:**
Using ` [.Date.iso8601, .Date.timestamp]` for encoding will result in the date being encoded as a timestamp, as `.Date.timestamp` is the last strategy listed.

### Decoding:
For decoding, if multiple strategies are specified for the same type, all of them will be attempted in the order they are provided. Decoding will succeed if any of the strategies succeeds. If all custom strategies fail, the original strategy of the decoder will be used as a fallback.

**Example:**
With ` [.Date.iso8601, .Date.timestamp]` for decoding, the proxy will first attempt to decode the date in the ISO8601 format. If that fails, it will then try to decode it as a timestamp. If both strategies fail, the date will be decoded using the decoder's original strategy.

## ⚠️ Important Note on Custom Type Encoding/Decoding

When utilizing `CodableProxies`, it's crucial to understand that the library will **override and ignore** any custom encoding and decoding strategies set on the original encoders/decoders. This behavior particularly impacts the following types when used with `JSONEncoder`, `JSONDecoder`, `PropertyListEncoder`, and `PropertyListDecoder`:
- `Decimal`
- `URL`
- `Data`
- `Date`

To maintain consistency and avoid unexpected outcomes, always include strategies for these types in your proxy encoder/decoder. Conveniently, all these strategies are bundled within `EncoderStrategy.default` and `DecoderStrategy.default`.

## Upcoming Enhancements:

- **Diagnostic Tools**: Introduce strategies and utilities to aid in testing encoders and decoders, such as `EncodingStrategy.print`.
- **Collection Handling**: Implement strategies like `.Collection.nilIfEmpty` and `.Collection.emptyIfNil` to better manage collection states.
- **Structural Strategies**: Develop strategies that work with deep keys, allowing for nuanced modifications in object structures.
- **Enhanced Flexibility**: Further refine and expand the range of available strategies for broader use cases and adaptability.

## Installation

1. [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.
```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "SomeProject",
  dependencies: [
    .package(url: "https://github.com/dankinsoid/CodableProxies.git", from: "1.1.0")
  ],
  targets: [
    .target(name: "SomeProject", dependencies: ["CodableProxies"])
  ]
)
```
```ruby
$ swift build
```

## Author

dankinsoid, voidilov@gmail.com

## License

CodableProxies is available under the MIT license. See the LICENSE file for more info.

## Contribution

Contributions are always welcome! Please refer to our contribution guidelines.
