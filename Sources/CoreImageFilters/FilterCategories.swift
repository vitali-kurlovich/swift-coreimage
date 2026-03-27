//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import CoreImage

public struct FilterCategories: OptionSet, Hashable, Sendable {
    public var rawValue: UInt64

    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
}

public extension FilterCategories {
    init(_ name: String) {
        let categoryMap = Self.categoryMap

        guard let findCategory = categoryMap[name] else {
            assertionFailure("Unknown category: \(name)")
            self = .init(rawValue: 0)
            return
        }
        self = findCategory
    }

    init<S>(_ sequence: S) where S: Sequence, S.Element == String {
        var category = FilterCategories(rawValue: 0)

        let categoryMap = Self.categoryMap

        for categoryName in sequence {
            guard let newCategory = categoryMap[categoryName] else {
                assertionFailure("Unknown category: \(categoryName)")
                continue
            }

            category.insert(newCategory)
        }

        self = category
    }
}

public extension FilterCategories {
    var keys: [String] {
        let categoryMap = Self.categoryMap

        var names: [String] = []

        for (key, value) in categoryMap {
            if contains(value) {
                names.append(key)
            }
        }

        return names
    }
}

public extension FilterCategories {
    /// A filter that reshapes an image by altering its geometry to create a 3D effect. Using distortion filters, you can displace portions of an image, apply lens effects, make a bulge in an image, and perform other operation to achieve an artistic effect.
    static var distortionEffect: Self { .init(rawValue: 1 << 0) }

    /// A filter that changes the geometry of an image. Some of these filters are used to warp an image to achieve an artistic effects, but these filters can also be used to correct problems in the source image. For example, you can apply an affine transform to straighten an image that is rotated with respect to the horizon.
    static var geometryAdjustment: Self { .init(rawValue: 1 << 1) }
    /// A filter operates on two image sources, using the color values of one image to operate on the other. Composite filters perform computations such as computing maximum values, minimum values, and multiplying values between input images. You can use compositing filters to add effects to an image, crop an image, and achieve a variety of other effects.
    static var compositeOperation: Self { .init(rawValue: 1 << 2) }
    /// A filter that simulates a variety of halftone screens, to mimic the halftone process used in print media. The output of these filters has the familiar “newspaper” look of the various dot patterns. Filters are typically named after the pattern created by the virtual halftone screen, such as circular screen or hatched screen.
    static var halftoneEffect: Self { .init(rawValue: 1 << 3) }
    /// The category for color adjustment filters.
    ///
    /// A filter that changes color values. Color adjustment filters are used to eliminate color casts, adjust hue, and correct brightness and contrast. Color adjustment filters do not perform color management; ColorSync performs color management.
    static var colorAdjustment: Self { .init(rawValue: 1 << 4) }
    /// A filter that modifies the color of an image to achieve an artistic effect. Examples of color effect filters include filters that change a color image to a sepia image or a monochrome image or that produces such effects as posterizing.
    static var colorEffect: Self { .init(rawValue: 1 << 5) }
    /// A filter that provides a bridge between two or more images by applying a motion effect that defines how the pixels of a source image yield to that of the destination image.
    static var transition: Self { .init(rawValue: 1 << 6) }
    /// A filter that typically applies an effect to an image and then create smaller versions of the image (tiles), which are then laid out to create a pattern that’s infinite in extent.
    static var tileEffect: Self { .init(rawValue: 1 << 7) }
    static var generator: Self { .init(rawValue: 1 << 8) }
    static var reduction: Self { .init(rawValue: 1 << 9) }
    static var gradient: Self { .init(rawValue: 1 << 10) }
    static var stylize: Self { .init(rawValue: 1 << 11) }
    static var sharpen: Self { .init(rawValue: 1 << 12) }
    static var blur: Self { .init(rawValue: 1 << 13) }
    static var video: Self { .init(rawValue: 1 << 14) }
    static var stillImage: Self { .init(rawValue: 1 << 15) }
    static var interlaced: Self { .init(rawValue: 1 << 16) }
    static var nonSquarePixels: Self { .init(rawValue: 1 << 17) }
    static var highDynamicRange: Self { .init(rawValue: 1 << 18) }
    static var builtIn: Self { .init(rawValue: 1 << 19) }
    static var filterGenerator: Self { .init(rawValue: 1 << 19) }
}

extension FilterCategories {
    private static var categoryMap: [String: FilterCategories] {
        [
            kCICategoryDistortionEffect: .distortionEffect,
            kCICategoryGeometryAdjustment: .geometryAdjustment,
            kCICategoryCompositeOperation: .compositeOperation,
            kCICategoryHalftoneEffect: .halftoneEffect,
            kCICategoryColorAdjustment: .colorAdjustment,
            kCICategoryColorEffect: colorEffect,
            kCICategoryTransition: .transition,
            kCICategoryTileEffect: .tileEffect,
            kCICategoryGenerator: .generator,
            kCICategoryReduction: .reduction,
            kCICategoryGradient: .gradient,
            kCICategoryStylize: .stylize,
            kCICategorySharpen: .sharpen,
            kCICategoryBlur: .blur,
            kCICategoryVideo: .video,
            kCICategoryStillImage: .stillImage,
            kCICategoryInterlaced: .interlaced,
            kCICategoryNonSquarePixels: .nonSquarePixels,
            kCICategoryHighDynamicRange: .highDynamicRange,
            kCICategoryBuiltIn: .builtIn,
            kCICategoryFilterGenerator: .filterGenerator,
        ]
    }
}
