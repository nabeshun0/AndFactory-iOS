import Nuke
import UIKit

final class UserSearchCell: UITableViewCell {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userTypeLabel: UILabel!

    func configure(with user: SearchUserAPI.User) {
        guard let url = URL(string: user.avatarUrl) else { return }
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.35))
        Nuke.loadImage(with: url, options: options, into: thumbnailImageView)
        userNameLabel.text = user.login
        userTypeLabel.text = user.type
    }

}
