import UIKit

class View:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var items = [Item]()
    private let presenter = Presenter()
    private weak var collection:UICollectionView!
    private weak var indicator:UIActivityIndicatorView!
    private weak var message:UILabel!
    private weak var refresh:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeOutlets()
        presenter.update = { [weak self] viewModel in
            self?.update(viewModel:viewModel)
        }
        presenter.refresh()
    }
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to:size, with:coordinator)
        collection.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int {
        return items.count
    }
    
    func collectionView(_:UICollectionView, layout:UICollectionViewLayout, sizeForItemAt:IndexPath) -> CGSize {
        return collection.bounds.size
    }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier:"cell", for:index) as! Cell
        cell.item = items[index.item]
        return cell
    }
    
    func collectionView(_:UICollectionView, shouldSelectItemAt:IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_:UICollectionView, shouldHighlightItemAt:IndexPath) -> Bool {
        return false
    }
    
    private func makeOutlets() {
        let indicator = UIActivityIndicatorView(style:.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        view.addSubview(indicator)
        self.indicator = indicator
        
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.isUserInteractionEnabled = false
        message.numberOfLines = 0
        message.textAlignment = .center
        message.font = .systemFont(ofSize:20, weight:.light)
        message.textColor = .black
        view.addSubview(message)
        self.message = message
        
        let refresh = UIButton()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.backgroundColor = .black
        refresh.setTitle(NSLocalizedString("View.refresh", comment:String()), for:[])
        refresh.setTitleColor(.white, for:.normal)
        refresh.setTitleColor(UIColor(white:1, alpha:0.2), for:.highlighted)
        refresh.layer.cornerRadius = 6
        refresh.titleLabel!.font = .systemFont(ofSize:16, weight:.bold)
        refresh.isHidden = true
        view.addSubview(refresh)
        self.refresh = refresh
        
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top:20, left:20, bottom:20, right:20)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 10
        flow.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame:.zero, collectionViewLayout:flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.alwaysBounceHorizontal = true
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(Cell.self, forCellWithReuseIdentifier:"cell")
        view.addSubview(collection)
        self.collection = collection
        
        indicator.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        
        message.bottomAnchor.constraint(equalTo:indicator.topAnchor, constant:-40).isActive = true
        message.leftAnchor.constraint(equalTo:view.leftAnchor, constant:40).isActive = true
        message.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-40).isActive = true
        
        refresh.topAnchor.constraint(equalTo:indicator.bottomAnchor, constant:40).isActive = true
        refresh.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        refresh.widthAnchor.constraint(equalToConstant:130).isActive = true
        refresh.heightAnchor.constraint(equalToConstant:38).isActive = true
        
        collection.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        collection.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            collection.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            collection.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            collection.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            collection.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        }
    }
    
    private func update(viewModel:ViewModel) {
        message.text = viewModel.message
        refresh.isHidden = viewModel.refreshHidden
        indicator.isHidden = viewModel.indicatorHidden
        items = viewModel.items
        collection.reloadData()
    }
}
