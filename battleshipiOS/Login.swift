import UIKit

class Login: UIViewController {

    typealias Parameters = [String: AnyObject]
    
    @IBOutlet weak var userName: UITextField?
    @IBOutlet weak var gameId: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    @IBAction func startGame(_ sender: UIButton) {
    
        let url = URL(string: localizedString("login", table: "urls"))
        if let name = userName?.text, let id = gameId?.text {
            if name == "" {
                let alertVC = Alert.make(title: "No Info..", msg: "Info is required. Atleast name")
                present(alertVC, animated: true, completion: nil)
            }
            let parameters: Parameters = ["name": name as AnyObject, "gameId": id as AnyObject]
            Webservice().post(url: url!, parameters: parameters, completion: { res in
                self.showShipPlacementPage()
            })
        }
    }
    
    func showShipPlacementPage() {
        let shipPlacementVC = UIStoryboard(name: "ShipPlacement", bundle: nil).instantiateViewController(withIdentifier: "shipPlacement")
        self.navigationController?.pushViewController(shipPlacementVC, animated: true)
    }

}

