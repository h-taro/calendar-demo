//
//  ViewController.swift
//  CalendarDemo
//
//  Created by taro.hiraishi on 2023/04/03.
//

import UIKit
import THLogger

class ViewController: UIViewController {
    private let fruits = ["apple", "grape", "lemon", "banana", "cherry", "strobery", "peach", "orange"]
    private var dateLabels: [String] = []
    
    private let collectionView: UICollectionView = {
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
        
        view.addSubview(collectionView)
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let currentDate = Date()
        let year = Calendar.current.component(.year, from: currentDate)
        let month = Calendar.current.component(.month, from: currentDate)
        let day = Calendar.current.component(.day, from: currentDate)
        
        navigationItem.title = "\(year)/\(month)/\(day)"
        
        dateLabels = hoge(year: 2023, month: 4)
        collectionView.reloadData()
    }
    
    private func hoge(year: Int, month: Int) -> [String] {
        guard let targetMonth = Calendar.current.date(from: DateComponents(year: year, month: month)) else { return [] }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        dateFormatter.calendar = Calendar.current
        
        let yearMonthFormatter = DateFormatter()
        yearMonthFormatter.dateFormat = "yyyy年M月"
        yearMonthFormatter.calendar = Calendar.current
        
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
}

// MARK: -
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let screenSize = view.window?.windowScene?.screen.bounds.size else { return .zero }
        return CGSize(width: screenSize.width / 7, height: screenSize.width / 7)
    }
}
