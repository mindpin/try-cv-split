@DataTable = React.createClass
  render: ->
    <table className='ui celled table'>
      <DataTable.THead columns={@props.data_source.columns} />
      <DataTable.TBody data={@props.data_source.data} columns={@props.data_source.columns}/>
    </table>

  statics:
    THead: React.createClass
      render: ->
        <thead><tr>
          {
            for column, name of @props.columns
              <th key={column}>{name}</th>
          }
          <th colSpan='3'></th>
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
            for column, name of @props.columns
              <td key={column}>{@props.item[column] + ''}</td>
          }
          <td>
            <a href='javascript:;' onClick={@show}>Show</a>
          </td>
          <td>
            <a href='javascript:;' onClick={@edit}>Edit</a>
          </td>
          <td>
            <a href='javascript:;' onClick={@destroy}>Destroy</a>
          </td>
        </tr>

      show: ->
        api.routes.book(@props.item).visit()

      edit: ->
        api.routes.edit_book(@props.item).visit()

      destroy: ->
        if confirm 'Are you sure?'
          @props.parent.destroy(@props.item)