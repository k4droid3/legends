// This file is not added in AndroidManifest.xml

package com.example.legends;

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

public class XMPPManager {
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

    public XMPPManager(String server, int port) {
        this.server = server;
        this.port = port;
    }

    public void configure(String username, String password, String domain) throws XmppStringprepException {
        this.username = username;
        config = XMPPTCPConnectionConfiguration.builder()
                .setUsernameAndPassword(username, password)
                .setXmppDomain(domain)
                .setHostAddressByNameOrIp(server)
                .setSecurityMode(SecurityMode.disabled)
                .setPort(port)
                .setConnectTimeout(packetReplyTimeout)
                .setSendPresence(false)
                .build();

    }

    public void login() throws SmackException, IOException, XMPPException, InterruptedException {
        System.out.println(String.format("Initializing connection to server %1$s port %2$d", server, port));
        connection = new XMPPTCPConnection(config);
        connection.connect();
        System.out.println("Connected!");
        System.out.println("Attempting Login...");
        connection.login();
        System.out.println("Login successful!");
    }

    public void startChatWith(String jid) throws XmppStringprepException {
        chatManager = ChatManager.getInstanceFor(connection);
        friendJid = JidCreate.entityBareFrom(jid);
        chat = chatManager.chatWith(friendJid);
        this.startListener();
    }

    public void sendMessage(String message) throws NotConnectedException, InterruptedException {
        chat.send(message);
    }

    private void startListener() {
        chatManager.addIncomingListener(new IncomingChatMessageListener() {
            @Override
            public void newIncomingMessage(EntityBareJid from, Message message, Chat chat) {
                replyMessage = message.getBody();
                replyFrom = message.getFrom().toString();
//				newMessage = true;
                newMessage();
            }
        });
    }

    private void newMessage() {
//		if (newMessage) {
        System.out.println(String.format("\nMessage from %1$s:", replyFrom));
        System.out.println("\t" + replyMessage);
//			newMessage=false;
//		}
    }

    public void destroy() {
        if (connection != null && connection.isConnected()) {
            connection.disconnect();
        }
    }
}
