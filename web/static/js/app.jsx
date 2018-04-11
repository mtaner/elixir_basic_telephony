import React from 'react'

import Login from './login'
import Dialler from './dialler'

import { sendCommand } from './utils'
import TwilioDevice from './twilio_device'

export default class App extends React.Component {
  constructor () {
    super()
    this.state = {
      username: '',
      connected: false,
      ready: false,
      conference_key: null,
    }
  }

  componentDidMount () {
    TwilioDevice.on('ready', () => {
      this.setState({ ready: true })
    })

    TwilioDevice.on('connected', () => {
      this.setState({ connected: true })
    })

    TwilioDevice.on('disconnected', () => {
      this.setState({
        connected: false,
        conference_key: null
      })
    })
  }

  register (username) {
    this.setState({ username: username })
    TwilioDevice.setup(username)
  }

  dial (phoneNumber) {
    let conferenceKey = Math.floor(Date.now() / 1000)
    sendCommand('dial', {
      username: this.state.username,
      phone_number: phoneNumber,
      conference_key: conferenceKey
    })
    this.setState({conference_key: conferenceKey})
  }

  hangup () {
    TwilioDevice.hangup(this.state.conference_key)
  }

  render () {
    return (
      <div className="jumbotron row align-items-center justify-content-center">
        {this.state.ready ? (
          <Dialler connected={this.state.connected}
            onDial={this.dial.bind(this)}
            onHangup={this.hangup.bind(this)} />
        ) : (
          <Login onRegister={this.register.bind(this)} />
        )}
      </div>
    )
  }
}
