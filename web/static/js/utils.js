export function sendCommand (command, payload) {
  return window.fetch(`/commands/${command}`, {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(payload)
  })
}
