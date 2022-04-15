//
//  CustomCellModel.swift
//  DiffableDataSourceAndTableviews
//
//  Created by Alexander Avdacev on 15.04.22.
//

import Foundation

protocol CustomCellModel {
    var text: String { get }
    var secondaryText: String? { get }
}

extension CustomCellModel {
    var secondaryText: String? { nil }
}
