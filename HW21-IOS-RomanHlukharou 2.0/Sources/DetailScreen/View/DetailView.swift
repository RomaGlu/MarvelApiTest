import UIKit
import SnapKit

class DetailView: UIView {
    
    let urlConst = URLConstructor()
    
    lazy var comicsImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var comicsTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var comicsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(comicsImage)
        addSubview(comicsTitleLabel)
        addSubview(comicsDescriptionLabel)
    }
    
    private func setupLayout() {
        comicsImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(300)
        }
        
        comicsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(comicsImage.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(50)
        }
        
        comicsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(comicsTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(100)
            
        }
    }
    
}
