import React from 'react'

export default class Login extends React.Component {
  constructor () {
    super()
    this.state = { username: '' }
  }

  handleChange (e) {
    this.setState({
      username: e.target.value.replace(/[^a-z]/, '')
    })
  }

  handleSubmit (e) {
    e.preventDefault()
    this.props.onRegister(this.state.username)
  }

  render () {
    return (
      <form className="login" onSubmit={this.handleSubmit.bind(this)}>
        <div className="input-group input-group-lg">
          <input type="text"
            className="form-control"
            required
            autoFocus
            placeholder="Choose a username"
            onChange={this.handleChange.bind(this)} />
          <div className="input-group-append">
            <button className="btn btn-primary" type="submit">Register</button>
          </div>
        </div>
      </form>
    )
  }
}
