import GaniLib

class StartingScreen: GScreen {
    override func viewDidLoad() {
        super.viewDidLoad()

        nav.push(AnimationScreen(), animated: false)
    }
}
