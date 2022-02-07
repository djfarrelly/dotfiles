#!/usr/bin/env node
const input = process.argv.pop()
const flags = process.argv
  .filter((arg) => arg.startsWith("-"))
  .map((arg) => arg.slice(1).toLowerCase())
const shouldDecode = flags.includes("d")
const shouldPrettyPrint = flags.includes("p")
if (shouldDecode) {
  const buff = Buffer.from(input, "base64")
  const output = buff.toString("ascii")
  if (shouldPrettyPrint) {
    try {
      // Try to pretty-print JSON
      console.log(JSON.stringify(JSON.parse(output), null, 2))
      return
    } catch (e) {
      console.log("Could not pretty print JSON")
    }
  }
  console.log(output)
} else {
  const buff = Buffer.from(input)
  const output = buff.toString("base64")
  console.log(output)
}
