extension GLabelSpec {
    static let libCellTitle = GLabelSpec() { label in
        _ = label.font(nil, size: 18, traits: .traitBold)
    }
    static let libCellSubtitle = GLabelSpec() { label in
        _ = label.font(nil, size: 14)
    }
}

