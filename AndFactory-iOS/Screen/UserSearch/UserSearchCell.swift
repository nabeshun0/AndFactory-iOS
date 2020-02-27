import Nuke
import UIKit

class UserSearchCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!

    public func configure() {
        thumbnailImageView.image = #imageLiteral(resourceName: "snt-nbzw_icon")
        userNameLabel.text = "snt-nbzw"
        userTypeLabel.text = "User"
    }

}
