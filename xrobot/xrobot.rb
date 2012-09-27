require 'xmpp4r'

class Bot
    include Jabber

    def initialize jid,jpassword
      @jid = jid
      @jpassword = jpassword

      @client = Client.new(JID::new(@jid))
      @client.connect("192.168.1.10")
      @client.auth(@jpassword)
      @client.send(Presence.new.set_type(:available))
      
      @client.add_message_callback do |msg|               
        if msg.from=="yanjh@yucai.im/P2" && msg.body=="exit"
          close
          exit
        end
        send_message(msg.from,"From "+jid+": Copied - "+msg.body)
      end
      
      #@client.add_update_callback do |presence|
        #if presence.from == "john@someserver.com" && presence.ask == :subscribe
        #client.send(presence.from, "I am so very happy you have accept my request John, you rock! I will spam you for the rest of my life, but I know you will understand because I feel we do 'connect'")
      #end

      puts "c0 is ready"
    end
    
    def send_message to,message
        msg = Message::new(to,message)
        msg.type = :chat
        @client.send(msg)
    end

    def add_user jid
      adding = Presence.new.set_type(:subscribe).set_to(jid)
      @client.send(adding)
    end
      
    def close
      @client.close
    end  
    
end

c0 = Bot.new('c0@yucai.im/bot','hello')
#c2 = Bot.new('c2@yucai.im/bot','hello')

Thread.new{sleep XMPP_REQUEST_TIMEOUT; Thread.current.wakeup;}
Thread.stop

#c0.close


