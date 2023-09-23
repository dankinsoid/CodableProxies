import Foundation

struct AnyCodingKey: CodingKey {
    
    var stringValue: String
    var intValue: Int?
    
    init(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
    
    init(stringValue: String) {
        self.init(stringValue)
    }
    
    init(_ string: String) {
        stringValue = string
    }
    
    init(_ key: any CodingKey) {
        stringValue = key.stringValue
        intValue = key.intValue
    }
}

extension CodingKey {
    
    var any: AnyCodingKey {
        AnyCodingKey(self)
    }
}
