//
//  LoadingTableViewCell.swift
//  SegmentControlandLoadindDataShimmerEffect
//
//  Created by Janarthan Subburaj on 05/01/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var ActivityIndicateLoading: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
