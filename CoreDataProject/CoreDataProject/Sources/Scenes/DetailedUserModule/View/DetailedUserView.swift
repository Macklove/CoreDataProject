//
//  DetailedUserView.swift
//  CoreDataProject
//
//  Created by Евгений Макулов on 26.08.2022.
//

import UIKit
import SnapKit

class DetailedUserView: UIView {

    // MARK: Configuration

    func setAvatar(_ avatar: Data) {
        avatarButton.setImage(UIImage(data: avatar), for: .normal)
        avatarButton.setImage(UIImage(data: avatar), for: .disabled)
    }

    // MARK: - Views

    var avatarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "defaultUserPhoto"), for: .normal)
        button.imageView?.layer.cornerRadius = CGFloat(Metrics.avatarImageViewHeight / 2)
        button.imageView?.clipsToBounds = true
        button.imageView?.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()

    var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.setIcon("person")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        return textField
    }()

    var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Enter your birth date"
        textField.setIcon("calendar")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        return textField
    }()

    var genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose your gender"
        textField.textAlignment = .left
        textField.setIcon("person.2.circle")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        return textField
    }()

    var genderPickerView: UIPickerView = {
        UIPickerView()
    }()

    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        let subviews = [avatarButton,
                        userNameTextField,
                        birthDateTextField,
                        genderTextField]
        subviews.forEach { addSubview($0) }
    }

    private func setupLayout() {
        avatarButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Metrics.avatarImageViewTopOffset)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(Metrics.avatarImageViewHeight)
        }

        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarButton.snp.bottom).offset(Metrics.primaryTopOffset)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(Metrics.primaryLeftOffset)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(Metrics.primaryRightOffset)
            make.height.equalTo(Metrics.primaryHeight)
        }

        birthDateTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(Metrics.primaryTopOffset)
            make.left.right.height.equalTo(userNameTextField)
        }

        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(birthDateTextField.snp.bottom).offset(Metrics.primaryTopOffset)
            make.left.right.height.equalTo(birthDateTextField)
        }
    }

    private func setupView() {
        backgroundColor = .systemBackground
    }
}

// MARK: - Metrics

extension DetailedUserView {
    enum Metrics {
        static let avatarImageViewTopOffset = 30
        static let avatarImageViewHeight = 180

        static let primaryTopOffset = 20
        static let primaryLeftOffset = 15
        static let primaryRightOffset = -15
        static let primaryHeight = 60
    }
}
