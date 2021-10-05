protocol PresenterContract: AnyObject {
    func viewLoaded()
    func viewAppeared()
}

extension PresenterContract {
    func viewLoaded() { }
    func viewAppeared() { }
}
