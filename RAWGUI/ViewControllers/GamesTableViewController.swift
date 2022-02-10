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
        fetchGames(from: Link.randomGames.rawValue)
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 200, height: 200)
        
        let game = games?[indexPath.row]
        content.text = game?.name
        
        DispatchQueue.global().async {
            guard let stringUrl = game?.backgroundImage else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            }
        }
        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let gameVC = segue.destination as? GameViewController else { return }
        
    }
    
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
