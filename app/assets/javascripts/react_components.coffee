ReactComponents =
  UnrealizedView: require 'base/define/react_component/unrealized_view'
  Layout:
    SideMenu: require 'layouts/define/react_component/side_menu'
    TopMenu:  require 'layouts/define/react_component/top_menu'
  Views:
    Book:
      Index: require 'books/define/react_component/index'
      Show: require 'books/define/react_component/show'
      
module.exports = ReactComponents
