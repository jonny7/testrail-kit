extension Array where Element: FilterRepresentable {
    var queryParams: String {
        return self.reduce("", { a, b in
            return a + b.queryParams
        })
    }
}
