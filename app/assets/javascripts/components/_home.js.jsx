var Home = React.createClass({
  render: function() {
    return (
      <div className="container">
        <Navbar />
        <div className="jumbotron">
          <h1>Project Ubuntu</h1>
        </div>
        <div className="row">
          <div className="col-md-12">
            <ServicesTable />
          </div>
        </div>
      </div>
    )
  }
});
