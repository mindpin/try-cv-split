Views?.Book?.Index = React.createClass
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
      <APIButton to={['new_book']}>
        <i className='icon add' /> New Book
      </APIButton>
    </div>