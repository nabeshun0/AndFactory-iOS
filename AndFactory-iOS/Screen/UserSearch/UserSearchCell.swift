import Nuke
import UIKit

class UserSearchCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!

    public func configure(with user: SearchUserAPI.User) {
        guard let url = URL(string: user.avatarUrl) else { return }
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.35))
        Nuke.loadImage(with: url, options: options, into: thumbnailImageView)
        userNameLabel.text = user.login
        userTypeLabel.text = user.type
    }

}
