public class JsonUiScreen: GScreen {
    private let url: String

    private let collectionView = GCollectionView()
        .layout(GCollectionViewFlowLayout().horizontal())
        .width(.matchParent)
        .height(300)
        .color(bg: .red)

    init(url: String) {
        self.url = url
        super.init()
    }

    public convenience init(path: String) {
        self.init(url: "\(GHttp.instance.host())/\(path)")
    }

    public required init?(coder _: NSCoder) {
        fatalError("Unsupported")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        onRefresh()
    }

    public override func onRefresh() {
        _ = Rest.get(url: url).execute { response in
            JsonUi.parseEntireScreen(response.content, screen: self)
            return true
        }
    }
}
