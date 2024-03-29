//
//  UsersViewController.swift
//  CoreDataProject
//
//  Created by Евгений Макулов on 26.08.2022.
//

import UIKit

// MARK: - UsersViewType

protocol UsersViewType: AnyObject {
    func updateTableView()
    func addUserButtonTapped()
}

// MARK: - UsersViewController

class UsersViewController: UIViewController {

    // MARK: - Properties

    var presenter: UsersPresenterType?

    private var usersView: UsersView? {
        guard isViewLoaded else { return nil }
        return view as? UsersView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = UsersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getAllUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateTableView()
    }

    // MARK: - Private functions

    private func setupView() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true

        usersView?.tableView.delegate = self
        usersView?.tableView.dataSource = self
        usersView?.addUserTextField.delegate = self
        usersView?.tableView.keyboardDismissMode = .onDrag
        usersView?.addUserButton.addTarget(self,
                                           action: #selector(addUserButtonTapped),
                                           for: .touchUpInside)
    }
}

// MARK: - UsersViewProtocol

extension UsersViewController: UsersViewType {
    @objc func addUserButtonTapped() {
        guard let userName = usersView?.addUserTextField.text,
              !userName.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Error", message: "Enter name")
            return
        }
        presenter?.saveUser(userName)
        usersView?.addUserTextField.text = ""
        usersView?.addUserTextField.resignFirstResponder()
    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.usersView?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.users?[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _,_,_  in
            guard let user = self?.presenter?.users?[indexPath.row] else { return }
            self?.presenter?.deleteUser(user)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let user = presenter?.users?[indexPath.row]
        presenter?.userDidSelect(user: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension UsersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addUserButtonTapped()
        textField.resignFirstResponder()
        return true
    }
}
