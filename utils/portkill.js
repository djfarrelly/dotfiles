#!/usr/bin/env node
const child_process = require("child_process")
const port = process.argv.pop()

child_process.exec(`lsof -i:${port}`, (err, stdout, stderr) => {
  if (err) {
    console.log(`Nothing found running on port ${port}`)
    process.exit(0)
  }
  // Get all output lines, remove the headers
  const lines = stdout.split("\n").slice(1)
  const processes = lines
    .map((line) => {
      const cols = line.split(/\s+/)
      const command = cols[0]
      const pid = cols[1]
      const name = cols[cols.length - 1]
      return { command, pid, name }
    })
    .filter((p) => !!p.pid)
    .reduce((unique, p) => {
      if (!unique.find((u) => u.pid === p.pid)) {
        unique.push(p)
      }
      return unique
    }, [])

  processes.forEach((p) => {
    child_process.exec(`kill -9 ${p.pid}`, (err, stdout, stderr) => {
      if (err) {
        console.log(`Failed to kill ${p.command} (PID:${p.pid}) - ${p.name}`)
      }
      console.log(`Killed ${p.command} (PID:${p.pid}) - ${p.name}`)
    })
  })
})
