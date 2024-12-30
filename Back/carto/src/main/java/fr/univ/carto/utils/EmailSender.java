package fr.univ.carto.utils;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSender {

    public void sendEmail(String to, String subject, String content, boolean html) {
        String host = "smtp.gmail.com";
        String email = "cartoapp.noreply@gmail.com";
        String appPassword = "ixfr brkz oksh czlt";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            if (html) {
                message.setContent(content, "text/html; charset=utf-8");
            } else  {
                message.setContent(content, "text/plain; charset=utf-8");
            }

            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void sendWelcomeEmail(String to, String userName) {
        sendEmail(
            to,
            "Bienvenue sur Carto !",
            "Cher/Chère " + userName + ",\n" +
                    "Merci d'avoir choisi Carto.\n" +
                    "Nous sommes ravis que vous rejoigniez notre communauté de passionnés de jeux de café !",
            false
        );
    }

    public void sendForgottenPassword(String to, String link) {
        sendEmail(
            to,
            "Mot de passe oublié !",
            "<h1>Bonjour,</h1>" +
                    "Vous avez demandé la réinitialisation du mot de passe de votre compte Carto " + to + ".\n" +
                    "Pour finaliser le processus, veuillez cliquer sur le bouton ci-dessous:</p>" +
                    "<a href=\"" + link + "\" style=\"display: inline-block; padding: 10px 20px; " +
                    "font-size: 16px; color: white; background-color: blue; text-align: center; " +
                    "text-decoration: none; border-radius: 5px;\">Changer mon mot de passe</a>" +
                    "<p>Si le lien ci-dessus ne fonctionne pas, copiez et collez le lien suivant dans votre navigateur :</p>" +
                    "<a href=\"" + link + "\">" + link + "</a>" +
                    "<p>Si vous rencontrez des problèmes pour vous connecter à Carto, contacter nous au cartoapp.contact@gmail.com</p>",
            true
        );
    }
}
