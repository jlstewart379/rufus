Rufus::Navigation.routes = {

    :default =>[HomePage],
    :to_exists => [
        [HomePage, :view_exists],
        [ExistsPage],
    ],
    :to_displayed => [
      [HomePage, :view_displayed],
      [DisplayedPage],
    ]
}