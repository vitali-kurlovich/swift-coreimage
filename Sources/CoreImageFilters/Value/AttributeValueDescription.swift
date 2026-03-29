//
//  Created by Vitali Kurlovich on 29.03.2026.
//

public enum AttributeValueDescription {
    case angle(AngleValueDescription)
    case bool(BoolValueDescription)
    case color(ColorValueDescription)
    case count(CountValueDescription)
    case distance(DistanceValueDescription)
    case image(ImageValueDescription)
    case int(IntValueDescription)
    case position(PositionValueDescription)
    case phase(PhaseValueDescription)
    case rect(RectValueDescription)
    case scalar(ScalarValueDescription)
    case transform(TransformValueDescription)
}

public extension AttributeValueDescription {
    init(_ attribute: FilterInputAttribute) {
        switch attribute.type {
        case .phase:
            self = .phase(PhaseValueDescription(attribute: attribute))
        case .scalar:
            self = .scalar(ScalarValueDescription(attribute: attribute))
        case .distance:
            self = .distance(DistanceValueDescription(attribute: attribute))
        case .angle:
            self = .angle(AngleValueDescription(attribute: attribute))
        case .boolean:
            self = .bool(BoolValueDescription(attribute: attribute))
        case .integer:
            self = .int(IntValueDescription(attribute: attribute))
        case .count:
            self = .count(CountValueDescription(attribute: attribute))
        case .position:
            self = .position(PositionValueDescription(attribute: attribute))
        case .rectangle:
            self = .rect(RectValueDescription(attribute: attribute))
        case .opaqueColor, .color:
            self = .color(ColorValueDescription(attribute: attribute))
        case .image:
            self = .image(ImageValueDescription(attribute: attribute))
        case .transform:
            self = .transform(TransformValueDescription(attribute: attribute))
        case .uncknown:
            fatalError()
        case .custom:
            fatalError()
        case .offset:
            fatalError()
        case .position3D:
            fatalError()
        case .gradient:
            fatalError()
        }
    }
}

public extension AttributeValueDescription {
    var attribute: FilterInputAttribute {
        switch self {
        case let .angle(desc):
            return desc.attribute
        case let .bool(desc):
            return desc.attribute
        case let .color(desc):
            return desc.attribute
        case let .count(desc):
            return desc.attribute
        case let .distance(desc):
            return desc.attribute
        case let .image(desc):
            return desc.attribute
        case let .int(desc):
            return desc.attribute
        case let .position(desc):
            return desc.attribute
        case let .rect(desc):
            return desc.attribute
        case let .scalar(desc):
            return desc.attribute
        case let .transform(desc):
            return desc.attribute
        case let .phase(desc):
            return desc.attribute
        }
    }
}

public extension AttributeValueDescription {
    var type: FilterAttributeType {
        attribute.type
    }

    var displayName: String {
        attribute.displayName
    }

    var localizedDescription: String {
        attribute.localizedDescription
    }
}
