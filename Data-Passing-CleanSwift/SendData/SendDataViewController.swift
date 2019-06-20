//
//  SendDataViewController.swift
//  Data-Passing-CleanSwift
//
//  Created by Krish on 19/06/19.
//  Copyright (c) 2019 Krish. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SendDataDisplayLogic: class
{
  func displaySomething(viewModel: SendData.Something.ViewModel)
}

class SendDataViewController: UIViewController, SendDataDisplayLogic
{
  var interactor: SendDataBusinessLogic?
  var router: (NSObjectProtocol & SendDataRoutingLogic & SendDataDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = SendDataInteractor()
    let presenter = SendDataPresenter()
    let router = SendDataRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
    @IBOutlet weak var dataFromServer: UILabel!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        doSomething()
      //  dismiss(animated: true, completion: nil)
    }
    func doSomething()
  {
    let name = dataFromServer.text!
    let request = SendData.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: SendData.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
    router?.routeToSomewhere(segue: nil)
  }
}