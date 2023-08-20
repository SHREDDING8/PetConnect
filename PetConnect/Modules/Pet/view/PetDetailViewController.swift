//
//  PetDetailViewController.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

// MARK: - State

private enum State {
  case closed
  case open
}

extension State {
  var opposite: State {
    switch self {
    case .open: return .closed
    case .closed: return .open
    }
  }
}

// MARK: - View Controller

class PetDetailViewController: UIViewController {
  
  // MARK: - Constants
  
  private let popupOffset: CGFloat = 440
  
  // MARK: - Views
  
  //MARK: - Аватарка
  private lazy var contentImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "")
    return imageView
  }()
  
  private lazy var overlayView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.alpha = 0
    return view
  }()
  
  private lazy var popupView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.1
    view.layer.shadowRadius = 10
    return view
  }()
  
  //MARK: - Meню
  private lazy var tableView = UITableView()
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    layout()
    popupView.addGestureRecognizer(panRecognizer)
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  // MARK: - Layout
  
  private var bottomConstraint = NSLayoutConstraint()
  
  private func layout() {
    
    contentImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(contentImageView)
    contentImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    contentImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    contentImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    contentImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    overlayView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(overlayView)
    overlayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    overlayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    overlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    overlayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    popupView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(popupView)
    popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: popupOffset)
    bottomConstraint.isActive = true
    popupView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    popupView.addSubview(tableView)
    tableView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
    tableView.heightAnchor.constraint(equalToConstant: 428).isActive = true
    
  }
  
  // MARK: - Animation
  
  /// The current state of the animation. This variable is changed only when an animation completes.
  private var currentState: State = .closed
  
  /// All of the currently running animators.
  private var runningAnimators = [UIViewPropertyAnimator]()
  
  /// The progress of each animator. This array is parallel to the `runningAnimators` array.
  private var animationProgress = [CGFloat]()
  
  private lazy var panRecognizer: InstantPanGestureRecognizer = {
    let recognizer = InstantPanGestureRecognizer()
    recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
    return recognizer
  }()
  
  /// Animates the transition, if the animation is not already running.
  private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
    
    // ensure that the animators array is empty (which implies new animations need to be created)
    guard runningAnimators.isEmpty else { return }
    
    // an animator for the transition
    let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
      switch state {
      case .open:
        self.bottomConstraint.constant = 0
        self.popupView.layer.cornerRadius = 20
        self.overlayView.alpha = 0.5
      case .closed:
        self.bottomConstraint.constant = self.popupOffset
        self.popupView.layer.cornerRadius = 0
        self.overlayView.alpha = 0
      }
      self.view.layoutIfNeeded()
    })
    
    // the transition completion block
    transitionAnimator.addCompletion { position in
      
      // update the state
      switch position {
      case .start:
        self.currentState = state.opposite
      case .end:
        self.currentState = state
      case .current:
        ()
      @unknown default:
        fatalError()
      }
      
      // manually reset the constraint positions
      switch self.currentState {
      case .open:
        self.bottomConstraint.constant = 0
      case .closed:
        self.bottomConstraint.constant = self.popupOffset
      }
      
      // remove all running animators
      self.runningAnimators.removeAll()
      
    }
    
    // start all animators
    transitionAnimator.startAnimation()
    
    // keep track of all running animators
    runningAnimators.append(transitionAnimator)
    
  }
  
  @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
    switch recognizer.state {
    case .began:
      
      // start the animations
      animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
      
      // pause all animations, since the next event may be a pan changed
      runningAnimators.forEach { $0.pauseAnimation() }
      
      // keep track of each animator's progress
      animationProgress = runningAnimators.map { $0.fractionComplete }
      
    case .changed:
      
      // variable setup
      let translation = recognizer.translation(in: popupView)
      var fraction = -translation.y / popupOffset
      
      // adjust the fraction for the current state and reversed state
      if currentState == .open { fraction *= -1 }
      if runningAnimators[0].isReversed { fraction *= -1 }
      
      // apply the new fraction
      for (index, animator) in runningAnimators.enumerated() {
        animator.fractionComplete = fraction + animationProgress[index]
      }
      
    case .ended:
      
      // variable setup
      let yVelocity = recognizer.velocity(in: popupView).y
      let shouldClose = yVelocity > 0
      
      // if there is no motion, continue all animations and exit early
      if yVelocity == 0 {
        runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
        break
      }
      
      // reverse the animations based on their current state and pan motion
      switch currentState {
      case .open:
        if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
        if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
      case .closed:
        if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
        if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
      }
      
      // continue all animations
      runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
      
    default:
      ()
    }
  }
  
}

// MARK: - InstantPanGestureRecognizer

/// A pan gesture that enters into the `began` state on touch down instead of waiting for a touches moved event.
class InstantPanGestureRecognizer: UIPanGestureRecognizer {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    if (self.state == UIGestureRecognizer.State.began) { return }
    super.touchesBegan(touches, with: event)
    self.state = UIGestureRecognizer.State.began
  }
  
}

extension PetDetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 2 {
      return PetHim.dataSource[0].chip != nil ? 3 : 0
    } else if section == 3 {
      return PetHim.dataSource[0].cleimo != nil ? 2 : 0
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = MenuTableViewCell()
    let pet = PetHim.dataSource[0]
    if indexPath.section == 0 {
      cell.descLabel.text = "Пол"
      cell.detailLabel.text = pet.imageGender
    } else if indexPath.section == 1 {
      cell.descLabel.text = "Возраст"
      cell.detailLabel.text = pet.age
    } else if indexPath.section == 2 {
      if indexPath.row == 0 {
        cell.descLabel.text = "Номер чипа:"
        cell.detailLabel.text = pet.chip != nil ? pet.chip!.number : ""
      }else if indexPath.row == 1 {
        cell.descLabel.text = "Дата имплонтации:"
        cell.detailLabel.text = pet.chip != nil ? pet.chip!.date : ""
      }else {
        cell.descLabel.text = "Место имплонтации:"
        cell.detailLabel.text = pet.chip != nil ? pet.chip!.mesto : ""
      }
    }
    else {
      if indexPath.row == 0 {
        cell.descLabel.text = "Номер клейма:"
        cell.detailLabel.text = pet.cleimo != nil ? pet.cleimo!.number : ""
      }else if indexPath.row == 1 {
        cell.descLabel.text = "Дата клеймирования:"
        cell.detailLabel.text = pet.cleimo != nil ? pet.cleimo!.date : ""
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 20
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      return MenuHeaderView()
    } else {
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 50
    }
    return 0
  }
}
