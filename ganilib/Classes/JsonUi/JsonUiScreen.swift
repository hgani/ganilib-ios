public class JsonUiScreen: GScreen {
    private let url:String
    
    // NOTE: Test code for pager
//    private var swipeController: SwipeController!
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = .darkGray
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()

    private let collectionView = GCollectionView()
        .layout(GCollectionViewFlowLayout().horizontal())
        .width(.matchParent)
        .height(300)
        .color(bg: .red)
    
    init(url: String) {
        self.url = url
        super.init()
    }
    
    convenience public init(path: String) {
        self.init(url: "\(GHttp.instance.host())/\(path)")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        onRefresh()
    }
    
    
    public override func onRefresh() {
        _ = Rest.get(url: url).execute { response in
            JsonUi.parseScreen(response.content, screen: self)
            return true
        }
    }

    // NOTE: Test code for pager
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView.register(CustomSwipeCell.self, forCellWithReuseIdentifier: "collectionViewCell")
//
//        container.content.addView(collectionView
//            .source(self)
//            .pagingEnabled(true)
//            .pager(pageControl))
//
//        collectionView.addSubview(pageControl)
//        pageControl.snp.makeConstraints { (c) in
//            c.bottom.equalTo(view.snp.bottom)
//            c.leading.equalTo(view.snp.leading)
//            c.trailing.equalTo(view.snp.trailing)
//            c.height.equalTo(50)
//        }
//    }
//    
//    public static func process(spec: Json, for screen: GScreen)  {
//        initVerticalPanel(screen.container.header, spec: spec["header"], screen: screen)
//        initVerticalPanel(screen.container.content, spec: spec["content"], screen: screen)
//        initVerticalPanel(screen.container.footer, spec: spec["footer"], screen: screen)
//        JsonAction.execute(spec: spec["onLoad"], screen: screen, creator: nil)
//    }
//    
//    private static func initVerticalPanel(_ panel: GVerticalPanel, spec: Json, screen: GScreen) {
//        _ = JsonView_Panels_VerticalV1(panel, spec, screen).createView()
//    }
}

// NOTE: Test code for pager
//extension JsonUiScreen: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
//        cell.backgroundColor = indexPath.row % 2 == 0 ? .blue : .red
//        return cell
//    }
//}
