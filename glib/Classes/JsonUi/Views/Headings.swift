class JsonView_Heading: JsonView {
    fileprivate let label = GLabel().width(.matchParent)

    override func initView() -> UIView {
        if let text = spec["text"].string {
            _ = label.text(text)
        }

        return label
    }
}

class JsonView_H1V1: JsonView_Heading {
    override func initView() -> UIView {
        super.initView()
        label.font(nil, size: 18, traits: .traitBold)
        return label
    }
}

class JsonView_H2V1: JsonView_Heading {
    override func initView() -> UIView {
        super.initView()
        label.font(nil, size: 16, traits: .traitBold)
        return label
    }
}

class JsonView_H2V3: JsonView_Heading {
    override func initView() -> UIView {
        super.initView()
        label.font(nil, size: 15, traits: .traitBold)
        return label
    }
}

class JsonView_H2V4: JsonView_Heading {
    override func initView() -> UIView {
        super.initView()
        label.font(nil, size: 14, traits: .traitBold)
        return label
    }
}

class JsonView_H2V5: JsonView_Heading {
    override func initView() -> UIView {
        super.initView()
        label.font(nil, size: 13, traits: .traitBold)
        return label
    }
}

class JsonView_H2V6: JsonView_Heading {
    override func initView() -> UIView {
        super.initView()
        label.font(nil, size: 12, traits: .traitBold)
        return label
    }
}
