//
//  SiteCell.swift
//  iOSBootleggersFinalProject
//
//  Created by  Harpreet Ghumsn on 4/17/21.
//

import UIKit

class SiteCell: UITableViewCell {
    
    // types of variable being used
    let primaryLabel = UILabel()
    let myImageView = UIImageView()
    
    //function to set the formattng of the label
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 20)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        //inserts the label and the image to the table
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(myImageView)
    }
    //sets the layout of the image and its juxtaposition to the item name
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 100, y: 5, width: 460, height: 30)
        myImageView.frame = CGRect(x: 5, y: 5, width: 45, height: 45)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
