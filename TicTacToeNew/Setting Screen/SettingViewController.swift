//
//  SettingVC.swift
//  TicTacToe
//
//  Danila
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    
    private var selectedSkins: SkinsCardView?
    
    
    // MARK: - UI Components
	
	private let skinsTitle: UILabel = {
		let label = UILabel()
		label.text = "Skins"
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
    private let settingsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 45
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let settingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
		stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.clipsToBounds = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let scrollViewContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
	private let dynamicTimeView = DynamicTimeView()
	private let dynamicMusicView = DynamicMusicView()
    
    
    private lazy var skinsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let firstSkinsView = SkinsCardView(skinPair: 1)
    private let secondSkinsView = SkinsCardView(skinPair: 2)
    private let thirdSkinsView = SkinsCardView(skinPair: 3)
    private let fourthSkinsView = SkinsCardView(skinPair: 4)
    private let fifthSkinsView = SkinsCardView(skinPair: 5)
    private let sixthSkinsView = SkinsCardView(skinPair: 6)

    
    private lazy var firstHStack = SkinsHorizontalStackView(views: firstSkinsView, secondSkinsView)
    private lazy var secondHStack = SkinsHorizontalStackView(views: thirdSkinsView, fourthSkinsView)
    private lazy var thirdHStack = SkinsHorizontalStackView(views: fifthSkinsView, sixthSkinsView)
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.app(.lightPurple)
        title = "Settings"
		
		
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "backButtonIcon"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        setupScrollView()
        addViews()
        makeConstraints()
        setDelegates()
        
		[firstSkinsView, secondSkinsView, thirdSkinsView, fourthSkinsView, fifthSkinsView, sixthSkinsView].forEach() {
			if $0.isSelected {
				selectedSkins = $0
			}
		}
        
		
		scrollViewContainer.dropShadow()
    }
    
    
    private func addViews() {
        
        skinsVStack.addArrangedSubview(firstHStack)
        skinsVStack.addArrangedSubview(secondHStack)
        skinsVStack.addArrangedSubview(thirdHStack)
    }

    
    
    // MARK: - Layout
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        scrollViewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        configureContainerView()
    }
    
    private func configureContainerView() {
        
        scrollViewContainer.addArrangedSubview(settingsView)
        settingsView.addSubview(settingStackView)
        
		scrollViewContainer.addArrangedSubview(skinsTitle)
		scrollViewContainer.setCustomSpacing(10, after: skinsTitle)
		settingStackView.addArrangedSubview(dynamicTimeView)
		settingStackView.addArrangedSubview(dynamicMusicView)
    
        scrollViewContainer.addArrangedSubview(skinsVStack)
        
    }
    
    
    
    private func makeConstraints() {
        
        
        settingsView.snp.makeConstraints { make in
			make.height.equalTo(settingStackView).offset(40)
            make.width.equalToSuperview()
        }
        
        settingStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
		
		
		skinsTitle.snp.makeConstraints { make in
			make.height.equalTo(22)
		}
	
    }
    
    
    private func setDelegates() {
        firstSkinsView.delegate = self
        secondSkinsView.delegate = self
        thirdSkinsView.delegate = self
        fourthSkinsView.delegate = self
        fifthSkinsView.delegate = self
        sixthSkinsView.delegate = self
		
		dynamicTimeView.delegate = self
		dynamicMusicView.delegate = self
    }
    
    
    @objc private func backButtonTapped() {
		self.navigationController?.popViewController(animated: true)
        
    }
}


// MARK: - Extensions
extension SettingsViewController: SkinsCardViewDelegate {
    
    func didSelectSkin(_ view: SkinsCardView) {
        if let selectedSkinView = selectedSkins, selectedSkinView != view {
            selectedSkinView.isSelected = false
        }
        selectedSkins = view
        view.isSelected = true
    }
    
    @objc private func toggleTime() {
        Saves.isTimeMode.toggle()
        
    }
}


extension SettingsViewController: DynamicDelegate {
	
	func dynamicViewDidChangedHeight(_ dynamicTimeView: Dynamic) {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
				self.view.layoutIfNeeded()
			}
		}
	
}
