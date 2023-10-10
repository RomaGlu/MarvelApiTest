import UIKit
import SnapKit

final class ComicsView: UIView {
    
    private lazy var searchTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.placeholder = "Type character here"
        textField.indent(size: 10)
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var comicsTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBackground
        return tableView
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
        addSubview(searchTextField)
        addSubview(comicsTableView)
    }
    
    private func setupLayout() {
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(30)
        }
        
        comicsTableView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(searchTextField.snp.bottom).offset(15)
        }
    }
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
