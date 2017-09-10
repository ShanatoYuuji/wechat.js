# WECHAT.JS [![](https://img.shields.io/github/release/Ericlong/wechat.js.svg?style=flat-square)](https://github.com/Ericlong233/wechat.js/releases) [![license](https://img.shields.io/github/license/Ericlong233/wechat.js.svg?style=flat-square)](https://github.com/Ericlong233/wechat.js/blob/master/LICENSE)

*This is temporarily an uncompleted project. You can star it or watch it to show your interest of this project.*

WeChat.js is a [WeChat for Web](https://web.wechat.com/) API wrapper for Node.js, written in CoffeeScript.

### Installation

* Install in NPM (recommended)

  `npm install wechatjs --save`

* Install from source code

  *To be written*

### Usage

Here's a piece of code that tells you basic usage of WeChat.js (in Javascript):

```javascript
// Import the module
let WeChat = require("wechatjs")

// Initiate the bot
let bot = new WeChat()

bot.on("ready", () => {

  // Search for a male friend nicknamed "Ericlong"
  let friend = bot.search({
    name: "Ericlong"
      sex: 0
  })

  friend.send("Hello, world!")          // Send text
  friend.sendImg("path/to/your/img")    // Send image

  // Respond messages
  // Print all incoming messages
  bot.listen("all", (contact, msg) => {
    console.log(`${contact.nickname} sent a message: ${msg}`)
  })
  // Reply friend's messages
  bot.listen(friend, (msg) => {
    if (msg === "Hello") {
      friend.send(`Hello, ${friend.nickname}!`)
    }
  })

})
```

### License

This project is protected by [The MIT License](https://opensource.org/licenses/MIT). See [LICENSE](https://github.com/Ericlong233/wechat.js/blob/master/LICENSE) for more detail.
