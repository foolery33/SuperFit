//
//  LastExercisesTableView.swift
//  SuperFit-Lab2
//
//  Created by admin on 03.05.2023.
//

import UIKit

class LastExercisesTableView: UITableView {

    var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        separatorStyle = .none
        self.register(LastExercisesTableViewCell.self, forCellReuseIdentifier: LastExercisesTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LastExercisesTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lastExercises.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: LastExercisesTableViewCell.identifier,
            for: indexPath
        ) as? LastExercisesTableViewCell {
            cell.selectionStyle = .none

            let trainingInfoModel = self.viewModel.getTrainingInfoModel(from: viewModel.lastExercises[indexPath.row])
            cell.setup(with: trainingInfoModel)
            return cell
        } else {
            return tableView.dequeueReusableCell(
                withIdentifier: LastExercisesTableViewCell.identifier,
                for: indexPath
            )
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension LastExercisesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114 + 16
    }
}

extension LastExercisesTableView {
    func calculateHeight() -> CGFloat {
        return CGFloat(self.viewModel.lastExercises.count * (114 + 16))
    }
}
