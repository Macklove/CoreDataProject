//
//  Router.swift
//  CoreDataProject
//
//  Created by Евгений Макулов on 26.08.2022.
//

import UIKit

// MARK: - TemplateRouterProtocol

protocol TemplateRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyModule: ModuleAssemblyType? { get set }
}

// MARK: - UsersRouterProtocol

protocol UsersRouterProtocol: TemplateRouterProtocol {
    func initializeViewControllers()
    func showDetailedViewController(user: User?)
    func popToRoot()
}

// MARK: - Router

class Router: UsersRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyModule: ModuleAssemblyType?

    init(navigationController: UINavigationController, assemblyModule: ModuleAssemblyType) {
        self.navigationController = navigationController
        self.assemblyModule = assemblyModule
    }

    func initializeViewControllers() {
        guard let navigationController = navigationController,
              let usersViewController = assemblyModule?.createUsersModule(router: self)
        else { return }

        navigationController.viewControllers = [usersViewController]
    }

    func showDetailedViewController(user: User?) {
        guard let navigationController = navigationController,
              let detailedUserViewController = assemblyModule?.createDetailedUserModule(router: self, user: user)
        else { return }

        navigationController.pushViewController(detailedUserViewController, animated: true)
    }

    func popToRoot() {
        guard let navigationController = navigationController else { return }

        navigationController.popToRootViewController(animated: true)
    }
}
