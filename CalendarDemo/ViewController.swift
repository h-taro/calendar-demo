//
//  ViewController.swift
//  CalendarDemo
//
//  Created by taro.hiraishi on 2023/04/03.
//

import UIKit
import THLogger
import SnapKit

class ViewController: UIViewController {
    private var currentDate = Date()
    private var dateLabels: [String] = []
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter
    }()
    
    private lazy var csvButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPDATE", for: .normal)
        button.addTarget(self, action: #selector(onTapCSV), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let screenSize = UIScreen.main.bounds.size
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: String(describing: ItemCell.self))
        collectionView.backgroundColor = .systemPurple.withAlphaComponent(0.4)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        navigationItem.title = dateFormatter.string(from: currentDate)
        
        let currentYear = Calendar.current.component(.year, from: currentDate)
        let currentMonth = Calendar.current.component(.month, from: currentDate)
        dateLabels = getMonthDate(year: currentYear, month: currentMonth)
        collectionView.reloadData()
    }
    
    private func configure() {
        view.addSubview(collectionView)
        view.addSubview(csvButton)
        
        collectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.snp.width)
        }
        
        csvButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(40)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let rightBarButton = UIBarButtonItem(image: .init(systemName: "arrowshape.right"), style: .plain, target: self, action: #selector(onTapRight))
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(image: .init(systemName: "arrowshape.left"), style: .plain, target: self, action: #selector(onTapLeft))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func getMonthDate(year: Int, month: Int) -> [String] {
        guard let targetMonth = Calendar.current.date(from: DateComponents(year: year, month: month)) else { return [] }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        dateFormatter.calendar = Calendar.current
        
        var components = Calendar.current.dateComponents([.year, .month], from: targetMonth)
        var results: [String] = []
        
        /*
         第1週目
         */
        components.weekOfMonth = 1
        for weekday in 1...7 {
            components.weekday = weekday
            if let date = Calendar.current.date(from: components) {
                results.append(dateFormatter.string(from: date))
            }
        }
        
        /*
         第２週目
         */
        components.weekOfMonth = 2
        for weekday in 1...7 {
            components.weekday = weekday
            if let date = Calendar.current.date(from: components) {
                results.append(dateFormatter.string(from: date))
            }
        }
        
        /*
         第３週目
         */
        components.weekOfMonth = 3
        for weekday in 1...7 {
            components.weekday = weekday
            if let date = Calendar.current.date(from: components) {
                results.append(dateFormatter.string(from: date))
            }
        }
        
        /*
         第４週目
         */
        components.weekOfMonth = 4
        for weekday in 1...7 {
            components.weekday = weekday
            if let date = Calendar.current.date(from: components) {
                results.append(dateFormatter.string(from: date))
            }
        }
        
        /*
         第５週目
         */
        components.weekOfMonth = 5
        for weekday in 1...7 {
            components.weekday = weekday
            if let date = Calendar.current.date(from: components) {
                results.append(dateFormatter.string(from: date))
            }
        }
        
        /*
         第６週目
         */
        components.weekOfMonth = 6
        for weekday in 1...7 {
            components.weekday = weekday
            if let date = Calendar.current.date(from: components) {
                results.append(dateFormatter.string(from: date))
            }
        }
        
        return results
    }
    
    @objc private func onTapRight() {
        guard let oneMonthInFuture = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) else { return }
        currentDate = oneMonthInFuture
        
        navigationItem.title = dateFormatter.string(from: oneMonthInFuture)
        
        let year = Calendar.current.component(.year, from: currentDate)
        let month = Calendar.current.component(.month, from: currentDate)
        dateLabels = getMonthDate(year: year, month: month)
        collectionView.reloadData()
    }
    
    @objc private func onTapLeft() {
        guard let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) else { return }
        currentDate = oneMonthAgo
        
        navigationItem.title = dateFormatter.string(from: oneMonthAgo)
        
        let year = Calendar.current.component(.year, from: currentDate)
        let month = Calendar.current.component(.month, from: currentDate)
        dateLabels = getMonthDate(year: year, month: month)
        collectionView.reloadData()
    }
    
    @objc private func onTapCSV() {
        let updateCsvViewController = UpdateCSVViewController()
        navigationController?.pushViewController(updateCsvViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCell.self), for: indexPath) as? ItemCell
        else { return .init() }
        let fruit = dateLabels[indexPath.row]
        cell.configure(text: fruit)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let screenSize = view.window?.windowScene?.screen.bounds.size else { return .zero }
        return CGSize(width: screenSize.width / 7, height: screenSize.width / 7)
    }
}
