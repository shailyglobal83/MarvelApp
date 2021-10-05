struct MarvelListRequestEntity {
    let offset: Int
    let limit: Int

    init(model: MarvelListConfigModel) {
        offset = model.offset
        limit = model.limit
    }
}
