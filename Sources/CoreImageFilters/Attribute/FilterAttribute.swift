//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import CoreImage

public final class FilterAttribute {
    public let filter: CIFilter
    public let key: String

    init(filter: CIFilter, key: String) {
        self.filter = filter
        self.key = key
    }
}

extension FilterAttribute: Equatable {
    public static func == (lhs: FilterAttribute, rhs: FilterAttribute) -> Bool {
        lhs === rhs || lhs.key == rhs.key && lhs.filter === rhs.filter
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
    var value: Any? {
        get {
            filter.value(forKey: key)
        }

        set {
            filter.setValue(newValue, forKey: key)
        }
    }
}

extension FilterAttribute {
    private var attributes: [String: Any] { filter.attributes[key] as? [String: Any] ?? [:] }
}

private extension CIFilter {
    func attribute(for key: String) -> FilterAttribute {
        assert(attributes.keys.contains(key))
        return FilterAttribute(filter: self, key: key)
    }
}

extension CIFilter {
    var inputAttributes: [FilterAttribute] {
        inputKeys.compactMap {
            attribute(for: $0)
        }
    }

    var outputAttributes: [FilterAttribute] {
        outputKeys.compactMap {
            attribute(for: $0)
        }
    }
}
