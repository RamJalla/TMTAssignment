//
//  NewsFeedTableViewCell.swift
//  RedditClient
//
//  Created by Ram Jalla on 09/10/20.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var thumbImageView: UIImageView!
    var commentLabel: UILabel!
    var scoreLabel: UILabel!
    var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    fileprivate func setupViews() {
        //name label
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        //thumb image view
        thumbImageView = UIImageView()
        thumbImageView.contentMode = .scaleAspectFit
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thumbImageView)
        thumbImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        thumbImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0).isActive = true
        thumbImageView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0).isActive = true
        thumbImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //stack view
        stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: thumbImageView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        let font = UIFont.preferredFont(forTextStyle: .footnote)
        let configuration = UIImage.SymbolConfiguration(font: font)
        //comments
        let commentIcon = UIImageView()
        commentIcon.tintColor = .label
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        commentIcon.widthAnchor.constraint(equalToConstant: 17).isActive = true
        commentIcon.image = UIImage(systemName: "text.bubble", withConfiguration: configuration)
        stackView.addArrangedSubview(commentIcon)
        commentLabel = UILabel()
        commentLabel.font = font
        stackView.addArrangedSubview(commentLabel)
        
        //scrores
        let scoreIcon = UIImageView()
        scoreIcon.tintColor = .label
        scoreIcon.image = UIImage(systemName: "hand.thumbsup", withConfiguration: configuration)
        scoreIcon.translatesAutoresizingMaskIntoConstraints = false
        scoreIcon.widthAnchor.constraint(equalToConstant: 17).isActive = true
        stackView.addArrangedSubview(scoreIcon)
        scoreLabel = UILabel()
        scoreLabel.font = font
        stackView.addArrangedSubview(scoreLabel)

    }
    
    func configure(with feed: Feed) {
        nameLabel.text = feed.title
        if let value = feed.commentsCount {
            commentLabel.text = "\(value)"
        }else {
            commentLabel.text = nil
        }
        if let value = feed.score {
            scoreLabel.text = "\(value)"
        }else {
            scoreLabel.text = nil
        }
        if let urlString = feed.thumbnail?.url, let url = URL(string: urlString) {
            ImageCache.shared.load(url: url) { (image) in
                OperationQueue.main.addOperation {
                    self.thumbImageView.image = image
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
