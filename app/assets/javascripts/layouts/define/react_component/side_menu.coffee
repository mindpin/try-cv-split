React = require 'react'

SideMenu = React.createClass
  render: ->
    current_path = @props.current_path
    <div className='ui vertical pointing menu'>
    {
      if current_path is '/books'
        <a className='active item' href='/books'>Books</a>
      else
        <a className='item' href='/books'>Books</a>
    }
    </div>

module.exports = SideMenu
