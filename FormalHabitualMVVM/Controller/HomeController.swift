//
//  HomeController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase

private let reusableIdentifier = "Cell"

class HomeController: UICollectionViewController {
    
    let timeSelector : Selector = #selector(HomeController.updateTime)
    let interval = 1.0
    var count = 0
    
    // MARK: Properties
    
    private let currentTimeLabel: UILabel = {
        let timeLabel = UILabel()
        return timeLabel
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        configureUI()
    }
    
    // MARK: Actions
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc func addButtonTapped() {
        let uvc = AddHabitualController()
        uvc.modalPresentationStyle = .fullScreen
        self.present(uvc, animated: true)
    }
    
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd (E) h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.locale = Locale(identifier: "ko_kr")
        currentTimeLabel.text = formatter.string(from: date as Date)
    }
    
    // MARK: Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "로그아웃",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        
        
        collectionView.addSubview(currentTimeLabel)
        currentTimeLabel.anchor(left: collectionView.safeAreaLayoutGuide.leftAnchor, paddingTop: 12, paddingLeft: 12)
        currentTimeLabel.centerX(inView: collectionView)
    }
}

// MARK: UICollectionViewDataSource

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! HomeCell
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 75)
    }
}
