//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import Combine
import CoreImage

public final class FilterDescription {
    public let filter: CIFilter

    public let inputAttributes: [FilterInputAttribute]

    private var cancelable = Set<AnyCancellable>()

    public let objectWillChange = ObservableObjectPublisher()

    public init(_ filter: CIFilter) {
        self.filter = filter

        inputAttributes = filter.inputKeys.compactMap { FilterInputAttribute(filter: filter, key: $0) }

        subscribeInputChanges()
    }

    private func subscribeInputChanges() {
        for input in inputAttributes {
            input.objectWillChange.sink { [objectWillChange] _ in
                objectWillChange.send()
            }.store(in: &cancelable)
        }
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

extension FilterDescription: ObservableObject {}
