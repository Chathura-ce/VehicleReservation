<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%@ page import="model.User" %>--%>
<%--<%@ page import="java.util.Objects" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mega City Cab - Official Receipt</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
        }

        .bill-container {
            background-color: white;
            border: 2px solid #333;
            border-radius: 10px;
            width: 500px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .bill-header {
            text-align: center;
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .bill-header h1 {
            color: #007bff;
            margin: 0;
            font-size: 24px;
        }

        .bill-details {
            margin-bottom: 20px;
        }

        .bill-details .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            border-bottom: 1px dotted #ddd;
            padding-bottom: 5px;
        }

        .bill-details .detail-row .label {
            font-weight: bold;
            color: #333;
        }

        .bill-details .detail-row .value {
            color: #666;
        }

        .bill-charges {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
        }

        .bill-charges .charge-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .bill-charges .total-amount {
            font-weight: bold;
            color: #007bff;
            font-size: 20px;
        }

        .bill-footer {
            text-align: center;
            margin-top: 20px;
            color: #888;
            font-size: 12px;
        }

        .button-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }

        .button-container button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            margin-left: 5px;
        }

        .button-container button:hover {
            background-color: #0056b3;
        }

        .close-btn {
            background-color: #dc3545;
        }

        .close-btn:hover {
            background-color: #a71d2a;
        }

        @media print {
            body {
                background-color: white;
            }
            .bill-container {
                border: none;
                box-shadow: none;
            }
            .button-container {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="bill-container">
    <div class="bill-header">
        <h1>MEGA CITY CAB</h1>
        <p>Official Receipt</p>
    </div>

    <div class="bill-details">
        <div class="detail-row">
            <span class="label">Booking Number</span>
            <span class="value">${booking.bookingNumber}</span>
        </div>
        <div class="detail-row">
            <span class="label">Customer Name</span>
            <span class="value">${booking.user.fullName}</span>
        </div>
        <div class="detail-row">
            <span class="label">Destination</span>
            <span class="value">${booking.destination}</span>
        </div>
        <div class="detail-row">
            <span class="label">Distance</span>
            <span class="value">${booking.distance}</span>
        </div>
        <div class="detail-row">
            <span class="label">Driver</span>
            <span class="value">${booking.driver.driverName}</span>
        </div>
        <div class="detail-row">
            <span class="label">Vehicle Number</span>
            <span class="value">${booking.carId}</span>
        </div>
        <div class="detail-row">
            <span class="label">Booking Date</span>
            <span class="value">${booking.formattedDate}<%--March 5, 2024 | 09:45 PM--%></span>
        </div>
    </div>

    <div class="bill-charges">
        <div class="charge-row">
            <span class="label">Base Charge</span>
            <span class="value">${baseCharge}</span>
        </div>
        <div class="charge-row">
            <span class="label">Distance Charge (${booking.distance} km x ${booking.priceForKm} Rs)</span>
            <span class="value">${distanceCharge}</span>
        </div>
        <div class="charge-row">
            <span class="label">Subtotal</span>
            <span class="value">${subTotal}</span>
        </div>
        <div class="charge-row">
            <span class="label">Tax (${taxPercentage}%)</span>
            <span class="value">${booking.calculateTax()}</span>
        </div>
        <div class="charge-row total-amount">
            <span class="label">Total Amount</span>
            <span class="value">${booking.getTotalAmount()}</span>
        </div>
    </div>

    <div class="bill-footer">
        <p>Thank you for choosing Mega City Cab!</p>
        <p>© 2024 Mega City Cab. All Rights Reserved.</p>
    </div>
    <div class="button-container">
        <button onclick="window.print()">Print Receipt</button>
        <button class="close-btn" onclick="window.close()">Close</button>
    </div>
</div>

</body>
</html>