var AllUsers = React.createClass({
  getInitialState() {
    return { users: [] }
  },

  componentDidMount() {
    $.getJSON('/api/users.json', (response) => { this.setState({ users: response }) });
    console.log('Component Mounted');
  },

  render() {
    var users = this.state.users.map((user) => {
      return (
        <div key={user.id}>
          <h3>{user.email}</h3>
          <p>{user.role}</p>
        </div>
      )
    });

    return (
      <div>
        { users }
      </div>
    )
  }
});
