//
//  Created by Vitali Kurlovich on 29.03.2026.
//

import class CoreML.MLModel
import Foundation

public enum AttributeValueDescription {
    case angle(AngleValueDescription)
    case bool(BoolValueDescription)
    case color(ColorValueDescription)

    case colorSpace(ColorSpaceValueDescription)

    case count(CountValueDescription)
    case distance(DistanceValueDescription)
    case image(ImageValueDescription)
    case int(IntValueDescription)
    case position(PositionValueDescription)
    case offset(OffsetValueDescription)
    case phase(PhaseValueDescription)
    case rect(RectValueDescription)
    case scalar(ScalarValueDescription)
    case transform(TransformValueDescription)
    case string(StringValueDescription)
    case data(DataValueDescription)
    case mlModel(MLModelValueDescription)
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
        case .offset:
            self = .offset(OffsetValueDescription(attribute: attribute))
        case .rectangle:
            self = .rect(RectValueDescription(attribute: attribute))
        case .opaqueColor, .color:
            self = .color(ColorValueDescription(attribute: attribute))
        case .image:
            self = .image(ImageValueDescription(attribute: attribute))
        case .transform:
            self = .transform(TransformValueDescription(attribute: attribute))
        case .custom:
            switch attribute.className {
            case NSObject.className() where attribute.key == "inputColorSpace":
                self = .colorSpace(ColorSpaceValueDescription(attribute: attribute))

            case NSData.className():
                self = .data(DataValueDescription(attribute: attribute))

            case NSString.className():
                self = .string(StringValueDescription(attribute: attribute))

            case MLModel.className():
                self = .mlModel(MLModelValueDescription(attribute: attribute))

            default:
                fatalError("Unsuported type:\(attribute.className)")
            }
        case .position3D:
            fatalError()
        case .gradient:
            fatalError()
        case .uncknown:
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
        case let .offset(desc):
            return desc.attribute
        case let .rect(desc):
            return desc.attribute
        case let .scalar(desc):
            return desc.attribute
        case let .transform(desc):
            return desc.attribute
        case let .phase(desc):
            return desc.attribute
        case let .string(desc):
            return desc.attribute
        case let .data(desc):
            return desc.attribute
        case let .mlModel(desc):
            return desc.attribute
        case let .colorSpace(desc):
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
