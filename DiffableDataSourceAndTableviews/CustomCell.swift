//
//  CustomCell.swift
//  DiffableDataSourceAndTableviews
//
//  Created by Alexander Avdacev on 15.04.22.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {

    var model: CustomCellModel?

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        var contentConfig = defaultContentConfiguration().updated(for: state)
        contentConfig.text = model?.text
        contentConfig.secondaryText = model?.secondaryText
        
        contentConfig.imageProperties.tintColor = .systemBlue
        contentConfig.image = UIImage(systemName: "circle")

        if state.isHighlighted || state.isSelected {
            contentConfig.image = UIImage(systemName: "checkmark.circle.fill")
        }
        contentConfiguration = contentConfig
    }
}
