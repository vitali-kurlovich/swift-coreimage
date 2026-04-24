//
//  Image+CIImage.swift
//  swift-coreimage
//
//  Created by Vitali Kurlovich on 31.03.2026.
//

import CoreImage
import SwiftUI

public extension Image {
    init(ciImage: CIImage) {
        #if canImport(UIKit)
            let image = UIImage(ciImage: ciImage)
            self.init(uiImage: image)
        #endif

        #if canImport(AppKit)
            let rep = NSCIImageRep(ciImage: ciImage)
            let image = NSImage(size: rep.size)
            image.addRepresentation(rep)
            self.init(nsImage: image)
        #endif
    }
}

import CoreGraphics
import Playgrounds

#Playground {
    //   (MKRect<Double>(x: 0, y: 0, width: 20, height: 10), MKRect<Double>(x: 10, y: 20, width: 200, height: 200)),

    let src = CGPoint(x: 20, y: 40)
    let tr = CGAffineTransform(1, 2, 3, 4, 5, 6)

    src.applying(tr)
}
