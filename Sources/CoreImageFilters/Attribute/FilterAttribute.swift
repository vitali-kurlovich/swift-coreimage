//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import CoreImage

public class FilterAttribute {
    public let filter: CIFilter
    public let key: String

    init(filter: CIFilter, key: String) {
        self.filter = filter
        self.key = key
    }
}

extension FilterAttribute: Equatable {
    public static func == (lhs: FilterAttribute, rhs: FilterAttribute) -> Bool {
        lhs === rhs || lhs.key == rhs.key && lhs.filter == rhs.filter
    }
}

public extension FilterAttribute {
    subscript(key: String) -> Any? {
        attributes[key]
    }
}

public extension FilterAttribute {
    var name: String {
        self[kCIAttributeName] as? String ?? ""
    }

    var displayName: String {
        self[kCIAttributeDisplayName] as? String ?? ""
    }

    var localizedDescription: String {
        self[kCIAttributeDescription] as? String ?? ""
    }
}

public extension FilterAttribute {
    var className: String {
        self[kCIAttributeClass] as? String ?? ""
    }
}

extension FilterAttribute {
    var type: FilterAttributeType {
        guard let key = self[kCIAttributeType] as? String else {
            return .custom
        }
        return FilterAttributeType(key)
    }
}

extension FilterAttribute {
    private var attributes: [String: Any] { filter.attributes[key] as? [String: Any] ?? [:] }
}
