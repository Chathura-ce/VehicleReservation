<jsp:include page="/customer-header.jsp"/>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Leaflet CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<!-- Leaflet Routing Machine CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
<style>
  #map { height: 400px; width: 100%; }
  .custom-marker-red { color: #dc3545; }
  .custom-marker-green { color: #28a745; }
  .leaflet-routing-container { display: none; }
  .address-display {
    margin-bottom: 10px;
    padding: 8px;
    background-color: #f8f9fa;
    border-radius: 4px;
  }
  .autocomplete-items {
    position: absolute;
    border: 1px solid #d4d4d4;
    border-bottom: none;
    border-top: none;
    z-index: 99;
    top: 100%;
    left: 0;
    right: 0;
    max-height: 200px;
    overflow-y: auto;
    background-color: white;
  }
  .autocomplete-items div {
    padding: 10px;
    cursor: pointer;
    background-color: #fff;
    border-bottom: 1px solid #d4d4d4;
  }
  .autocomplete-items div:hover {
    background-color: #e9e9e9;
  }
</style>
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
                  <img src="/uploads/car_images/${car.getCarId()}.jpg" id="selectedCarImage" class="img-fluid mb-2" alt="Selected Car">
                  <h5 class="mb-1" id="selectedCarName">${car.model.getModelName()}</h5>
                  <div class="d-flex justify-content-center flex-wrap">
                    <span class="badge bg-primary m-1" id="selectedCarType">${car.type.getTypeName()}</span>
                    <span class="badge bg-success m-1" id="selectedCarCapacity">${car.seatingCapacity} Seats</span>
                  </div>
                  <h6 class="mt-2 text-warning fw-bold" id="selectedCarPrice">${car.priceForKm} Rs/km</h6>
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
              <input type="hidden" id="priceForKm" name="priceForKm" value="${car.priceForKm}">
              <!-- Trip Details -->
              <div class="card mb-3">
                <div class="card-header py-2 bg-light">
                  <h5 class="mb-0">Trip Details</h5>
                </div>
                <div class="card-body py-3">
                  <div class="row g-3">
                    <div class="col-md-12">
                      <div class="input-group">
                        <span onclick="showMapModal()" class="input-group-text bg-light"><i class="fas fa-map-marker-alt"></i></span>
                        <input onblur="calculateDistance();" autocomplete="off" type="text" class="form-control" id="pickupLocation"  name="pickupLocation" placeholder="Pickup Location" required>
                        <div id="pickupAutocomplete" class="autocomplete-items"></div>
                      </div>
                    </div>
                    <div class="col-md-12">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-map-marker-alt"></i></span>
                        <input onblur="calculateDistance();"  autocomplete="off"  type="text" class="form-control" id="destination" name="destination" placeholder="Destination" required>
                        <div id="destinationAutocomplete" class="autocomplete-items"></div>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-calendar"></i></span>
                        <input type="date" class="form-control" id="pickupDate"  name="pickupDate" required>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fas fa-clock"></i></span>
                        <input type="time" class="form-control" id="pickupTime" name="pickupTime" required>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Terms and Submit -->
              <div class="d-flex justify-content-between align-items-center">
                <div class="form-check"></div>
                <div>
                  <button onclick="location.href='/home.jsp'" type="button" id="backToSearch" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Search
                  </button>

                  <button id="confirmButton" onclick="confirmBooking(event);" type="button" class="btn btn-warning px-4">
                    <i class="fas fa-check"></i> Confirm Booking
                  </button>

                  <button style="display: none" id="paymentButton" onclick="confirmPayment(event);" type="button" class="btn btn-warning px-4">
                    <i class="fas fa-credit-card"></i> Pay Now
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- Map Modal -->
<div class="modal fade" id="mapModal" tabindex="-1" aria-labelledby="mapModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="mapModalLabel">Trip Route</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="map"></div>
      </div>
    </div>
  </div>
</div>
<input type="hidden" id="startLocation">
<input type="hidden" id="endLocation">
<jsp:include page="/customer-footer.jsp"/>

<script src="https://js.stripe.com/v3/"></script>
<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<!-- Leaflet Routing Machine JS -->
<script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
<%--map script--%>
<script src="map.js"></script>

<script>
  let map;
  const sriLankaBounds = L.latLngBounds([[5.93, 79.5], [9.83, 81.9]]);

  document.getElementById('mapModal').addEventListener('shown.bs.modal', function () {
    if (!map) {
      map = L.map('map', {
        maxBounds: sriLankaBounds,
        maxBoundsViscosity: 0.8
      }).setView([7.8731, 80.7718], 7);

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
      }).addTo(map);

      const redMarker = L.divIcon({
        className: 'custom-marker-red',
        html: '<i class="fas fa-map-marker-alt fa-2x"></i>',
        iconSize: [30, 30],
        iconAnchor: [15, 30]
      });

      const greenMarker = L.divIcon({
        className: 'custom-marker-green',
        html: '<i class="fas fa-map-marker-alt fa-2x"></i>',
        iconSize: [30, 30],
        iconAnchor: [15, 30]
      });

      const marker1 = L.marker([6.9271, 79.8612], {
        draggable: true,
        icon: redMarker
      }).addTo(map);

      const marker2 = L.marker([7.2906, 80.6337], {
        draggable: true,
        icon: greenMarker
      }).addTo(map);

      [marker1, marker2].forEach(marker => {
        marker.on('dragstart', function () {
          this._lastValidPosition = this.getLatLng();
        });

        marker.on('dragend', function (e) {
          const newPosition = e.target.getLatLng();
          if (!sriLankaBounds.contains(newPosition)) {
            alert('Location must be within Sri Lanka!');
            e.target.setLatLng(this._lastValidPosition);
          }
          calculateRoute();
        });
      });

      let routingControl;

      async function getAddress(lat, lng, elementId) {
        try {
          const response = await fetch('https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lng + '&zoom=18&addressdetails=1');
          const data = await response.json();
          document.getElementById(elementId).value = data.display_name || "Address not found";
          calculateDistance();
        } catch (error) {
          console.error("Error fetching address:", error);
          document.getElementById(elementId).value = "Error fetching address";
        }
      }

      function updateLocationInputs() {
        const startLatLng = marker1.getLatLng();
        const endLatLng = marker2.getLatLng();

        document.getElementById('startLocation').value = startLatLng.lat.toFixed(6) + ', ' + startLatLng.lng.toFixed(6);
        document.getElementById('endLocation').value = endLatLng.lat.toFixed(6) + ', ' + endLatLng.lng.toFixed(6);
      }

      function calculateRoute() {
        const waypoints = [marker1.getLatLng(), marker2.getLatLng()];

        getAddress(waypoints[0].lat, waypoints[0].lng, "pickupLocation");
        getAddress(waypoints[1].lat, waypoints[1].lng, "destination");

        updateLocationInputs();

        if (routingControl) {
          map.removeControl(routingControl);
        }

        routingControl = L.Routing.control({
          waypoints: waypoints,
          routeWhileDragging: false,
          showAlternatives: false,
          show: false,
          lineOptions: {styles: [{color: '#2196F3', weight: 4}]},
          createMarker: function() { return null; }
        }).addTo(map);

        routingControl.on('routesfound', function(e) {
          const route = e.routes[0];
          document.getElementById('distance').textContent = (route.summary.totalDistance / 1000).toFixed(2);
          // document.getElementById('routeDuration').textContent = Math.round(route.summary.totalTime % 3600 / 60);
          // document.getElementById('routeResult').classList.remove('d-none');
        });

        routingControl.on('routingerror', function() {
          alert('No route found. Please check marker positions.');
          document.getElementById('routeResult').classList.add('d-none');
        });
      }

      calculateRoute();
    } else {
      map.invalidateSize();
    }
  });
</script>



<script>
  let bookingNumber = '';
  $(function () {
    let today = new Date().toISOString().split('T')[0];
    let dateInput = document.getElementById("pickupDate");
    dateInput.setAttribute("min", today);
  })
  let taxPercentage = parseFloat("${taxPercentage}");
  let baseCharge = parseFloat("${baseCharge}");
  let priceForKm = parseFloat("${car.priceForKm}");
  const stripe = Stripe('pk_test_51R2xBMHBoMeUyf28bznECFFunlTYFzYEmJ7enSGhUuxrBe9b5TLq7Pj9QED3sWitNCzFdycdxC4SZukmPj8l0eQl00fVrOCA5K'); // Your Publishable Key

  function showMapModal() {
    // Get location values
    const pickup = document.getElementById('pickupLocation').value;
    const destination = document.getElementById('destination').value;

    // Update modal with current values
    // document.getElementById('modalPickupLocation').textContent = pickup || '-';
    // document.getElementById('modalDestination').textContent = destination || '-';

    // Show the modal
    const mapModal = new bootstrap.Modal(document.getElementById('mapModal'));
    mapModal.show();
  }


  function confirmBooking(e) {
    e.preventDefault(); // Prevent form submission

    // Reset previous validation messages
    clearValidationMessages();

    let isValid = true;

    // Get input values
    const pickupLocation = document.getElementById("pickupLocation");
    const destination = document.getElementById("destination");
    const pickupDate = document.getElementById("pickupDate");
    const pickupTime = document.getElementById("pickupTime");
    const totalFare = document.getElementById("totalFare").textContent.trim();

    // Validation
    if (pickupLocation.value.trim() === "") {
      showValidationError(pickupLocation, "Please enter pickup location");
      isValid = false;
    }

    if (destination.value.trim() === "") {
      showValidationError(destination, "Please enter destination");
      isValid = false;
    }

    if (pickupDate.value === "") {
      showValidationError(pickupDate, "Please select a pickup date");
      isValid = false;
    }

    if (pickupTime.value === "") {
      showValidationError(pickupTime, "Please select a pickup time");
      isValid = false;
    }

    if (totalFare === "0.00" || totalFare === "") {
      // Show error for distance calculation
      const distanceError = document.createElement("div");
      distanceError.className = "alert alert-danger mt-2";
      distanceError.textContent = "Fare calculation is incomplete. Please check your trip details.";
      document.querySelector(".card-body").insertBefore(distanceError, document.getElementById("bookingForm"));
      isValid = false;
    }

    if (!isValid) {
      return;
    }

    let url = '${pageContext.request.contextPath}/customer-booking/create-booking';

    $.ajax({
      url: url,
      type: 'POST',
      data: $('#bookingForm').serialize() + '&' + $('#bookingForm').find(':disabled').map(function() {
        return this.name + '=' + encodeURIComponent(this.value);
      }).get().join('&'),
      beforeSend: function () {
        // Show loading indicator
        const loadingIndicator = document.createElement("div");
        loadingIndicator.id = "loadingIndicator";
        loadingIndicator.className = "alert alert-info text-center";
        loadingIndicator.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing your booking...';
        document.querySelector(".card-body").insertBefore(loadingIndicator, document.getElementById("bookingForm"));
        disableFormElements();
        $('#confirmButton').hide()

      },
      success: function (response) {
        // Remove loading indicator
        document.getElementById("loadingIndicator").remove();

        if (response.status === "success") {
           bookingNumber = response.bookingNumber;
          // Show success message
          const successMessage = document.createElement("div");
          successMessage.className = "alert alert-success";
          successMessage.innerHTML = '<i class="fas fa-check-circle me-2"></i>Your booking has been confirmed. A confirmation has been sent to your email.';
          document.querySelector(".card-body").insertBefore(successMessage, document.getElementById("bookingForm"));
          $('#paymentButton').show()

        } else {
          // Show error message
          const errorMessage = document.createElement("div");
          errorMessage.className = "alert alert-danger";
          errorMessage.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Error: ' + response.message;
          document.querySelector(".card-body").insertBefore(errorMessage, document.getElementById("bookingForm"));
          $('#paymentButton').hide()
          $('#confirmButton').show()
        }
      },
      error: function (xhr, status, error) {
        // Remove loading indicator
        document.getElementById("loadingIndicator").remove();

        // Show error message
        const errorMessage = document.createElement("div");
        errorMessage.className = "alert alert-danger";
        errorMessage.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Internal server error. Please try again.';
        document.querySelector(".card-body").insertBefore(errorMessage, document.getElementById("bookingForm"));
      }
    });
  }

  function confirmPayment(e) {
    e.preventDefault();
    //create session for booking

    $.ajax({
      url: '/create-checkout-session', // The endpoint to create a checkout session
      method: 'POST',                  // HTTP method
      dataType: 'json'  ,              // Expect JSON response
      data:{
        bookingNumber: bookingNumber
      }
    }).done(function (session) {
      // Redirect to Stripe Checkout using the session ID
      stripe.redirectToCheckout({sessionId: session.id})
              .then(function (result) {
                // Handle any errors from redirectToCheckout
                if (result.error) {
                  alert(result.error.message);
                }
              });
    })
            .fail(function (jqXHR, textStatus, errorThrown) {
              // Handle any errors that occurred during the AJAX request
              console.error('Error creating checkout session:', textStatus, errorThrown);
              alert('An error occurred while creating the checkout session.');
            });
  }

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
      const response = await fetch("https://nominatim.openstreetmap.org/search?format=json&q="+encodeURIComponent(query)
              +"&limit=5"+
      "&countrycodes=lk&limit=5"
      );
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
      const response = await fetch("https://nominatim.openstreetmap.org/search?format=json&q="+encodeURIComponent(address)+"&countrycodes=lk");
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

    $('#txtTotalFare').val(totalChargeWithTax.toFixed(2));
    $('#txtDistance').val(formattedDistance);
  }
  
  // Helper functions for validation
  function showValidationError(inputElement, message) {
    // Add is-invalid class to the input
    inputElement.classList.add("is-invalid");
    
    // Create error message element
    const errorDiv = document.createElement("div");
    errorDiv.className = "invalid-feedback";
    errorDiv.textContent = message;
    
    // Add error message after the input
    const parentElement = inputElement.closest(".input-group") || inputElement.parentElement;
    parentElement.appendChild(errorDiv);
  }
  
  function clearValidationMessages() {
    // Remove all validation messages
    document.querySelectorAll(".is-invalid").forEach(element => {
      element.classList.remove("is-invalid");
    });
    
    document.querySelectorAll(".invalid-feedback").forEach(element => {
      element.remove();
    });
    
    document.querySelectorAll(".alert").forEach(element => {
      element.remove();
    });
  }
  
  function disableFormElements() {
    $('#pickupLocation').prop('disabled',true)
    $('#destination').prop('disabled',true)
    $('#pickupDate').prop('disabled',true)
    $('#pickupTime').prop('disabled',true)
  }
  function enableFormElements() {
    $('#pickupLocation').prop('disabled',false)
    $('#destination').prop('disabled',false)
    $('#pickupDate').prop('disabled',false)
    $('#pickupTime').prop('disabled',false)
  }
   
</script>