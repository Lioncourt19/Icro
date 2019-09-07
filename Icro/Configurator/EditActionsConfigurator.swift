//
//  Created by martin on 02.04.18.
//  Copyright © 2018 Martin Hartl. All rights reserved.
//

import UIKit
import IcroKit
import IcroUIKit

final class EditActionsConfigurator {
    private let itemNavigator: ItemNavigatorProtocol
    private let viewModel: ListViewModel

    init(itemNavigator: ItemNavigatorProtocol,
         viewModel: ListViewModel) {
        self.itemNavigator = itemNavigator
        self.viewModel = viewModel
    }

    func contextMenu(tableView: UITableView, indexPath: IndexPath) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: { _ in
            return self.makeContextMenu(tableView: tableView, indexPath: indexPath)
        })
    }

    // MARK: - Private

    private func makeContextMenu(tableView: UITableView, indexPath: IndexPath) -> UIMenu {
        guard case .item(let item) = viewModel.viewType(forRow: indexPath.row),
            let cell = tableView.cellForRow(at: indexPath) else {
            return UIMenu(title: "", image: nil, identifier: nil, children: [])
        }

        let reply = UIAction(__title: NSLocalizedString("EDITACTIONSCONFIGURATOR_SHAREACTION", comment: ""),
                             image: UIImage(symbol: Symbol.square_and_arrow_up),
                             identifier: nil) { [weak self] _ in
                                self?.itemNavigator.share(item: item, sourceView: cell)
        }

        let chat = UIAction(__title: NSLocalizedString("EDITACTIONSCONFIGURATOR_LEADINGEDITACTIONS", comment: ""),
                             image: UIImage(symbol: Symbol.arrowshape_turn_up_left),
                             identifier: nil) { [weak self] _ in
                                self?.itemNavigator.openReply(item: item)
        }

        let favoriteTitle = item.isFavorite ?
            NSLocalizedString("EDITACTIONSCONFIGURATOR_FAVORITEACTION_UNFAVORITE", comment: "") :
            NSLocalizedString("EDITACTIONSCONFIGURATOR_FAVORITEACTION_FAVORITE", comment: "")
        let favoriteImage = item.isFavorite ? UIImage(symbol: Symbol.heart_fill) : UIImage(symbol: Symbol.heart)
        let favorite = UIAction(__title: favoriteTitle,
                             image: favoriteImage,
                             identifier: nil) { [weak self] _ in
                                self?.viewModel.toggleFave(for: item)
        }

        return UIMenu(title: "Main Menu",
                      image: nil,
                      identifier: nil,
                      children: [reply, chat, favorite])
    }
}
