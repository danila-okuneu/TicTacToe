import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "LeaderboardTableViewCell"
	
	var leaderboard: LeaderboardModel? { didSet { setLeaderboard() } }

    // MARK: - Outlets
    private let positionLabel: UILabel = {
        let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
		label.textColor = UIColor.app(.black)
        label.layer.cornerRadius = Constants.positionLabelCornerRadius
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let durationContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.durationLabelCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.timeLabelFontStize, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

	private let modeLabel: UILabel = {

		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: Constants.timeLabelFontStize, weight: .regular)
		label.textAlignment = .left
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
    // MARK: - Initial

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .app(.lightPurple)
        setupHierarchy()
        setupLayout()
    }
	

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    private func setupHierarchy() {
        contentView.addSubview(positionLabel)
        contentView.addSubview(durationContainer)
		durationContainer.addSubview(modeLabel)
        durationContainer.addSubview(durationLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            positionLabel.heightAnchor.constraint(
                equalToConstant: Constants.labelHeight
            ),
            positionLabel.widthAnchor.constraint(
                equalTo: positionLabel.heightAnchor
            ),
            positionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            positionLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            durationContainer.heightAnchor.constraint(
                equalToConstant: Constants.labelHeight
            ),
            durationContainer.leadingAnchor.constraint(
                equalTo: positionLabel.trailingAnchor,
                constant: Constants.durationContainerLeadingMargin
            ),
            durationContainer.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            durationContainer.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
			durationLabel.bottomAnchor.constraint(
				equalTo: durationContainer.bottomAnchor,
				constant: -10
            ),
            durationLabel.leadingAnchor.constraint(
                equalTo: durationContainer.leadingAnchor,
                constant: Constants.durationLabelLeadingMargin
            ),
			
			
			
			modeLabel.topAnchor.constraint(
				equalTo: durationContainer.topAnchor,
				constant: 10
			),
			modeLabel.leadingAnchor.constraint(
				equalTo: durationContainer.leadingAnchor,
				constant: Constants.durationLabelLeadingMargin
			),
		

			
        ])
    }
	
	
	private func setLeaderboard() {
		
		let time = translateTo(time: leaderboard?.result.time ?? 0)
		var mode = leaderboard?.result.mode.rawValue ?? "Single"
		if let difficulty = leaderboard?.result.difficulty?.rawValue {
			mode = "Single | \(difficulty)"
		}
		
		if let leaderboard {
			positionLabel.text = "\(leaderboard.position)"
			
			durationLabel.attributedText = attributed(
				string: leaderboard.isBest ? "Best time: \(time)" : "Time: \(time)",
				lenght: leaderboard.isBest ? 10 : 5
			)
			
			modeLabel.attributedText = attributed(string: "Mode: \(mode)", lenght: 5)
			positionLabel.backgroundColor = leaderboard.isBest ? .app(.purple) : .app(.lightBlue)
			durationContainer.backgroundColor = leaderboard.isBest ? .app(.purple) : .app(.lightBlue)

				
		}
	}
	
	private func attributed(string: String, lenght: Int) -> NSAttributedString {
		
		let attributedString = NSMutableAttributedString(string: string)
		attributedString.addAttribute(
			NSAttributedString.Key.font,
			value: UIFont.systemFont(
				ofSize: 18,
				weight: .semibold
			),
			range: NSRange(location: 0, length: lenght)
		)
		return attributedString
	}
	
	
	private func translateTo(time: Int) -> String {
		let minutes = time / 60
		let seconds = time % 60
		return String(format: "%d:%02d", minutes, seconds)
		
	}
	
    override func prepareForReuse() {
        super.prepareForReuse()
        positionLabel.text = nil
        durationLabel.text = nil

    }
}

// MARK: - Constants

extension LeaderboardTableViewCell {
    private struct Constants {
        // Fixed sizes
        static let positionLabelFontSize: CGFloat = 20
        static let timeLabelFontStize: CGFloat = 18

        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        // Relative sizes
        static let labelHeight: CGFloat = screenHeight * (69 / 844)
        static let positionLabelCornerRadius: CGFloat = labelHeight / 2
        static let durationLabelCornerRadius: CGFloat = labelHeight / 2
        static let durationContainerLeadingMargin: CGFloat = screenWidth * (10 / 390)
        static let durationLabelLeadingMargin: CGFloat = screenWidth * (24 / 390)
    }
}
