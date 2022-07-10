//
//  GradientImageView.swift
//  MovieApp
//
//  Created by AliEren on 3.06.2022.
//

import Foundation
import UIKit

final class GradientImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let layerG = CAGradientLayer()
        layerG.frame = self.bounds
        layerG.colors = [UIColor.clear.cgColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor, Colors.lightGrey.cgColor]
        layerG.locations = [0.0, 0.5, 1.0]
        layer.insertSublayer(layerG, at: 0)
        return layerG
    }()

}
