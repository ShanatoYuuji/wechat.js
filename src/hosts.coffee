#
# W E C H A T . J S
#

module.exports =
  login:
    getUUID:      'https://login.weixin.qq.com/jslogin'
    showQRCode:   'https://login.weixin.qq.com/qrcode/'
    waitForLogin: 'https://login.weixin.qq.com/cgi-bin/mmwebwx-bin/login'
    getCookie:    'https://wx2.qq.com/cgi-bin/mmwebwx-bin/webwxnewloginpage'
  init:
    wxInit:     'https://wx2.qq.com/cgi-bin/mmwebwx-bin/webwxinit'
    openNotify: 'https://wx2.qq.com/cgi-bin/mmwebwx-bin/webwxstatusnotify'
