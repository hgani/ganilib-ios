import GaniLib

class AnimationScreen: GScreen {
    private let flagImage = GImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"

        flagImage
            .source(name: "SmallImage")
            .onClick { _ in
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                    self.flagImage.frame.origin.y = 0
                }, completion: nil)
            }
            .done()

        container.addSubview(flagImage)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let size = flagImage.image?.size {
            flagImage.bounds.size = size
            flagImage.frame.origin.x = 0
            flagImage.frame.origin.y = container.bounds.height - size.height
        }
    }
}
