@Layout =
  TopMenu: React.createClass
    render: ->
      <div className='ui fixed inverted menu'>
        <div className='ui container'>
          <a className='item' href='/'>TryCvSplit</a>
        </div>
      </div>

  SideMenu: React.createClass
    render: ->
      current_path = @props.current_path
      <div className='ui vertical menu'>
      {
        if current_path is '/books'
          <a className='active item' href='/books'>Books</a>
        else
          <a className='item' href='/books'>Books</a>
      }
      </div>
