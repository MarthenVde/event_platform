// import consumer from "./consumer"

// consumer.subscriptions.create({ channel: "CompanyChannel" }, {
//   // Called once when the subscription is created.
//   initialized() {
//     console.log("Initialised!")
//     this.start_chat = this.start_chat.bind(this)
//   },
//   connected() {
//     // Called when the subscription is ready for use on the server
//     console.log("Connected!")
//     this.install()
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//     console.log("disconnected!")
//     document.getElementById("chat-message-box").hidden = true
//     document.getElementById("join-chat").hidden = false
//     document.getElementById("send-message").hidden = true
//   },
//   install() {
//     document.getElementById("join-chat").addEventListener("click", this.start_chat); 
//     //document.getElementById("send-message").addEventListener("click", this.clear_message_box); 
//   },
//   start_chat() {

//     console.log("Subscribing to chat!")
//     // Calls `CompanyChannel#subscribe(data)` on the server.
//     document.getElementById("join-chat").hidden = true
//     this.perform("subscribe", { roomId: document.getElementById("company").value, userId: document.getElementById("user").value })
//     document.getElementById("send-message").hidden = false
//     document.getElementById("chat-message-box").hidden = false
//   },
//   clear_message_box() {
//     console.log("Clear Message box!")
//     document.getElementById("message").value = ""
//   },
//   received(data) {
//     var node = document.createElement("div"); 
//     node.className = 'chat-container'

//     if (data.content.message != "") {
//       var message_node = document.createTextNode(data.content.user + ": " + data.content.message); 
//       //node.id = data.content.id;
//       node.appendChild(message_node); 

//       var timestamp = new Date().toLocaleTimeString();

//       var time_node = document.createElement("span"); 
//       time_node.className = 'time-right';
//       var time_node_time = document.createTextNode(timestamp); 
//       time_node.appendChild(time_node_time);
//       node.appendChild(time_node);

//       document.getElementById("new_message").appendChild(node);
//     }
//     //document.getElementById('chat_message').value= ''

//     // Called when there's incoming data on the websocket for this channel
//   }
  
// });


// /*
//   <div class="chat-container">
//     <img src="https://via.placeholder.com/20.png" alt="Avatar">
//     <p>Hello. How are you today?</p>
//     <span class="time-right">11:00</span>
//   </div>

//   <div class="chat-container darker">
//     <img src="https://via.placeholder.com/20.png" alt="Avatar" class="right">
//     <p>Hey! I'm fine. Thanks for asking!</p>
//     <span class="time-left">11:01</span>
//   </div>
//   */
