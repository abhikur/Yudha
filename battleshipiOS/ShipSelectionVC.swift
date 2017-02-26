import UIKit

class ShipSelectionVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var shipsControlView: UIPickerView?
    let ships = ["Carrier","Battleship","Cruiser","Submarine","Destroyer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shipsControlView?.delegate = self
        shipsControlView?.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ships.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ships[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let notificationName = NSNotification.Name("shipSelection")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["shipIndex": row])
    }
}
