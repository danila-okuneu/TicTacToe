import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "LeaderboardTableViewCell"
    var leaderboard: LeaderboardModel? {
        didSet {
            guard let leaderboard else { return }
            positionLabel.text = "\(leaderboard.position)"
            durationLabel.text = leaderboard.isBest ? "Best time \(leaderboard.duration)" : "Time \(leaderboard.duration)"
            positionLabel.backgroundColor = leaderboard.isBest ? .app(.purple) : .app(.lightBlue)
            durationContainer.backgroundColor = leaderboard.isBest ? .app(.purple) : .app(.lightBlue)
        }
    }

    // MARK: - Outlets

    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.positionLabelFontSize, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
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
            durationLabel.centerYAnchor.constraint(
                equalTo: durationContainer.centerYAnchor
            ),
            durationLabel.leadingAnchor.constraint(
                equalTo: durationContainer.leadingAnchor,
                constant: Constants.durationLabelLeadingMargin
            ),
        ])
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
        static let durationLabelCornerRadius: CGFloat = screenHeight * (30 / 844)
        static let durationContainerLeadingMargin: CGFloat = screenWidth * (10 / 390)
        static let durationLabelLeadingMargin: CGFloat = screenWidth * (24 / 390)
    }
}
