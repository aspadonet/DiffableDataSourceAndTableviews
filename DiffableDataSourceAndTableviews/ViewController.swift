//
//  ViewController.swift
//  DiffableDataSourceAndTableviews
//
//  Created by Alexander Avdacev on 15.04.22.
//

import UIKit

class ViewController: UIViewController {

    var singleOptions = SelectionOptions<NumberOption>(NumberOption.allCases, selected: [.two])
        var multipleOptions = SelectionOptions<LetterOption>(LetterOption.allCases, selected: [.a, .c], multiple: true)

    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        //tableView.register(FotoTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        //tableView.style = .plain
        return tableView
    }()
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraint()
        view.backgroundColor = .white
     //   tableView.delegate = self
     //   tableView.dataSource = self
        title = "Table view"
        //navigationController?.navigationBar.prefersLargeTitles = true
        //self.tableView = TableView(style: .insetGrouped)
        self.dataSource = DataSource(tableView)
        tableView.register(CustomCell.self)
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = CGRect(x: 0, y: 160, width: view.bounds.size.width , height: view.bounds.size.height)
    }
    
    func addConstraint(){
        view.addSubview(tableView)
       
        
        NSLayoutConstraint.activate([

        ])
    }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            reload()
        }
        
        func reload() {
            dataSource.reload([
                        .init(key: .numbers, values: NumberOption.allCases.map { .number($0) }),
                        .init(key: .letters, values: LetterOption.allCases.map { .letter($0) }),
                    ])
            tableView.select(dataSource.selectedIndexPaths(singleOptions) { .number($0) })
                    tableView.select(dataSource.selectedIndexPaths(multipleOptions) { .letter($0) })
               
        }

    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionId = dataSource.sectionIdentifier(for: indexPath.section) else {
            return
        }

        switch sectionId {
        case .numbers:
            guard case let .number(model) = dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            tableView.deselectAllInSection(except: indexPath)
            singleOptions.toggle(model)
            print(singleOptions.selectedValues)
            
        case .letters:
            guard case let .letter(model) = dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            multipleOptions.toggle(model)
            print(multipleOptions.selectedValues)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let sectionId = dataSource.sectionIdentifier(for: indexPath.section) else {
            return
        }
        switch sectionId {
        case .numbers:
            tableView.select([indexPath])
        case .letters:
            guard case let .letter(model) = dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            multipleOptions.toggle(model)
            print(multipleOptions.selectedValues)
        }
    }
}
