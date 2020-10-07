//
//  InfoTableViewCell.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import UIKit
import PureLayout
import SDWebImage

class InfoTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  #colorLiteral(red: 0.2347450852, green: 0.2347450852, blue: 0.2347450852, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor =  #colorLiteral(red: 0.6661632061, green: 0.6661632061, blue: 0.6661632061, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(infoImageView)
        titleLabel.configureForAutoLayout()
        descriptionLabel.configureForAutoLayout()
        separatorView.configureForAutoLayout()
        infoImageView.configureForAutoLayout()
        
        infoImageView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 15)
        infoImageView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 15)
        infoImageView.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -15)

        separatorView.autoPinEdge(.leading, to: .leading, of: contentView)
        separatorView.autoPinEdge(.trailing, to: .trailing, of: contentView)
        separatorView.autoPinEdge(.bottom, to: .bottom, of: contentView)
        separatorView.autoSetDimension(.height, toSize: 1)
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: infoImageView, withOffset: 15)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10)
        descriptionLabel.autoPinEdge(.bottom, to: .top, of: separatorView, withOffset: -15)
        titleLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 15)
        descriptionLabel.autoPinEdge(.leading, to: .leading, of: titleLabel, withOffset: 0)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -15)
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        infoImageView.image = nil
    }
    
    func configureCell(title: String?, message: String?) {
        self.titleLabel.text = title
        self.descriptionLabel.text = message
    }
    
    func setImage(imageString: String?) {
        if let imageString = imageString, let url = URL(string: imageString) {
            infoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
