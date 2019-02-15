import GaniLib

class ViewController: GScreen {
    override func viewDidLoad() {
        super.viewDidLoad()

        nav.push(AnimationScreen(), animated: false)
    }
}
