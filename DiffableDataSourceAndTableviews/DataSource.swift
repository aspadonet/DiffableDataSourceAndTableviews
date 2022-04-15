//
//  DataSource.swift
//  DiffableDataSourceAndTableviews
//
//  Created by Alexander Avdacev on 15.04.22.
//

import Foundation
import UIKit

final class DataSource: UITableViewDiffableDataSource<Section, SectionItem> {
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.reuse(CustomCell.self, indexPath)
            cell.selectionStyle = .none
            switch itemIdentifier {
            case .number(let model):
                cell.model = model
            case .letter(let model):
                cell.model = model
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let id = sectionIdentifier(for: section)
        switch id {
        case .numbers:
            return "Pick a number"
        case .letters:
            return "Pick some letters"
        default:
            return nil
        }
    }

    func reload(_ data: [SectionData], animated: Bool = true) {
        var snapshot = snapshot()
        snapshot.deleteAllItems()
        for item in data {
            snapshot.appendSections([item.key])
            snapshot.appendItems(item.values, toSection: item.key)
        }
        apply(snapshot, animatingDifferences: animated)
    }
}
extension UITableViewDiffableDataSource {

    func selectedIndexPaths<T: Hashable>(_ selection: SelectionOptions<T>,
                                         _ transform: (T) -> ItemIdentifierType) ->  [IndexPath] {
        selection.values
            .filter { selection.selectedValues.contains($0) }
            .map { transform($0) }
            .compactMap { indexPath(for: $0) }
    }
}
