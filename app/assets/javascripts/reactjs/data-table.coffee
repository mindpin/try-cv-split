@DataTable = React.createClass
  render: ->
    <table className='ui celled table'>
      <DataTable.THead columns={@props.columns} />
      <DataTable.TBody data={@props.data} columns={@props.columns}/>
    </table>

  statics:
    THead: React.createClass
      render: ->
        <thead><tr>
          {
            for key, c of @props.columns
              if c.renders?
                <th key={key} colSpan={c.renders.length}>{c.title}</th>
              else
                <th key={key}>{c.title}</th>
          }
        </tr></thead>

    TBody: React.createClass
      getInitialState: ->
        data: @props.data
      render: ->
        <tbody>
        {
          for item, idx in @state.data
            <DataTable.Tr key={idx} item={item} columns={@props.columns} parent={@} />
        }
        </tbody>

      destroy: (item)->
        api.routes.book(item).delete()
          .done =>
            data = @state.data
            data = data.filter (x)-> x.id != item.id
            @setState data: data

    Tr: React.createClass
      render: ->
        <tr>
          {
            for key, c of @props.columns
              ditem = @props.item
              value = ditem[key]

              if c.renders?
                for _render, idx in c.renders
                  _key = "#{key}_#{idx}"
                  _value = _render value, ditem
                  <td key={_key}>{_value}</td>

              else if c.render?
                _value = c.render value, ditem
                <td key={key}>{_value}</td>
              else
                <td key={key}>{value}</td>
                
          }
        </tr>

      show: ->
        api.routes.book(@props.item).visit()

      edit: ->
        api.routes.edit_book(@props.item).visit()

      destroy: ->
        if confirm 'Are you sure?'
          @props.parent.destroy(@props.item)