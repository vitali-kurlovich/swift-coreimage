//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import Combine
import CoreImage

public class FilterInputAttribute {
    public let filter: CIFilter
    public let key: String
    public let objectWillChange = ObservableObjectPublisher()

    init(filter: CIFilter, key: String) {
        self.filter = filter
        self.key = key
    }
}

extension FilterInputAttribute: Equatable {
    public static func == (lhs: FilterInputAttribute, rhs: FilterInputAttribute) -> Bool {
        lhs === rhs || lhs.key == rhs.key && lhs.filter == rhs.filter
    }
}

public extension FilterInputAttribute {
    subscript(key: String) -> Any? {
        attributes[key]
    }
}

public extension FilterInputAttribute {
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

public extension FilterInputAttribute {
    var className: String {
        self[kCIAttributeClass] as? String ?? ""
    }
}

extension FilterInputAttribute {
    var type: FilterAttributeType {
        guard let key = self[kCIAttributeType] as? String else {
            return .custom
        }
        return FilterAttributeType(key)
    }
}

extension FilterInputAttribute: ObservableObject {}

extension FilterInputAttribute {
    var value: Any? {
        get {
            filter.value(forKey: key)
        }

        set {
            objectWillChange.send()
            filter.setValue(newValue, forKey: key)
        }
    }
}

extension FilterInputAttribute {
    private var attributes: [String: Any] { filter.attributes[key] as? [String: Any] ?? [:] }
}
