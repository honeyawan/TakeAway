//
//  ViewController.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/24/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let restaurantCellIdentifier = "TARestaurantTableViewCellID"
    var restaurantViewModel = TARestaurantsViewModel()
    var sortOptionsViewModel = TASortOptionsViewModel()

    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var sortOptionHeight: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadData() {
        spinner.startAnimating()
        restaurantViewModel.loadData { (error) in
            self.spinner.stopAnimating()
            self.tableView.reloadData()
            if error != nil {
                let alertController = UIAlertController.init(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                self.show(alertController, sender: nil)
            }
        }
    }
}

//MARK: IBActions
extension ViewController {
    
    @IBAction func onBtnApply() {
        guard sortOptionHeight.constant == 180 else {
            return
        }
        sortOptionHeight.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        
        btnSort.setTitle(sortOptionsViewModel.titleForSelectedSortOption() ?? "Sort", for: .normal)
        restaurantViewModel.sortRestaurantsWithOption(sortOptionsViewModel.selectedSortOption)
        tableView.reloadData()
        
    }
    
    @IBAction func onBtnSort() {
        guard sortOptionHeight.constant == 0 else {
            return
        }
        sortOptionHeight.constant = 180
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
}

//MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: restaurantCellIdentifier) as! TARestaurantTableViewCell
        restaurantViewModel.configureCell(cell, indexPath: indexPath)
        return cell
    }
}


//MARK: UISearch Bar delegate methods
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        restaurantViewModel.searchTermUpdated(searchText)
        tableView.reloadData()
    }
}

extension ViewController : UIPickerViewDataSource,UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptionsViewModel.numberOfRowsinPickerComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {        
        return sortOptionsViewModel.titleForPickerRow(row)
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        sortOptionsViewModel.sortOptionSelected(row)
    }

}
