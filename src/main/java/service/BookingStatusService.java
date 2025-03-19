package service;

import dao.BookingDAO;
import dao.BookingStatusDAO;
import model.BookingStatus;

public class BookingStatusService {
    private final BookingStatusDAO bookingStatusDAO;
    public BookingStatusService() {
         bookingStatusDAO = new BookingStatusDAO();
    }

    public BookingStatus getBookingStatusById(int statusId) {
        return bookingStatusDAO.selectBookingStatus(statusId);
    }

}
