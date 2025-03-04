package util;

import exception.ValidationException;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {
        // Method to convert String to MySQL DATETIME format (yyyy-MM-dd HH:mm:ss)
        public static String formatDateTime(String dateString) throws ValidationException {
            // Define the input format pattern (adjust this format based on your input string format)
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            if(dateString.isEmpty()){
                return  "";
            }
            try {
                // Parse the input string into a Date object
                Date date = inputFormat.parse(dateString);

                // Format the Date object into MySQL DATETIME format
                return outputFormat.format(date);
            } catch (Exception e) {
                // Handle errors during parsing or formatting
                return null;  // Return null if there's an error
            }
        }
}
