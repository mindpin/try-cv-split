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
      <APIButton visit={['new_book']} />
    </div>