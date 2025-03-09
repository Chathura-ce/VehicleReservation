<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Book a Cab - Mega City Cab</title>
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
    .car-card {
      transition: all 0.3s;
      cursor: pointer;
      border: 2px solid transparent;
    }
    .car-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .car-card.selected {
      border-color: #ffc107;
      background-color: rgba(255, 193, 7, 0.1);
    }
    .filter-section {
      background-color: #f8f9fa;
      border-radius: 10px;
      padding: 20px;
    }
    .car-info-tag {
      display: inline-block;
      padding: 4px 10px;
      margin-right: 5px;
      margin-bottom: 5px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 500;
    }
    .car-type-tag {
      background-color: #e9f5ff;
      color: #0d6efd;
    }
    .car-model-tag {
      background-color: #f0f8ff;
      color: #0dcaf0;
    }
    .car-capacity-tag {
      background-color: #f0fff0;
      color: #198754;
    }
    .car-price-tag {
      background-color: #fff8e6;
      color: #fd7e14;
    }
    .car-info-section {
      display: flex;
      flex-wrap: wrap;
      margin-bottom: 10px;
    }
    .car-image-container {
      height: 180px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .car-image-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .autocomplete-items {
      position: absolute;
      border: 1px solid #ddd;
      border-top: none;
      z-index: 99;
      top: 100%;
      left: 0;
      right: 0;
      border-radius: 0 0 4px 4px;
      max-height: 200px;
      overflow-y: auto;
      background-color: #fff;
    }
    .autocomplete-items div {
      padding: 10px;
      cursor: pointer;
    }
    .autocomplete-items div:hover {
      background-color: #e9e9e9;
    }
    .autocomplete-active {
      background-color: #4CAF50 !important;
      color: white;
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

<section class="py-5 bg-light" id="bookingSection">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <div class="card shadow">
          <div class="card-header bg-warning text-dark py-2">
            <h4 class="mb-0">Complete Your Booking</h4>
          </div>
          <div class="card-body p-3">
            <!-- Car and Fare Section -->
            <div class="row mb-3">
              <!-- Car Details -->
              <div class="col-md-5">
                <div class="text-center">
                  <img src="${pageContext.request.contextPath}/images/car-5.jpg" id="selectedCarImage" class="img-fluid mb-2" alt="Selected Car">
                  <h5 class="mb-1" id="selectedCarName">Toyota Corolla</h5>
                  <div class="d-flex justify-content-center flex-wrap">
                    <span class="badge bg-primary m-1" id="selectedCarType">Sedan</span>
                    <span class="badge bg-info m-1" id="selectedCarModel">Toyota</span>
                    <span class="badge bg-success m-1" id="selectedCarCapacity">4 Seats</span>
                  </div>
                  <h6 class="mt-2 text-warning fw-bold" id="selectedCarPrice">$10/hour</h6>
                </div>
              </div>

              <!-- Fare Details -->
              <div class="col-md-7">
                <div class="card bg-light h-100">
                  <div class="card-body py-3">
                    <h5 class="card-title">Fare Details</h5>
                    <div class="d-flex justify-content-between mb-2">
                      <span>Base Fare:</span>
                      <span id="baseFare">${baseCharge} Rs</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                      <span>Tax (${taxPercentage}%):</span>
                      <span id="tax">0.00</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                      <span>Distance (<span id="distance">0</span> km) Charge:</span>
                      <span id="distanceFare">0.00</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between fw-bold">
                      <span>Total Estimated Fare:</span>
                      <span id="totalFare">0.00</span>
                    </div>
                    <p class="text-muted small mt-2 mb-0">Final fare may vary based on actual distance and waiting time.</p>
                  </div>
                </div>
              </div>
            </div>

            <form id="bookingForm" action="/customer-booking/payment" method="POST">
              <input type="hidden" id="txtTotalFare" name="txtTotalFare" value="">
              <input type="hidden" id="txtDistance" name="txtDistance" value="">
              <input type="hidden" id="carId" name="carId" value="${car.carId}">
              <!-- Trip Details -->
              <div class="card mb-3">
                <div class="card-header py-2 bg-light">
                  <h5 class="mb-0">Trip Details</h5>
                </div>
                <div class="card-body py-3">
                  <div class="row g-3">
                    <div class="col-md-6">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-map-marker-alt"></i></span>
                        <input onblur="calculateDistance();" autocomplete="off" type="text" class="form-control" id="pickupLocation" placeholder="Pickup Location" required>
                        <div id="pickupAutocomplete" class="autocomplete-items"></div>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-map-marker-alt"></i></span>
                        <input onblur="calculateDistance();"  autocomplete="off"  type="text" class="form-control" id="destination" placeholder="Destination" required>
                        <div id="destinationAutocomplete" class="autocomplete-items"></div>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-calendar"></i></span>
                        <input type="date" class="form-control" id="pickupDate" required>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-clock"></i></span>
                        <input type="time" class="form-control" id="pickupTime" required>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <%--Payment--%>
              <div style="display:none" id="cardPaymentForm" class="card mb-4" >
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
              <div class="d-flex justify-content-between align-items-center">
                <div class="form-check"></div>
                <div>
                  <button type="button" id="backToSearch" class="btn btn-outline-secondary">Back to Search</button>
                  <button onclick="confirmBooking(event);" type="button" class="btn btn-warning px-4">Confirm Booking</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>



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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://js.stripe.com/v3/"></script>
</body>
</html>
<script>
  let taxPercentage = parseFloat("${taxPercentage}");
  let baseCharge = parseFloat("${baseCharge}");
  let priceForKm = parseFloat("${car.priceForKm}");
  function debounce(func, wait) {
    let timeout;
    return function(...args) {
      clearTimeout(timeout);
      timeout = setTimeout(() => func.apply(this, args), wait);
    };
  }

  // Setup autocomplete for both input fields
  setupAutocomplete('pickupLocation', 'pickupAutocomplete');
  setupAutocomplete('destination', 'destinationAutocomplete');

  // Store selected location data
  let selectedLocations = {
    origin: null,
    destination: null
  };

  function setupAutocomplete(inputId, autocompleteId) {
    const input = document.getElementById(inputId);
    const autocompleteContainer = document.getElementById(autocompleteId);

    // Add event listener for input changes with debounce
    input.addEventListener('input', debounce(async function() {
      const query = this.value.trim();

      if (query.length < 2) {
        autocompleteContainer.innerHTML = '';
        return;
      }

      try {
        // Show loading indicator
        // autocompleteContainer.innerHTML = '<div><span>Searching...</span><span class="loading"></span></div>';

        // Fetch suggestions from Nominatim API
        const suggestions = await fetchAddressSuggestions(query);

        // Clear previous suggestions
        autocompleteContainer.innerHTML = '';

        if (suggestions.length === 0) {
          autocompleteContainer.innerHTML = '<div>No results found</div>';
          return;
        }

        // Add new suggestions
        suggestions.forEach(suggestion => {
          const div = document.createElement('div');
          div.innerHTML = suggestion.display_name;
          div.addEventListener('click', function() {
            input.value = suggestion.display_name;
            selectedLocations[inputId] = {
              lat: parseFloat(suggestion.lat),
              lon: parseFloat(suggestion.lon),
              display_name: suggestion.display_name
            };
            autocompleteContainer.innerHTML = '';
          });
          autocompleteContainer.appendChild(div);
        });
      } catch (error) {
        autocompleteContainer.innerHTML = '<div>Error fetching suggestions</div>';
        console.error(error);
      }
    }, 300));

    // Close autocomplete list when clicking outside
    document.addEventListener('click', function(e) {
      if (e.target !== input) {
        autocompleteContainer.innerHTML = '';
      }
    });

    // When input field changes, reset selected location
    input.addEventListener('change', function() {
      if (input.value !== selectedLocations[inputId]?.display_name) {
        selectedLocations[inputId] = null;
      }
    });
  }

  // Function to fetch address suggestions from Nominatim API
  async function fetchAddressSuggestions(query) {
    try {
      const response = await fetch("https://nominatim.openstreetmap.org/search?format=json&q="+encodeURIComponent(query)+"&limit=5");
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return await response.json();
    } catch (error) {
      console.error('Error fetching address suggestions:', error);
      throw error;
    }
  }

  // Function to geocode an address using the OpenStreetMap Nominatim API
  async function geocodeAddress(address) {
    try {
      const response = await fetch("https://nominatim.openstreetmap.org/search?format=json&q="+encodeURIComponent(address));
      const data = await response.json();

      if (data && data.length > 0) {
        return {
          lat: parseFloat(data[0].lat),
          lon: parseFloat(data[0].lon)
        };
      } else {
        throw new Error("Location not found");
      }
    } catch (error) {
      throw new Error("Failed to geocode address: " + error.message);
    }
  }

  // Calculate distance using Haversine formula
  function haversineDistance(lat1, lon1, lat2, lon2) {
    // Earth's radius in kilometers
    const R = 6371;

    // Convert degrees to radians
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;

    // Haversine formula
    const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    const distance = R * c;

    return distance;
  }

  // Calculate estimated travel time based on average speed
  function calculateTime(distanceKm) {
    // Assuming average speed of 50 km/h in city
    const avgSpeedKmh = 50;
    const timeHours = distanceKm / avgSpeedKmh;

    // Convert to minutes
    const timeMinutes = timeHours * 60;
    return timeMinutes;
  }

  // Main function to calculate distance between two locations
  async function calculateDistance() {
    const originInput = document.getElementById('pickupLocation').value.trim();
    const destinationInput = document.getElementById('destination').value.trim();
    // const resultDiv = document.getElementById('result');

    // resultDiv.style.display = 'none';
    // resultDiv.className = '';

    // if (!originInput || !destinationInput) {
    //   resultDiv.className = 'error';
    //   resultDiv.textContent = 'Please enter both starting point and destination.';
    //   resultDiv.style.display = 'block';
    //   return;
    // }

    try {
      // Show loading message
      // resultDiv.className = '';
      // resultDiv.textContent = 'Calculating distance...';
      // resultDiv.style.display = 'block';

      // Use selected locations if available, otherwise geocode
      let origin = selectedLocations.origin;
      let destination = selectedLocations.destination;

      if (!origin) {
        origin = await geocodeAddress(originInput);
      }

      if (!destination) {
        destination = await geocodeAddress(destinationInput);
      }

      // Calculate distance
      const distanceKm = haversineDistance(origin.lat, origin.lon, destination.lat, destination.lon);

      // Calculate estimated time
      const timeMinutes = calculateTime(distanceKm);

      // Format results
      const formattedDistance = distanceKm.toFixed(2);
      const formattedTime = Math.round(timeMinutes);

      calculateBooking(formattedDistance);
      // Display results
      // resultDiv.className = 'success';
      // resultDiv.innerHTML = "<strong>Distance:</strong>"+formattedDistance+" km<br>"+
      //               "<strong>Estimated travel time:</strong> "+formattedTime+" minutes<br>"+
      //               "<strong>Starting coordinates:</strong> "+origin.lat.toFixed(4)+", "+origin.lon.toFixed(4)+"<br>"+
      //               "<strong>Destination coordinates:</strong> "+destination.lat.toFixed(4)+", "+destination.lon.toFixed(4);

    } catch (error) {
      // resultDiv.className = 'error';
      // resultDiv.textContent = error.message;
    }

    // resultDiv.style.display = 'block';
  }
  function calculateBooking(formattedDistance) {
    let distance = parseFloat(formattedDistance);
    let distanceFare = distance*priceForKm;
    let totalCharge = baseCharge + distanceFare;
    let tax = totalCharge*(taxPercentage/100);
    let totalChargeWithTax = totalCharge + tax;
    $('#distanceFare').text(distanceFare.toFixed(2));
    $('#tax').text(tax.toFixed(2));
    $('#distance').text(formattedDistance);
    $('#totalFare').text(totalChargeWithTax.toFixed(2));

    $('#txtTotalFare').text(totalChargeWithTax.toFixed(totalChargeWithTax.toFixed(2)));
    $('#txtDistance').text(formattedDistance);
  }

  function confirmBooking(e) {
    e.preventDefault(); // Prevent form submission

    // Get input values
    const pickupLocation = document.getElementById("pickupLocation").value.trim();
    const destination = document.getElementById("destination").value.trim();
    const pickupDate = document.getElementById("pickupDate").value;
    const pickupTime = document.getElementById("pickupTime").value;
    const totalFare = document.getElementById("totalFare").textContent.trim();

    // Validation
    if (pickupLocation === "" || destination === "") {
      Swal.fire({
        icon: "error",
        title: "Missing Information",
        text: "Please enter both pickup location and destination.",
      });
      return;
    }

    if (pickupDate === "") {
      Swal.fire({
        icon: "error",
        title: "Missing Date",
        text: "Please select a pickup date.",
      });
      return;
    }

    if (pickupTime === "") {
      Swal.fire({
        icon: "error",
        title: "Missing Time",
        text: "Please select a pickup time.",
      });
      return;
    }

    if (totalFare === "0.00" || totalFare === "") {
      Swal.fire({
        icon: "error",
        title: "Invalid Fare",
        text: "Fare calculation is incomplete. Please check your trip details.",
      });
      return;
    }

    let url = '${pageContext.request.contextPath}/customer-booking/create-booking';

    $.ajax({
      url: url,
      type: 'POST',
      data: $('#bookingForm').serialize() + '&' + $('#bookingForm').find(':disabled').map(function() {
        return this.name + '=' + encodeURIComponent(this.value);
      }).get().join('&'),
      // dataType: 'json',
      beforeSend:function () {
        blockUi();
      },
      success: function (response) {
        if (response.status === "success") {
          // success("Booking saved successfully! Booking ID: " + response.bookingNumber);
          success(response.message);
          $("#bookingNumber").val(response.bookingNumber);

          // Show print button
          $("#printButton").show();
          // $("#bookingForm")[0].reset();
          getBookingNumbers(response.bookingNumber);

        } else {
          errorMsg("Error: " + response.message);
        }
        unblockUi();
      },
      error: function (xhr, status, error) {
        errorMsg("Internal server error.Please Try again");
        unblockUi();
      },
      complete:function () {
        unblockUi();
      }
    });

    // Confirmation alert
   /* Swal.fire({
      title: "Confirm Your Booking",
      text: "Are you sure you want to proceed to payment?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, Proceed",
    }).then((result) => {
      if (result.isConfirmed) {
        $("#bookingForm").submit();
        <%--window.location.href = "payment.jsp?pickupLocation="+encodeURIComponent(pickupLocation)+"&destination="+encodeURIComponent(destination)"&pickupDate=${pickupDate}&pickupTime=${pickupTime}&totalFare=${totalFare}`;--%>
      }
    });*/
  }
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



</script>