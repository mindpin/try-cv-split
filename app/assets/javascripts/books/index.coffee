@BooksIndexPage = React.createClass
  render: ->
    data_source =
      data: @props.data
      columns:
        title: 'Title'
        body: 'Body'
        published: 'Published' 

    <div>
      <h1>Listing Books</h1>
      <DataTable data_source={data_source} />
      <a className='ui labeled icon button green' onClick={@new_book}>
        <i className='icon add' /> New Book
      </a>
    </div>

  new_book: ->
    api.routes.new_book().visit()