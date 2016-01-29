ReactComponents =
  UnrealizedView: require 'react/components/base/unrealized_view'
  Layout:
    SideMenu: require 'react/components/layouts/side_menu'
    TopMenu:  require 'react/components/layouts/top_menu'
  Views:
    Book:
      Index: require 'react/components/books/index'
      Show: require 'react/components/books/show'

module.exports = ReactComponents
