//
//  RegistrationController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .black
        button.setHeight(110)
        button.setWidth(110)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let passwordConfirmTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Confirm password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Fullname")
        return tf
    }()
    
    private let ageTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Age")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입 시 이용약관과 개인정보 취급방침에\n 동의한 것으로 간주됩니다. 해당정보는 습관 생성에\n 도움을 주는 용도로만 사용됩니다."
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let SignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(registerButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "또는"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let naverJoinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NAVER로 회원가입", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor(named: "naverColor")
        button.setHeight(50)
        return button
    }()
    
    private let kakaoJoinButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("KAKAO로 회원가입", for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "kakaoColor")
        button.setHeight(50)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        self.hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        self.moveViewWithKeyboard()
        configureNotificationObserver()
    }
    
    // MARK: Actions
    @objc func registerButtonTapped() {
        print("DEBUG: Registration Button did tap")
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == passwordConfirmTextField {
            viewModel.confirmPassword = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.age = sender.text
        }
        updateForm()
    }
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, passwordConfirmTextField, fullnameTextField, ageTextField, infoLabel, SignUpButton, orLabel, naverJoinButton, kakaoJoinButton])
        stack.axis = .vertical // StackView를 수평 혹은 수직으로 할지 설정합니다
        stack.spacing = 16
        stack.setHeight(660)
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingRight: 32)
    }
    
    func configureNotificationObserver() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordConfirmTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

extension RegistrationController: FormViewModel {
    func updateForm() {
        SignUpButton.backgroundColor = viewModel.buttonBackgroundColor
        SignUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        SignUpButton.isEnabled = viewModel.formValid
    }
}
