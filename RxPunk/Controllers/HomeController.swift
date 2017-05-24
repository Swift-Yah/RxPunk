//
//  HomeController.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/23/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import RxDataSources
import protocol RxSwift.ImmediateSchedulerType
import class RxSwift.OperationQueueScheduler
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let beer = sender as? Beer, let controller = segue.destination as? DetailController {
            controller.set(beer: beer)
        }
    }
}

// MARK: Private functions

private extension HomeController {
    func getBackgroundWorker() -> ImmediateSchedulerType {
        let operationQueue = OperationQueue()

        operationQueue.maxConcurrentOperationCount = 2

        return OperationQueueScheduler(operationQueue: operationQueue)
    }

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
        let backgroundWorker = getBackgroundWorker()
        let api = DefaultPunkAPI(backgroundWorker: backgroundWorker,
                                 itemsPerPage: 25,
                                 reachabilityService: try! DefaultReachabilityService(),
                                 urlSession: URLSession.shared)

        let viewModel = HomeViewModel(loadNextPageTrigger: tableView.rx.nextPageTrigger, api: api)

        viewModel.result.map({ result -> [Beer] in
            switch result {
            case let .success(result):
                return result.beers
            default:
                return []
            }
        })
            .map({ [SectionModel(model: "Beers", items: $0)] })
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)


        tableView.rx.modelSelected(Beer.self).asDriver()
            .map({ StoryboardSegue.showDetail($0) })
            .drive(rx.performSegue)
            .disposed(by: rx.disposeBag)
    }
}
