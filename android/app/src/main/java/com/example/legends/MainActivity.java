package com.example.legends;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.io.IOException;

import org.jivesoftware.smack.AbstractXMPPConnection;
import org.jivesoftware.smack.ConnectionConfiguration.SecurityMode;
import org.jivesoftware.smack.SmackException;
import org.jivesoftware.smack.SmackException.NotConnectedException;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.chat2.Chat;
import org.jivesoftware.smack.chat2.ChatManager;
import org.jivesoftware.smack.chat2.IncomingChatMessageListener;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.tcp.XMPPTCPConnection;
import org.jivesoftware.smack.tcp.XMPPTCPConnectionConfiguration;
import org.jxmpp.jid.EntityBareJid;
import org.jxmpp.jid.impl.JidCreate;
import org.jxmpp.stringprep.XmppStringprepException;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "test.flutter.legends/sendMessage";

  private static final int packetReplyTimeout = 500;
  private static String replyMessage;
  private static String replyFrom;
//	public static boolean newMessage = false;

  private String server;
  private int port;

  private String username;
  private EntityBareJid friendJid;

  private XMPPTCPConnectionConfiguration config;
  private AbstractXMPPConnection connection;

  private ChatManager chatManager;
  private Chat chat;

  public void tryConnect() throws SmackException, IOException, XMPPException, InterruptedException  {
     config = XMPPTCPConnectionConfiguration.builder()
            .setUsernameAndPassword("bot","qwerty")
            .setXmppDomain("legends.com")
            .setHostAddressByNameOrIp("172.25.173.138")
            .setSecurityMode(SecurityMode.disabled)
            .setPort(5222)
            .setConnectTimeout(500)
            .setSendPresence(false)
            .build();

    connection = new XMPPTCPConnection(config);
    connection.connect(); //Establishes a connection to the server
    System.out.println("connected...");
    connection.login(); //Logs in
    System.out.println("logged in...");

    chatManager = ChatManager.getInstanceFor(connection);
    friendJid = JidCreate.entityBareFrom("k4droid3@legends.com");
    chat = chatManager.chatWith(friendJid);

    chat.send("ye to chal gaya");
    chatManager.addIncomingListener(new IncomingChatMessageListener() {
      @Override
      public void newIncomingMessage(EntityBareJid from, Message message, Chat chat) {
//  			  return message.getBody();
//  		      System.out.println("New message from " + from + ": " + message.getBody());
        replyMessage = message.getBody();
        replyFrom = message.getFrom().toString();
      }
    });
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                    (call, result) -> {
                      if (call.method.equals("sendMessage")){
                        //String message = getMessage();  //TODO
                        try {
                          tryConnect();
                        } catch (SmackException e) {
                          e.printStackTrace();
                        } catch (IOException e) {
                          e.printStackTrace();
                        } catch (XMPPException e) {
                          e.printStackTrace();
                        } catch (InterruptedException e) {
                          e.printStackTrace();
                        }
                        try {
                          final String lel = call.argument("message_flutter");
                          chat.send(lel);
                        } catch (NotConnectedException e) {
                          e.printStackTrace();
                        } catch (InterruptedException e) {
                          e.printStackTrace();
                        }
                      }
                    }
            );
  }

  private String getMessage() {
    return "Message from Java";
  }
}
