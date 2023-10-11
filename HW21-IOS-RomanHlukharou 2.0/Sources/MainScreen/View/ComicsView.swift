import UIKit
import SnapKit

final class ComicsView: UIView {
    
    //    MARK: - Outlets

    public lazy var comicsTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    //    MARK: - Initializators
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Layout
    
    private func setupHierarchy() {
        addSubview(comicsTableView)
    }
    
    private func setupLayout() {
        
        comicsTableView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
