//
//  HomeController.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/23/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import RxDataSources
import class UIKit.UITableView
import class UIKit.UIViewController

final class HomeController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    // MARK: Rx

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Beer>>()
}

// MARK: UIViewController functions

extension HomeController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        setupRx()
    }
}

// MARK: Private functions

private extension HomeController {
    func setupDataSource() {
        dataSource.configureCell = { (_, tableView, indexPath, beer) in
            let id = String(describing: BeerCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! BeerCell

            cell.setup(beer: beer)

            return cell
        }

        dataSource.titleForHeaderInSection = { dataSource, indexPath in
            let count = dataSource.sectionModels[indexPath].items.count
            let hasItems = count > 0

            return hasItems ? "Beers (\(count))" : "No beers found"
        }
    }

    func setupRx() {
        let viewModel = HomeViewModel()

        viewModel.beers!.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)


        tableView.rx.modelSelected(Beer.self).asDriver()
            .map({ _ in StoryboardSegue.showDetail })
            .drive(rx.performSegue)
            .disposed(by: rx.disposeBag)
    }
}
