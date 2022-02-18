//
//  MainViewController.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import UIKit
import TinyConstraints

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: MainViewPresenterProtocol!
    
    private let layout: UICollectionViewLayout = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.interSectionSpacing = 16.0
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (section, _) in
            let width = UIScreen.main.bounds.width * 0.45
            let height = width * 1.25
            let size = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(48.0))
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
            )
            
            section.contentInsets = .init(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0)
            section.interGroupSpacing = 16.0
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }, configuration: config)
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0)
        collectionView.register(MainCollectionViewCell.self)
        collectionView.register(
            MainHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainHeaderView.id
        )
        
        return collectionView
    }()
    
    private var items: [MainViewModel] = []
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        presenter.fetchData()
    }

}

//MARK: - View Protocol Methods

extension MainViewController: MainViewProtocol {
    
    func updateView(with items: [MainViewModel]) {
        self.items = items
        collectionView.reloadData()
    }
    
}

//MARK: - CollectionView DataSource & Delegate Methods

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = items[indexPath.section].items[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: MainHeaderView.id, for: indexPath
              ) as? MainHeaderView else {
            return UICollectionReusableView()
        }
        
        let headerTitle = items[indexPath.section].headerTitle
        view.configure(title: headerTitle)
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        setSelectedItem(at: indexPath, isSelected: true)
        cell.setSelected(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        setSelectedItem(at: indexPath, isSelected: false)
        cell.setSelected(false)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let selectedItemsCount = (collectionView.indexPathsForSelectedItems ?? []).count
        return (selectedItemsCount < 6) && (selectedItemsCount >= 0)
    }
    
}

//MARK: - Private Methods

extension MainViewController {
    
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        collectionView.bottomToSuperview()
    }
    
    private func setSelectedItem(at indexPath: IndexPath, isSelected: Bool) {
        items[indexPath.section].items[indexPath.row].isSelected = isSelected
        presenter.setSelectedItem(at: indexPath, isSelected: isSelected)
    }
    
}
