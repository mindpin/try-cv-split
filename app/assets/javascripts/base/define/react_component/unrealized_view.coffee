React = require 'react'

UnrealizedView = React.createClass
  render: ->
    <div className='ui icon warning message'>
      <i className='icon settings'></i>
      <div className='content'>
        <div className='header'>
        {@props.name}
        </div>
        <p>页面尚未实现，请开发集成工程师注意</p>
      </div>
    </div>

module.exports = UnrealizedView
