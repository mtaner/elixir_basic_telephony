import EventEmitter from 'events'

import { sendCommand } from './utils'

const emitter = new EventEmitter()

export default {
  on (...args) {
    emitter.on(...args)
  },

  setup (username) {
    setupDevice(username)
  },

  hangup (conference_key) {
    if (!window.Twilio.Device.activeConnection()) return
    sendCommand('hangup', {
      call_sid: window.Twilio.Device.activeConnection().parameters['CallSid'],
      conference_key: conference_key
    })
  }
}

window.Twilio.Device.ready((device) => {
  device.audio.incoming(false)
  emitter.emit('ready')
})

window.Twilio.Device.offline(setupDevice)

window.Twilio.Device.incoming((connection) => {
  connection.accept()
  emitter.emit('connected')
})

window.Twilio.Device.disconnect((status) => {
  emitter.emit('disconnected')
})

window.Twilio.Device.error((error) => {
  // Ignore token expired errors
  if (error.code !== 31205) {
    throw new Error(error.message)
  }
})

function getToken (username) {
  return window.fetch(`/token?username=${username}`).then((response) => {
    return response.json().then((json) => json.token)
  })
}

function setupDevice (username) {
  getToken(username).then((token) => {
    window.Twilio.Device.setup(token, {
      debug: true,
      region: 'ie1',
      closeProtection: true
    })
  })
}
