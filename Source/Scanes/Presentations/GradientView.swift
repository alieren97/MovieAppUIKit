//
//  GradientView.swift
//  MovieApp
//
//  Created by AliEren on 29.06.2022.
//

import Foundation
import UIKit

final class GradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let layerG = CAGradientLayer()
        layerG.frame = self.bounds
        layerG.colors = [Colors.lightGrey.cgColor, Colors.lightGrey.cgColor]
        layerG.startPoint = CGPoint(x: 0, y: 0.5)
        layerG.endPoint = CGPoint(x: 1, y: 0.5)
        layerG.cornerRadius = 12
        layer.insertSublayer(layerG, at: 0)
        return layerG
    }()
}
