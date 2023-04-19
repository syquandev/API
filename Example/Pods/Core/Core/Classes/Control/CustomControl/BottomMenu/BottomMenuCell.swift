//
//  BottomMenuCell.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//

import UIKit

class BottomMenuCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconHolder: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var selectHolder: UIView!
    @IBOutlet weak var selectView: UIImageView!
    
    @IBOutlet weak var iconWidthCst: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: BottomMenuItem){
        iconHolder.isHidden = data.image == nil
        iconView.image = data.image
        if let selected = data.selected {
            selectView.image = selected ? data.selectedImage : data.unselectedImage
            selectHolder.isHidden = false
        }else{
            selectHolder.isHidden = true
        }
        
        if let title = data.title{
            titleLabel.text = title
        }
        
        if let title = data.attTitle{
            titleLabel.attributedText = title
        }
        iconWidthCst.constant = data.imageWidth
        
    }
}
