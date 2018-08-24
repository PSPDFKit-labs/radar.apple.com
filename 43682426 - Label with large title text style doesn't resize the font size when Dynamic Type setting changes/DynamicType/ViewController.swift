//
//  ViewController.swift
//  DynamicType
//
//  Copyright © 2018 PSPDFKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bodyLabel = label(for: .body, textStyleString: "Body")
        let calloutLabel = label(for: .callout, textStyleString: "Callout")
        let caption1Label = label(for: .caption1, textStyleString: "Caption1")
        let caption2Label = label(for: .caption2, textStyleString: "Caption2")
        let footnoteLabel = label(for: .footnote, textStyleString: "Footnote")
        let headlineLabel = label(for: .headline, textStyleString: "Headline")
        let suheadlineLabel = label(for: .subheadline, textStyleString: "Subheadline")
        let title1Label = label(for: .title1, textStyleString: "Title1")
        let title2Label = label(for: .title2, textStyleString: "Title2")
        let title3Label = label(for: .title3, textStyleString: "Title3")

        // Issue: This label does not resize automatically when changing Dynamic Type setting.
        let largeTitleLabel = label(for: .largeTitle, textStyleString: "LargeTitle")

        // Uncomment the following lines to enable the workaround for automatically changing the large title label font size.
        // This is done by manually re-creating the font when the Dynamic Type setting changes.
//        let largeTitleLabelLabel = UILabel()
//        largeTitleLabelLabel.translatesAutoresizingMaskIntoConstraints = false
//        largeTitleLabelLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        largeTitleLabelLabel.text = "The quick brown fox jumps over the lazy dog"
//        largeTitleLabelLabel.adjustsFontForContentSizeCategory = true
//
//        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: nil) { notification in
//            largeTitleLabelLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        }
//
//        let largeTitleLabel = createContainer(for: largeTitleLabelLabel, textStyleString: "LargeTitle")


        let stackView = UIStackView(arrangedSubviews: [
            bodyLabel,
            calloutLabel,
            caption1Label,
            caption2Label,
            footnoteLabel,
            headlineLabel,
            suheadlineLabel,
            title1Label,
            title2Label,
            title3Label,
            largeTitleLabel,
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        view.addSubview(stackView)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.1695525464, green: 0.2538424172, blue: 0.3623318871, alpha: 1)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont.boldSystemFont(ofSize: 27)
        headerView.textColor = .white
        headerView.backgroundColor = #colorLiteral(red: 0.1695525464, green: 0.2538424172, blue: 0.3623318871, alpha: 1)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.text = contentSizeCategoryString
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: nil) { notification in
            headerView.text = self.contentSizeCategoryString
        }
        
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            headerView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }

    private func label(for textStyle: UIFontTextStyle, textStyleString: String) -> UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        label.text = "The quick brown fox jumps over the lazy dog"
        label.adjustsFontForContentSizeCategory = true

        return createContainer(for: label, textStyleString: textStyleString)
    }

    func createContainer(for label: UILabel, textStyleString: String) -> UIView {
        let badge = LabelBadge(text: textStyleString)
        badge.translatesAutoresizingMaskIntoConstraints = false

        let hairline = UIView()
        hairline.translatesAutoresizingMaskIntoConstraints = false
        hairline.backgroundColor = .gray

        let container = UIView()
        container.addSubview(badge)
        container.addSubview(label)
        container.addSubview(hairline)

        NSLayoutConstraint.activate([
            badge.widthAnchor.constraint(equalToConstant: 150),

            container.topAnchor.constraint(equalTo: badge.topAnchor),
            container.topAnchor.constraint(equalTo: label.topAnchor),

            container.bottomAnchor.constraint(equalTo: badge.bottomAnchor),
            container.bottomAnchor.constraint(equalTo: label.bottomAnchor),

            container.leadingAnchor.constraint(equalTo: badge.leadingAnchor),
            badge.trailingAnchor.constraint(equalTo: label.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            hairline.heightAnchor.constraint(equalToConstant: 1),
            hairline.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            hairline.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            hairline.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            ])

        return container
    }

    private var contentSizeCategoryString: String {
        switch UIApplication.shared.preferredContentSizeCategory {
        case .extraSmall:
            return "UIContentSizeCategoryExtraSmall"
        case .small:
            return "UIContentSizeCategorySmall"
        case .medium:
            return "UIContentSizeCategoryMedium"
        case .large:
            return "UIContentSizeCategoryLarge"
        case .extraLarge:
            return "UIContentSizeCategoryExtraLarge"
        case .extraExtraLarge:
            return "UIContentSizeCategoryExtraExtraLarge"
        case .extraExtraExtraLarge:
            return "UIContentSizeCategoryExtraExtraExtraLarge"
        case .accessibilityMedium:
            return "UIContentSizeCategoryAccessibilityMedium"
        case .accessibilityLarge:
            return "UIContentSizeCategoryAccessibilityLarge"
        case .accessibilityExtraLarge:
            return "UIContentSizeCategoryAccessibilityExtraLarge"
        case .accessibilityExtraExtraLarge:
            return "UIContentSizeCategoryAccessibilityExtraExtraLarge"
        case .accessibilityExtraExtraExtraLarge:
            return "UIContentSizeCategoryAccessibilityExtraExtraExtraLarge"

        case .unspecified:
            return "UIContentSizeCategoryUnspecified"
        default:
            return ""
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class LabelBadge: UIView {

    let label = UILabel()

    init(text: String) {
        super.init(frame: .zero)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 23, weight: .regular)
        label.textColor = .white

        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = #colorLiteral(red: 0.1158031896, green: 0.2697799504, blue: 0.4679633975, alpha: 0.8027611301)
        background.layer.cornerRadius = 8

        background.addSubview(label)

        addSubview(background)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: label.topAnchor, constant: -3),
            background.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 3),
            background.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -5),
            background.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),

            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            background.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            background.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
