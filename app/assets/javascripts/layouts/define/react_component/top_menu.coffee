React = require 'react'

TopMenu = React.createClass
  render: ->
    <div className='ui fixed inverted menu'>
      <div className='ui container'>
        <a className='item' href='/'>TryCvSplit</a>
      </div>
    </div>

module.exports = TopMenu
