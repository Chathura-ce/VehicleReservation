package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.Event;
import com.stripe.model.checkout.Session;
import com.stripe.net.Webhook;

@WebServlet("/stripe-webhook")
public class StripeWebhookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set your Stripe secret webhook signing key (you’ll get this from Stripe Dashboard)
        String endpointSecret = "whsec_XXXXXXXXXXXXXXXXXXXX";

        String payload = request.getReader().lines()
                .reduce("", (accumulator, actual) -> accumulator + actual);

        String sigHeader = request.getHeader("Stripe-Signature");
        Event event;

        try {
            event = Webhook.constructEvent(
                    payload, sigHeader, endpointSecret
            );
        } catch (SignatureVerificationException e) {
            // Invalid signature
            response.setStatus(400);
            return;
        }

        // Handle the event
        if ("checkout.session.completed".equals(event.getType())) {
            // Payment completed
            Session session = (Session) event.getDataObjectDeserializer().getObject().get();

            String sessionId = session.getId();
            String customerEmail = session.getCustomerDetails().getEmail();

            // ✅ Update booking/payment status in your database here
            // You can link using metadata or sessionId

            System.out.println("Payment Successful! Session ID: " + sessionId);
        }

        response.setStatus(200);
    }
}

