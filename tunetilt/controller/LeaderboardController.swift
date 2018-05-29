//
//  LeaderboardController.swift
//  tunetilt
//
//  Created by Enmaz on 27/5/18.
//  Copyright © 2018 Blinking Light Studios. All rights reserved.
//

import UIKit
import CoreData

class LeaderboardController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var leaderboard: UITableView!
    @IBOutlet weak var songPicker: UIPickerView!
    
    @IBOutlet weak var display: UIButton!
    var rows: [NSManagedObject] = []
    var song = ["One Song", "Two Song", "Red Song", "Blue Song"]
    let scores = Score()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scores.save(player: "Player 1", score: 10, tune: "One Song")
        scores.save(player: "Player 2", score: 15, tune: "One Song")
        scores.save(player: "Player 3", score: 20, tune: "One Song")
        scores.save(player: "Player 1", score: 20, tune: "Two Song")
        scores.save(player: "Player 2", score: 15, tune: "Two Song")
        scores.save(player: "Player 3", score: 10, tune: "Two Song")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func displayLeaderboard(_ sender: Any) {
        rows.removeAll()
        var selectedValue = song[songPicker.selectedRow(inComponent: 0)]
        rows = scores.get(tune: selectedValue)
        print(rows.count)
        leaderboard.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return song.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return song[row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardRows") as! LeaderboardRow
        cell.player.text = row.value(forKey: "player") as? String
        cell.score.text = row.value(forKey: "score") as? String
        return cell
    }

}
