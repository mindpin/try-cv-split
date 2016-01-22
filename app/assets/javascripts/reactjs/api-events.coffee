@APILink = React.createClass
  render: ->
    <a className={@props.className} href='javascript:void(0)' onClick={@click}>
    {@props.children}
    </a>

  click: ->
    if @props.to
      path = @props.to[0]
      params = @props.to[1]
      api.routes[path](params).visit()

@APIButton = React.createClass
  render: ->
    <APILink className='ui labeled icon button green' to={@props.to}>
    {@props.children}
    </APILink>