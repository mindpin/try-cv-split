@APILink = React.createClass
  render: ->
    if @props.to
      path = @props.to[0]
      params = @props.to[1]
      url = api.routes[path](params).path
      
      <a className={@props.className} href={url}>
      {@props.children}
      </a>
    else
      <a className={@props.className} href='javascript:;'>
      {@props.children}
      </a>