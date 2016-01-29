React = require 'react'
APILink = require "react/components/base/api_link"
DataTable = require "react/components/base/data_table"

Index = React.createClass
  render: ->
    columns =
      title:
        title: 'Title'
      body:
        title: 'Body'
      published:
        title: 'Published'
        render: (value)->
          if value
            <span className='ui green tiny header'>Yes</span>
          else
            <span className='ui red tiny header'>No</span>
      ops:
        title: ''
        renders: [
          (value, item)->
            <APILink to={['book', item]}>Show</APILink>
          (value, item)->
            <APILink to={['edit_book', item]}>Edit</APILink>
          (value, item)->
            <a href='javascript:;' onClick={@destroy}>Destroy</a>
        ]


    <div>
      <h1>Listing Books</h1>
      <DataTable data={@props.data} columns={columns} />
      <APILink className='ui labeled icon button green' to={['new_book']}>
        <i className='icon add' /> New Book
      </APILink>
    </div>

module.exports = Index
