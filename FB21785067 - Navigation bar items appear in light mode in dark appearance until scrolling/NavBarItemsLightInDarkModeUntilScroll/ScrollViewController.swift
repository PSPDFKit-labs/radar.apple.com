//
//  ScrollViewController.swift
//  NavBarItemsLightInDarkModeUntilScroll
//
//  Created by Nishant Desai on 28/01/26.
//

import UIKit

class ScrollViewController: UIViewController {
    
    private let collectionView: UICollectionView
    
    private let colors: [UIColor] = [
        .systemRed, .systemBlue, .systemGreen, .systemOrange,
        .systemPurple, .systemPink, .systemTeal, .systemIndigo,
        .systemBrown, .systemYellow, .systemCyan, .systemMint
    ]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Colored Cells"
        navigationItem.subtitle = "Scroll down"
        
        setupNavigationButtons()
        
        setupCollectionView()

        let scrollEdgeContainerView = UIView()
        scrollEdgeContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollEdgeContainerView)

        let interaction = UIScrollEdgeElementContainerInteraction()
        interaction.scrollView = collectionView
        interaction.edge = .top

        scrollEdgeContainerView.addInteraction(interaction)

        scrollEdgeContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        scrollEdgeContainerView.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        scrollEdgeContainerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        scrollEdgeContainerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true

        setupConstraints()
    }

    private func setupNavigationButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: "Add", message: "Add button was tapped", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func refreshButtonTapped() {
        collectionView.reloadData()
        
        let alert = UIAlertController(title: "Refresh", message: "Collection view refreshed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func infoButtonTapped() {
        let alert = UIAlertController(title: "Info", message: "This collection view shows \(colors.count * 40) colored cells", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground.withAlphaComponent(0.4)
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(ColoredCell.self, forCellWithReuseIdentifier: ColoredCell.identifier)

        collectionView.topEdgeEffect.style = .hard
        collectionView.bottomEdgeEffect.style = .hard
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ScrollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count * 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColoredCell.identifier, for: indexPath) as! ColoredCell
        let color = colors[indexPath.item % colors.count]
        cell.configure(with: color, index: indexPath.item)
        return cell
    }
}

extension ScrollViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Cell Tapped", message: "You tapped cell \(indexPath.item)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

class ColoredCell: UICollectionViewCell {
    static let identifier = "ColoredCell"
    
    private let containerView = UIView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        contentView.addSubview(containerView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(with color: UIColor, index: Int) {
        containerView.backgroundColor = color
        label.text = "\(index)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.backgroundColor = nil
        label.text = nil
    }
}
