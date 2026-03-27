//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import CoreImage

public final class FilterDescription {
    let filter: CIFilter

    public init(_ filter: CIFilter) {
        self.filter = filter
    }

    #if os(macOS)
        public var isEnabled: Bool {
            get { filter.isEnabled }
            set { filter.isEnabled = newValue }
        }

        public var className: String {
            filter.className
        }

    #endif

    public private(set) lazy var inputAttributes: [FilterAttribute] = filter.inputKeys.compactMap {
        FilterAttribute(filter: filter, key: $0)
    }

    public private(set) lazy var outputAttributes: [FilterAttribute] = filter.outputKeys.compactMap {
        FilterAttribute(filter: filter, key: $0)
    }
}

public extension FilterDescription {
    var outputImage: CIImage? { filter.outputImage }

    var attributes: [String: Any] {
        filter.attributes
    }

    var categories: FilterCategories {
        let categories = attributes[kCIAttributeFilterCategories] as? [String] ?? []

        return FilterCategories(categories)
    }
}

public extension FilterDescription {
    var name: String {
        filter.name
    }

    var displayName: String {
        attributes[kCIAttributeFilterDisplayName] as? String ?? ""
    }

    var localizedName: String {
        CIFilter.localizedName(forFilterName: name) ?? ""
    }

    var localizedDescription: String {
        CIFilter.localizedDescription(forFilterName: name) ?? ""
    }

    var localizedReferenceDocumentation: URL? {
        CIFilter.localizedReferenceDocumentation(forFilterName: name)
    }
}

extension FilterDescription: CustomStringConvertible {
    public var description: String {
        filter.description
    }
}

extension FilterDescription: CustomDebugStringConvertible {
    public var debugDescription: String {
        filter.debugDescription
    }
}

public extension FilterDescription {
    func setDefaults() {
        filter.setDefaults()
    }
}

extension FilterDescription: Equatable {
    public static func == (lhs: FilterDescription, rhs: FilterDescription) -> Bool {
        lhs === rhs || lhs.filter == rhs.filter
    }
}
