package fr.univ.carto.utils;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import com.auth0.jwt.exceptions.*;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;

import fr.univ.carto.exception.BadTokenException;



public class Token {
    private static final String SECRET_KEY_1 = "7Kt#9pLzX6vQo2bDy1GjF5sEwRmNcJhTtAqZ";
    private static final String SECRET_KEY_2 = "40KugkuhhlUGUF44dDI#V51EIVH345gfd7o0";
    private static final Algorithm algorithm_1 = Algorithm.HMAC256(SECRET_KEY_1);
    private static final Algorithm algorithm_2 = Algorithm.HMAC256(SECRET_KEY_2);

    public static String createCredential(String userNameOrMail, String password) {

        return JWT.create()
            .withClaim("userNameOrMail", userNameOrMail)
            .withClaim("password", password)
            .sign(algorithm_1);
    }
    
    public static String createToken(Long id) {
        LocalDateTime expirationDate = LocalDateTime.now().plusHours(1);

        return JWT.create()
                .withClaim("id", id)
                .withExpiresAt(Date.from(expirationDate.atZone(ZoneId.systemDefault())
                        .toInstant()))
                .sign(algorithm_2);
    }

    public static String[] decodedCredential(String credential) throws TokenExpiredException, BadTokenException {
        try {
            DecodedJWT decodedJWT = JWT.require(algorithm_1)
                    .build()
                    .verify(credential);
            return new String[]{decodedJWT.getClaim("userNameOrMail").asString(), decodedJWT.getClaim("password").asString()};
        } catch (TokenExpiredException exception) {
            throw exception;
        } catch (Exception exception) {
            throw new BadTokenException("invalid token");
        }
    }

    public static long decodedToken(String token) throws TokenExpiredException, BadTokenException {
        try {
            DecodedJWT decodedJWT = JWT.require(algorithm_2)
                    .build()
                    .verify(token);
            return decodedJWT.getClaim("id").asInt();
        } catch (TokenExpiredException exception) {
            throw exception;
        } catch (Exception exception) {
            throw new BadTokenException("invalid token");
        }
    }

}
