React = require 'react'
APILink = require "base/define/react_component/api_link"
DataTable = require "base/define/react_component/data_table"

Show = React.createClass
  render: ->
    book = @props.data
    <div>
      <BookItem data={book} />
      <div className='ui divider' />
      <APILink to={['edit_book', book]}>Edit</APILink>
      <span> | </span>
      <APILink to={['books']}>Back</APILink>
    </div>

BookItem = React.createClass
  render: ->
    book = @props.data
    <div>
      <p>
        <strong>Title: </strong>
        {book.title}
      </p>
      <p>
        <strong>Body: </strong>
        {book.body}
      </p>
      <p>
        <strong>Published: </strong>
        {book.published + ''}
      </p>
    </div>


module.exports = Show
