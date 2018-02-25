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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
