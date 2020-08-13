//
//  MainViewController.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 03/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit
import Starscream

class MainViewController: UIViewController {
    
    private lazy var alertController: UIAlertController = {
        let controller = UIAlertController(title: "Device Id", message: "Please enter your id", preferredStyle: .alert)
        controller.addTextField { field in
            field.placeholder = "Device id"
        }
        controller.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        controller.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] _ in
            guard let deviceId = controller.textFields?.first?.text else {
                return
            }
            self?.viewModel.registerDeviceId(deviceId)
            self?.viewModel.connectToSocket()
        }))
        return controller
    }()
    
    private let viewModel: MainViewModel
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Color Screen"
        
        viewModel.colorReceivedHandler = { [weak self] color in
            DispatchQueue.main.async {            
                self?.view.backgroundColor = color
            }
        }
        
        present(alertController, animated: true)
    }
    
}

