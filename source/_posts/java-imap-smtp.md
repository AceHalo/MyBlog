title: Java使用Imap收邮件和Smtp发邮件
description: 简单记录下Java使用Imap收邮件和Smtp发邮件。
categories:
  - java
tags:
  - 教程
date: 2020-02-23 19:00:00
---
废话少说，直接上代码：


1. 常量部分：
    ```
    private final static String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
    private final static String USER_NAME = "xxx@xxx.com";
    private final static String PASSWORD = "xxx";

    private final static String SERVER_IMAP = "imap.xxx.com";
    private final static String PROTOCOL_IMAP = "imap";
    private final static Integer PORT_IMAP = 993;

    private final static String SERVER_SMTP = "smtp.xxx.com";
    private final static String PROTOCOL_SMTP = "smtp";
    private final static Integer PORT_SMTP = 465;
    ```


2. Imap收邮件：

    ```
    Properties props = new Properties();
    //设置协议 imap
    props.setProperty("mail.transport.PROTOCOL", PROTOCOL_IMAP);
    //设置 imap 服务地址
    props.setProperty("mail.imap.host", SERVER_IMAP);
    //使用加密连接方式
    props.setProperty("mail.imap.ssl.enable", "true");
    //此处的SSL_FACTORY为javax.net.ssl.SSLSocketFactory
    props.setProperty("mail.imap.socketFactory.class", SSL_FACTORY);
    Session session = Session.getInstance(props);
    //打印日志
    session.setDebug(true);
    Store store = session.getStore(PROTOCOL_IMAP);
    store.connect(SERVER_IMAP, PORT_IMAP, USER_NAME, PASSWORD);
    Folder folder = store.getFolder("INBOX");
    folder.open(Folder.READ_ONLY);
    Message[] messages = folder.getMessages();
    store.close();
    ```

3. Smtp发邮件：
    ```
    Properties props = new Properties();
    //设置协议 smtp
    props.setProperty("mail.transport.PROTOCOL", PROTOCOL_SMTP);
    //设置 smtp 服务地址
    props.setProperty("mail.smtp.host", SERVER_SMTP);
    //设置 smtp 服务端口
    props.setProperty("mail.smtp.port", String.valueOf(PORT_SMTP));
    //使用加密连接方式
    props.setProperty("mail.smtp.ssl.enable", "true");
    //此处的SSL_FACTORY为javax.net.ssl.SSLSocketFactory
    props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
    //需要认证
    props.setProperty("mail.smtp.auth", "true");

    Session session = Session.getDefaultInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(USER_NAME, PASSWORD);
        }
    });
    //打印日志
    session.setDebug(true);
    Message msg = new MimeMessage(session);
    //发件人
    msg.setFrom(new InternetAddress(USER_NAME));
    //收件人
    msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(USER_NAME, true));
    msg.setSubject(title);
    msg.setText(content);
    msg.setSentDate(new Date());
    Transport.send(msg);
    ```