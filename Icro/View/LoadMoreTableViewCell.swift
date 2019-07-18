//
//  Created by martin on 04.11.18.
//  Copyright © 2018 Martin Hartl. All rights reserved.
//

import UIKit
import IcroKit
import Dequeueable

final class LoadMoreTableViewCell: UITableViewCell, NibReusable {
    var didPressLoadMore: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        applyAppearance()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        applyAppearance()
    }

    private func applyAppearance() {
        backgroundColor = Color.backgroundColor
    }

    @IBAction private func loadMorePressed(_ sender: Any) {
        didPressLoadMore?()
    }
}
