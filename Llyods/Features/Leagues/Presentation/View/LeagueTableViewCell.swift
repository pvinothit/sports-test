//
//  LeagueTableViewCell.swift
//  Llyods
//
//  Created by Vinoth Palanisamy on 11/10/2024.
//

import UIKit

final class LeagueTableViewCell: UITableViewCell {
    
    static var identifier: String = String(describing: LeagueTableViewCell.self)
    
    private struct Constants {
        static let inset: CGFloat = 5
        static let bodyFontSize: CGFloat = 12
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.bodyFontSize)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(codeLabel)
    }
    
    private func activateConstraints() {
        let nameConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.inset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.inset)
        ]
        let codeConstraints = [
            codeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.inset),
            codeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.inset),
            codeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.inset)
        ]
        NSLayoutConstraint.activate(nameConstraints + codeConstraints)
    }
    
    func update(league: League) {
        nameLabel.text = league.name
        codeLabel.text = league.code
    }
}
