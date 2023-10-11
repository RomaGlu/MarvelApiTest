import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
    
    let urlConstructor = URLConstructor()
    
    private lazy var comicsImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")

        self.accessoryType = .disclosureIndicator
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubview(comicsImage)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        comicsImage.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(15)
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(50)
            make.height.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(comicsImage.snp.right).offset(10)
            make.centerY.equalTo(comicsImage.snp.centerY)
            make.width.equalTo(250)
        }
    }
    
    func configureView(with comics: Comics) {
        if let imageUrlString = urlConstructor.getImageUrl(path: comics.thumbnail?.path,
                                                           size: .portrait,
                                                           extention: comics.thumbnail?.imageExtension) {
            NetworkManager().getImages(from: imageUrlString) { result in
                switch result {
                case .success(let data):
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.comicsImage.image = image
                        }
                    }
                case .failure(let error):
                    print("Error is \(error.localizedDescription)")
                }
            }
        } else {
            comicsImage.image = UIImage(systemName: "book.and.wrench.fill")
        }
        titleLabel.text = "\(comics.title)"
    }
}

