import React from 'react'

import { sendCommand } from './utils'

export default class Dialler extends React.Component {
  constructor () {
    super()
    this.state = {
      phoneNumber: ''
    }
  }

  handleChange (e) {
    this.setState({
      phoneNumber: e.target.value.replace(/^0/, '')
    })
  }

  handleSubmit (e) {
    e.preventDefault()
    this.props.onDial('+44' + this.state.phoneNumber)
  }

  handleHangup () {
    this.props.onHangup()
  }

  render () {
    return (
      <form className="dialler" onSubmit={this.handleSubmit.bind(this)}>
        <div className="input-group input-group-lg">
          <div className="input-group-prepend">
            <span className="input-group-text">+44</span>
          </div>
          <input type="text"
            className="form-control"
            autoFocus
            required
            disabled={this.props.connected}
            value={this.state.phoneNumber}
            onChange={this.handleChange.bind(this)} />
          <div className="input-group-append">
            {this.props.connected ? (
              <button className="btn btn-danger hangup-button"
                type="button"
                onClick={this.handleHangup.bind(this)}>
                Hang up
              </button>
            ) : (
              <button className="btn btn-primary call-button"
                type="submit">
                Call
              </button>
            )}
          </div>
        </div>
      </form>
    )
  }
}
