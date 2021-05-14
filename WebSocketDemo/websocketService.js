
/*
var WebSocketServer = require('ws').Server,

wss = new WebSocketServer({ port: 7272 });
wss.on('connection', function (ws) {
    console.log('client connected');
    ws.send('你是第' + wss.clients.length + '位');  
    //收到消息回调
    ws.on('message', function (message) {
        console.log(message);
    	ws.send('收到:'+message);  
    });
    // 退出聊天  
    ws.on('close', function(close) {  
      	console.log('退出连接了');  
    });

    ws.on('pong', function(){
      console.log('pong'); 
    }); 
});
console.log('开始监听7272端口');
*/


const WebSocket = require('ws');

function noop() {}

function heartbeat() {
  this.isAlive = true;
}

const wss = new WebSocket.Server({ port: 7272 });

wss.on('connection', function connection(ws) {
  ws.isAlive = true;
  ws.on('pong', heartbeat);
    console.log('client connected');
    ws.send('你是第' + wss.clients.length + '位');  
    //收到消息回调
    ws.on('message', function (message) {
        console.log(message);
    	ws.send('收到:'+message);  
    });
});

const interval = setInterval(function ping() {
  wss.clients.forEach(function each(ws) {
    if (ws.isAlive === false) return ws.terminate();

    ws.isAlive = false;
    ws.ping(noop);
  });
}, 30000);

wss.on('close', function close() {
  clearInterval(interval);
  console.log('退出连接了');
});