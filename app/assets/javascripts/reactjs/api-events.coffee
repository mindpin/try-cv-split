@APIButton = React.createClass
  render: ->
    <a className='ui labeled icon button green' onClick={@click}>
      <i className='icon add' /> New Book
    </a>

  click: ->
    if @props.visit
      path = @props.visit[0]
      params = @props.visit[1]
      api.routes[path](params).visit()