import Cocoa
import DampingModule

class ViewController: NSViewController {
    @IBAction func OpenFile(_ sender: NSButton) {
        
        if let url = NSOpenPanel().selectUrl {
            let payload = FileHelper.ReadFile(url: url).data(using: String.Encoding.utf8)
            
            do {
                Shared.instance = try JSONDecoder().decode(Shared.self, from: payload!)
                
                let alert = NSAlert()
                alert.messageText = "Файл загружен"
                alert.alertStyle = .informational
                alert.addButton(withTitle: "OK")
                alert.runModal()
                
                T.objectValue = Shared.instance.T
                K.objectValue = Shared.instance.K
                M.objectValue = Shared.instance.M
                N.objectValue = Shared.instance.N
                R.objectValue = Shared.instance.R
                h_r.objectValue = Shared.instance.h_r
                h_phi.objectValue = Shared.instance.h_phi
                tau.objectValue = Shared.instance.tau
                Position.objectValue = Double(Shared.instance.actuatorIndex) / Double(Shared.instance.M)
                Accuracy.objectValue = Shared.instance.accuracy
            } catch {
                let alert = NSAlert()
                alert.messageText = "Ошибка чтения файла"
                alert.informativeText = "Проверьте правильность его заполнения"
                alert.alertStyle = .critical
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        }
    }
    
    @IBOutlet var T: NSTextField!
    @IBOutlet var K: NSTextField!
    @IBOutlet var M: NSTextField!
    @IBOutlet var N: NSTextField!
    @IBOutlet var R: NSTextField!
    @IBOutlet var h_r: NSTextField!
    @IBOutlet var h_phi: NSTextField!
    @IBOutlet var tau: NSTextField!
    @IBOutlet var Position: NSTextField!
    @IBOutlet var Accuracy: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
