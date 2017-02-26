import UIKit

class Login: UIViewController {

    typealias Parameters = [String: AnyObject]
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var gameId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    @IBAction func startGame(_ sender: UIButton) {
    
        let url = URL(string: localizedString("login", table: "urls"))
        var parameters: Parameters = [:]
        
        if let name = userName.text {
            parameters = ["name": name as AnyObject, "gameId": gameId.text as AnyObject? ?? "" as AnyObject]
        }
        Webservice().post(url: url!, parameters: parameters, completion: { res in
            print(res)
            let shipPlacementVC = UIStoryboard(name: "ShipPlacement", bundle: nil).instantiateViewController(withIdentifier: "shipPlacement")
            self.navigationController?.pushViewController(shipPlacementVC, animated: true)
        })
    }

}

