//
//  BaseViewController.swift
//  PPPCLUB-iOS
//
//  Created by 류희재 on 2023/07/03.
//

import UIKit

import SnapKit
import Then

class BaseViewController : UIViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Custom Method
    
    func setUI(){
        view.backgroundColor = .pppWhite
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setLayout(){
        
    }
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-200, width: 250, height: 60))
        toastLabel.backgroundColor = .gray
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 0.5
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func validateResult(_ result: NetworkResult<Any>) -> Any?{
        switch result{
        case .success(let data):
            print("성공했습니다.")
            print("⭐️⭐️⭐️⭐️⭐️⭐️")
            print(data)
            return data
        case .requestErr(let message):
            presentBottomAlert(message)
        case .pathErr:
            presentBottomAlert("path 혹은 method 오류입니다.")
        case .serverErr:
            presentBottomAlert("서버 내 오류입니다.")
        case .networkFail:
            presentBottomAlert("네트워크가 불안정합니다.")
        case .decodedErr:
            presentBottomAlert("디코딩 오류가 발생했습니다.")
        case .authorizationFail(_):
            presentBottomAlert("인증 오류가 발생했습니다. 다시 로그인해주세요")
        }
        return nil
    }
    
    //MARK: - Action Method
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        print(#function)
        if gestureRecognizer.state == .recognized {
            navigationController?.popViewController(animated: true)
        }
    }
    
}

extension BaseViewController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//
//        print(#function)
//        // 1. 현재 뷰컨트롤러에서 Swipe 제스처 인식기를 생성합니다.
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
//        swipeGesture.direction = .right
//        view.addGestureRecognizer(swipeGesture)
//
//        // 2. 이전 뷰컨트롤러에서 Swipe 제스처 인식기를 제거합니다.
//        if let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) {
//            for recognizer in previousViewController.view.gestureRecognizers ?? [] {
//                previousViewController.view.removeGestureRecognizer(recognizer)
//            }
//        }
//    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("Child ViewControllers", navigationController.viewControllers.count)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = navigationController.viewControllers.count > 1
        
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController else { return false }
        return navigationController.viewControllers.count > 1
    }
}


