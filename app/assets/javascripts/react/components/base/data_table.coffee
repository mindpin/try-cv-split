React = require 'react'
Store = require "react/stores/base/store"
Actions = require "react/actions/base/action"

get_state = (model)->
  list: Store.all(model)

DataTable = React.createClass
  getInitialState: ->
    get_state(@props.model)

  componentDidMount: ->
    Store.add_change_listener @_on_change

  componentWillUnmount: ->
    Store.remove_change_listener @_on_change

  _on_change: ->
    @setState get_state(@props.model)

  render: ->
    <table className='ui celled table'>
      <DataTable.THead columns={@props.columns} />
      <DataTable.TBody model={@props.model} data={@state.list} columns={@props.columns}/>
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
      render: ->
        <tbody>
        {
          for item, idx in @props.data
            <DataTable.Tr model={@props.model} key={idx} item={item} columns={@props.columns} />
        }
        </tbody>

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
                  _value = _render value, ditem, @
                  <td key={_key}>{_value}</td>

              else if c.render?
                _value = c.render value, ditem, @
                <td key={key}>{_value}</td>
              else
                <td key={key}>{value}</td>

          }
        </tr>

      show: ->
        api.routes[@props.model](@props.item).visit()

      edit: ->
        api.routes["edit_#{@props.model}"](@props.item).visit()

      destroy: ->
        if confirm 'Are you sure?'
          api.routes[@props.model](@props.item).delete()
            .done =>
              Actions.destroy(@props.model, @props.item)

module.exports = DataTable
