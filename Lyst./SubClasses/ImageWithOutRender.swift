//
//  ImageWithOutRender.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/20/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class ImageWithoutRender: UIImage {
    override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage {
        return self
    }
}
