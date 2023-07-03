//
//  ExercisesTableView.swift
//  SuperFit-Lab2
//
//  Created by admin on 12.05.2023.
//

import UIKit

class ExercisesTableView: UITableView {

    var viewModel: ExercisesViewModel
    init(viewModel: ExercisesViewModel) {
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

extension ExercisesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exercises.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: LastExercisesTableViewCell.identifier,
            for: indexPath
        ) as? LastExercisesTableViewCell {
            cell.selectionStyle = .none
            let exercise = viewModel.exercises[indexPath.row]
            cell.setup(with: exercise)
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: LastExercisesTableViewCell.identifier, for: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToExerciseScreen(exercise: viewModel.exercises[indexPath.row])
    }
}

extension ExercisesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114 + 16
    }
}

extension ExercisesTableView {
    func calculateHeight() -> CGFloat {
        return CGFloat(self.viewModel.exercises.count * (114 + 16))
    }
}
