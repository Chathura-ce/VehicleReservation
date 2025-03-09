<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Mega City Cab</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .booking-header {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/placeholder.svg?height=400&width=1600');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 60px 0;
        }
        .payment-method-card {
            transition: all 0.3s;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .payment-method-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .payment-method-card.selected {
            border-color: #ffc107;
            background-color: rgba(255, 193, 7, 0.1);
        }
        .payment-info-tag {
            display: inline-block;
            padding: 4px 10px;
            margin-right: 5px;
            margin-bottom: 5px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .payment-logo {
            height: 40px;
            object-fit: contain;
        }
        .card-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .booking-summary-card {
            background-color: #f8f9fa;
            border-radius: 10px;
        }
        /* Card type identifier */
        .cc-type {
            position: absolute;
            right: 10px;
            top: 10px;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.html">
            <i class="fas fa-taxi me-2"></i>
            Mega City Cab
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.html#services">Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.html#about">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.html#contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active btn btn-warning text-dark ms-lg-3 px-4" href="booking.html">Book Now</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section class="py-5 bg-light" id="paymentSection">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark py-2">
                        <h4 class="mb-0">Payment Details</h4>
                    </div>
                    <div class="card-body p-3">
                        <!-- Booking Summary Section -->
                        <div class="card booking-summary-card mb-4">
                            <div class="card-header bg-light py-2">
                                <h5 class="mb-0">Booking Summary</h5>
                            </div>
                            <div class="card-body py-3">
                                <div class="row">
                                    <!-- Car Details -->
                                    <div class="col-md-5 mb-3 mb-md-0">
                                        <div class="text-center">
                                            <img src="${pageContext.request.contextPath}/images/car-5.jpg" id="selectedCarImage" class="img-fluid mb-2" alt="Selected Car" style="max-height: 100px;">
                                            <h5 class="mb-1" id="selectedCarName">Toyota Corolla</h5>
                                            <div class="d-flex justify-content-center flex-wrap">
                                                <span class="badge bg-primary m-1" id="selectedCarType">Sedan</span>
                                                <span class="badge bg-success m-1" id="selectedCarCapacity">4 Seats</span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Trip Details -->
                                    <div class="col-md-7">
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item bg-light px-0 py-1 d-flex justify-content-between">
                                                <span><i class="fas fa-map-marker-alt text-danger"></i> Pickup:</span>
                                                <span id="summaryPickup" class="text-end">Colombo Fort</span>
                                            </li>
                                            <li class="list-group-item bg-light px-0 py-1 d-flex justify-content-between">
                                                <span><i class="fas fa-map-marker-alt text-success"></i> Destination:</span>
                                                <span id="summaryDestination" class="text-end">Negombo</span>
                                            </li>
                                            <li class="list-group-item bg-light px-0 py-1 d-flex justify-content-between">
                                                <span><i class="fas fa-calendar"></i> Date & Time:</span>
                                                <span id="summaryDateTime" class="text-end">Mar 10, 2025 - 14:30</span>
                                            </li>
                                            <li class="list-group-item bg-light px-0 py-1 d-flex justify-content-between">
                                                <span><i class="fas fa-route"></i> Distance:</span>
                                                <span id="summaryDistance" class="text-end">35 km</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <!-- Fare Details -->
                                <div class="mt-3 pt-3 border-top">
                                    <h6 class="mb-2">Fare Breakdown</h6>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Base Fare:</span>
                                        <span id="summaryBaseFare">500 Rs</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Distance Charge (35 km):</span>
                                        <span id="summaryDistanceFare">1400 Rs</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tax (5%):</span>
                                        <span id="summaryTax">95 Rs</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between fw-bold">
                                        <span>Total Amount:</span>
                                        <span id="summaryTotal" class="text-warning">1995 Rs</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="cardPaymentForm" class="card mb-4" >
                            <div class="card-header bg-light py-2">
                                <h5 class="mb-0">Card Details</h5>
                            </div>
                            <div class="card-body py-3">
                                <form id="creditCardForm">
                                    <div class="position-relative mb-3">
                                        <label for="cardNumber" class="form-label">Card Number</label>
                                        <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456" required>
                                        <div class="cc-type"><i id="cardTypeIcon" class="far fa-credit-card"></i></div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="cardName" class="form-label">Cardholder Name</label>
                                            <input type="text" class="form-control" id="cardName" placeholder="John Smith" required>
                                        </div>

                                        <div class="col-md-3">
                                            <label for="expiryDate" class="form-label">Expiry Date</label>
                                            <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY" required>
                                        </div>

                                        <div class="col-md-3">
                                            <label for="cvv" class="form-label">CVV</label>
                                            <input type="text" class="form-control" id="cvv" placeholder="123" required>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>


                        <!-- Terms and Submit -->
                        <div>
                            <div class="form-check mb-3">
                               <%-- <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                <label class="form-check-label" for="termsCheck">
                                    I agree to the <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Terms and Conditions</a> and <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">Privacy Policy</a>
                                </label>--%>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <button type="button" id="backToBooking" class="btn btn-outline-secondary">Back to Booking</button>
                                <button type="button" id="processPayment" class="btn btn-warning px-4">Complete Payment</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="successModalLabel">Payment Successful</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center py-4">
                <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
                <h5 class="mt-4">Your booking has been confirmed!</h5>
                <p>Booking reference: <span id="bookingReference" class="fw-bold">MCC-25030910</span></p>
                <p>A confirmation email has been sent to your email address.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="window.location.href='index.html'">Return to Home</button>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white-50 py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="text-white mb-3">Mega City Cab</h5>
                <p>Your trusted cab service in Colombo City. Safe, reliable, and affordable transportation for all your needs.</p>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h5 class="text-white mb-3">Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="index.html" class="text-white-50">Home</a></li>
                    <li><a href="index.html#services" class="text-white-50">Services</a></li>
                    <li><a href="index.html#about" class="text-white-50">About Us</a></li>
                    <li><a href="index.html#contact" class="text-white-50">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h5 class="text-white mb-3">Services</h5>
                <ul class="list-unstyled">
                    <li><a href="booking.html" class="text-white-50">Book a Cab</a></li>
                    <li><a href="booking.html" class="text-white-50">Airport Transfer</a></li>
                    <li><a href="booking.html" class="text-white-50">Corporate Service</a></li>
                    <li><a href="booking.html" class="text-white-50">Long Distance</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="text-white mb-3">Contact Us</h5>
                <p class="mb-1"><i class="fas fa-map-marker-alt me-2 text-warning"></i> 123 Main Street, Colombo, Sri Lanka</p>
                <p class="mb-1"><i class="fas fa-phone me-2 text-warning"></i> +94 11 234 5678</p>
                <p class="mb-1"><i class="fas fa-envelope me-2 text-warning"></i> info@megacitycab.com</p>
            </div>
        </div>
        <hr class="my-4 bg-secondary">
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; 2025 Mega City Cab. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <a href="#" class="text-white-50 me-3">Privacy Policy</a>
                <a href="#" class="text-white-50 me-3">Terms of Service</a>
                <a href="#" class="text-white-50">FAQ</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>
    // Set today's date as minimum date for the booking
    document.addEventListener('DOMContentLoaded', function() {
        // Function to select payment method
        window.selectPaymentMethod = function(method) {
            // Remove selected class from all payment method cards
            document.querySelectorAll('.payment-method-card').forEach(card => {
                card.classList.remove('selected');
            });

            // Hide all payment forms
            document.getElementById('cardPaymentForm').style.display = 'none';
            document.getElementById('mobilePaymentForm').style.display = 'none';
            document.getElementById('cashPaymentForm').style.display = 'none';

            // Add selected class to the chosen payment method
            document.getElementById(method + 'Payment').classList.add('selected');

            // Show the corresponding payment form
            document.getElementById(method + 'PaymentForm').style.display = 'block';
        };

        // Back to booking button
        document.getElementById('backToBooking').addEventListener('click', function() {
            window.location.href = 'booking.html';
        });

        // Process payment button
        document.getElementById('processPayment').addEventListener('click', function() {
            if (!document.getElementById('termsCheck').checked) {
                alert('Please agree to the Terms and Conditions to proceed.');
                return;
            }

            // Show success modal
            var successModal = new bootstrap.Modal(document.getElementById('successModal'));
            successModal.show();
        });

        // Credit card type detection
        document.getElementById('cardNumber').addEventListener('input', function() {
            let cardNumber = this.value.replace(/\s+/g, '');
            let cardIcon = document.getElementById('cardTypeIcon');

            // Basic card type detection based on first digits
            if (cardNumber.startsWith('4')) {
                cardIcon.className = 'fab fa-cc-visa';
            } else if (/^5[1-5]/.test(cardNumber)) {
                cardIcon.className = 'fab fa-cc-mastercard';
            } else if (/^3[47]/.test(cardNumber)) {
                cardIcon.className = 'fab fa-cc-amex';
            } else if (/^6(?:011|5)/.test(cardNumber)) {
                cardIcon.className = 'fab fa-cc-discover';
            } else {
                cardIcon.className = 'far fa-credit-card';
            }

            // Format card number with spaces
            let formattedNumber = '';
            for (let i = 0; i < cardNumber.length; i++) {
                if (i > 0 && i % 4 === 0) {
                    formattedNumber += ' ';
                }
                formattedNumber += cardNumber[i];
            }
            this.value = formattedNumber;
        });

        // Format expiry date
        document.getElementById('expiryDate').addEventListener('input', function() {
            let expiry = this.value.replace(/\D/g, '');
            if (expiry.length > 2) {
                this.value = expiry.substring(0, 2) + '/' + expiry.substring(2, 4);
            } else {
                this.value = expiry;
            }
        });

        // Format CVV - numbers only
        document.getElementById('cvv').addEventListener('input', function() {
            this.value = this.value.replace(/\D/g, '').substring(0, 3);
        });

        // Format mobile number
        document.getElementById('mobileNumber').addEventListener('input', function() {
            let mobile = this.value.replace(/\D/g, '');
            if (mobile.length > 2 && mobile.length <= 5) {
                this.value = mobile.substring(0, 2) + ' ' + mobile.substring(2);
            } else if (mobile.length > 5) {
                this.value = mobile.substring(0, 2) + ' ' + mobile.substring(2, 5) + ' ' + mobile.substring(5, 9);
            } else {
                this.value = mobile;
            }
        });

        // Select card payment method by default
        selectPaymentMethod('card');
    });
</script>
</body>
</html>