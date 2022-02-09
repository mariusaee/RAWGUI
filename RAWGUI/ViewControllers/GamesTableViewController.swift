//
//  GamesTableViewController.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 08.02.2022.
//

import UIKit

class GamesTableViewController: UITableViewController {
    
    //MARK: Private properties
    private var games: [Game]?
   
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        fetchGames(from: Link.randomGames.rawValue)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        content.text = games?[indexPath.row].name

        DispatchQueue.global().async {
            guard let stringUrl = self.games?[indexPath.row].backgroundImage else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                content.image = UIImage(data: imageData)
                content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
                cell.contentConfiguration = content
            }
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private methods
    private func fetchGames(from url: String) {
        NetworkManager.shared.fetch(dataType: Rawg.self, from: url) { result in
            switch result {
            case .success(let gamesResponse):
                self.games = gamesResponse.results ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
