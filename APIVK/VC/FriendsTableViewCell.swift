//
//  FriendsTableViewCell.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import UIKit

class Model {
    var name: String
    var ditail: String
    var imageURL: URL?
    var imageData: Data?
    
    init(name: String, ditail: String, imageURL: URL? = nil, imageData: Data? = nil) {
        self.name = name
        self.ditail = ditail
        self.imageURL = imageURL
        self.imageData = imageData
    }
}

class FriendsTableViewCell: UITableViewCell {
    
    static let identifier = "MyCell"
    
    private let newsTitleLable: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    private let subtitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let newsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLable)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLable.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 170, height: 70)
        subtitleLabel.frame = CGRect(x: 10, y: 35, width: contentView.frame.size.width - 170, height: contentView.frame.size.height/2)
        newsImageView.frame = CGRect(x: contentView.frame.size.width-100, y: 15, width: 60, height: 60)
        
        newsImageView.layer.cornerRadius = newsImageView.frame.height / 2
        newsImageView.layer.masksToBounds = true
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
    
    func refresh(_ viewModel: Model ){
        
        newsTitleLable.text = viewModel.name
        subtitleLabel.text = viewModel.ditail
        
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
    }

}
