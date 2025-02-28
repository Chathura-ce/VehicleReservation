

<%--<%@ page isErrorPage="true" %>--%>
<%--<%= exception %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%@ page import="java.util.Objects" %>


<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null || !Objects.equals(loggedInUser.getRole(), "admin")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<jsp:include page="../header.jsp"/>
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>

<div class="container-fluid">
    <div class="card">
        <div class="card-header">
            <h4 class="mb-0">Booking Form</h4>
        </div>
        <div class="card-body">
            <form id="bookingForm">
                <!-- Row 1: Booking Number -->
                <div class="mb-3">
                    <label for="bookingNumber" class="form-label">Booking Number</label>
                    <input
                            type="text"
                            class="form-control"
                            id="bookingNumber"
                            name="bookingNumber"
                            placeholder="Auto-generated or manual"
                    />
                </div>

                <!-- Row 2: Customer Reg No (with search), Name, NIC -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="customerRegNo" class="form-label">Customer Reg No</label>
                        <div class="input-group">
                            <input
                                    type="text"
                                    class="form-control"
                                    id="customerRegNo"
                                    name="customerRegNo"
                                    placeholder="CUST0001"
                            />
                            <button
                                    id="openCustomerModal"
                                    name="openCustomerModal"
                                    type="button"
                                    class="btn btn-outline-secondary"
                                    title="Search Customer"
                                    data-bs-toggle="modal" data-bs-target="#searchCustomerModal"
                            >
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="customerName" class="form-label">Name</label>
                        <input
                                type="text"
                                class="form-control"
                                id="customerName"
                                name="customerName"
                                placeholder="Customer Name"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="customerNIC" class="form-label">NIC</label>
                        <input
                                type="text"
                                class="form-control"
                                id="customerNIC"
                                name="customerNIC"
                                placeholder="123456789V"
                        />
                    </div>
                </div>

                <!-- Row 3: Address, Phone No -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="address" class="form-label">Address</label>
                        <input
                                type="text"
                                class="form-control"
                                id="address"
                                name="address"
                                placeholder="Street, City"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="customerEmail" class="form-label">Email</label>
                        <input
                                type="text"
                                class="form-control"
                                id="customerEmail"
                                name="customerEmail"
                                placeholder="e.g. jhone@gmail.com"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="phoneNo" class="form-label">Phone No</label>
                        <input
                                type="text"
                                class="form-control"
                                id="phoneNo"
                                name="phoneNo"
                                placeholder="077xxxxxxx"
                        />
                    </div>
                </div>

                <!-- Row 4: Car ID (with search), Car Reg No, Car Type -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="carId" class="form-label">Car ID</label>
                        <div class="input-group">
                            <input
                                    type="text"
                                    class="form-control"
                                    id="carId"
                                    name="carId"
                                    placeholder="CAR0001"
                            />
                            <button
                                    data-bs-toggle="modal" data-bs-target="#searchCarModal"
                                    type="button"
                                    class="btn btn-outline-secondary"
                                    title="Search Car"
                            >
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="carRegNo" class="form-label">Car Reg No</label>
                        <input
                                type="text"
                                class="form-control"
                                id="carRegNo"
                                name="carRegNo"
                                placeholder="ABC-1234"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="carType" class="form-label">Car Type</label>
                        <select class="form-select" id="carType" name="carType">
                            <option>Sedan</option>
                            <option>SUV</option>
                            <option>Mini</option>
                            <option>Luxury</option>
                        </select>
                    </div>
                </div>

                <!-- Row 5: Car Model (ComboBox), Driver, Booking Status -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="carModel" class="form-label">Car Model</label>
                        <select class="form-select" id="carModel" name="carModel">
                            <option>-- Select Car Model --</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="driver" class="form-label">Driver</label>
                        <select class="form-select" id="driver" name="driver">
                            <option value="">-- Select Driver --</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="bookingStatus" class="form-label">Booking Status</label>
                        <select class="form-select" id="bookingStatus" name="bookingStatus">
                            <option value="pending">Pending</option>
                            <option value="confirmed">Confirmed</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>
                </div>

                <!-- Row 6: Time (Hr), Total Fare, Buttons -->
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="totalFare" class="form-label">Price for Hr</label>
                        <input
                                type="text"
                                class="form-control"
                                id="priceForHr"
                                name="priceForHr"
                                placeholder="e.g. 1"
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="pickupTime" class="form-label">Pickup Time</label>
                        <input
                                type="datetime-local"
                                class="form-control"
                                id="pickupTime"
                                name="pickupTime"
                                placeholder="e.g. 2"
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="dropOffTime" class="form-label">Drop-off Time</label>
                        <input
                                type="datetime-local"
                                class="form-control"
                                id="dropOffTime"
                                name="dropOffTime"
                                placeholder="e.g. 2"
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="timeHr" class="form-label">Time(Hr)</label>
                        <input readonly
                               value="0"
                                type="text"
                                class="form-control"
                                id="timeHr"
                               name="timeHr"
                                placeholder=""
                        />
                    </div>
                </div>

                <!-- Row 7: Buttons -->
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="pickupLocation" class="form-label">Pickup Location</label>
                        <input 
                               value=""
                               type="text"
                               class="form-control"
                               id="pickupLocation"
                               name="pickupLocation"
                               placeholder=""
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="destination" class="form-label">Destination</label>
                        <input
                               value=""
                               type="text"
                               class="form-control"
                               id="destination"
                               name="destination"
                               placeholder=""
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="totalFare" class="form-label">Total Fare</label>
                        <input readonly
                               value="0"
                               type="text"
                               class="form-control"
                               id="totalFare"
                               name="totalFare"
                               placeholder="Auto-calculate"
                        />
                    </div>
                    <div class="col-md-3">
                        <label  class="form-label">&nbsp;</label>
                        <div class="">
                            <button type="submit" class="btn btn-primary me-2">Confirm</button>
                            <button type="reset" class="btn btn-secondary">Clear</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!--  Modal -->
<div class="modal fade" id="searchCustomerModal" tabindex="-1" aria-labelledby="searchCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title" id="searchCustomerModalLabel">Search by NIC or Name</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
                <div class="mb-3">
                    <label for="searchInput" class="form-label">Type NIC or Name:</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Type NIC or Name...">
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>NIC</th>
                        <th>Name</th>
                        <th>Phone</th>
                        <th>Address</th>
                    </tr>
                    </thead>
                    <tbody id="searchResults">
                    <!-- Results will appear here -->
                    </tbody>
                </table>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="searchCarModal" tabindex="-1" aria-labelledby="searchCarModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="searchCarModalLabel">Search Cars</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Search Input -->
                <div class="mb-3">
                    <label for="carSearchInput" class="form-label">Enter Car Registration Number or Model:</label>
                    <input type="text" class="form-control" id="carSearchInput" placeholder="Type your search query here...">
                </div>
                <!-- Results Table -->
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Car ID</th>
                        <th>Model</th>
                        <th>Type</th>
                        <th>Registration Number</th>
                        <th>Seating Capacity</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody id="carSearchResults">
                    <!-- AJAX search results will be injected here -->
                    </tbody>
                </table>
            </div>
            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../footer.jsp"/>
<!-- AJAX and Table Update Script -->
<%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@eonasdan/tempus-dominus@6.0.0/dist/css/tempus-dominus.min.css">--%>
<%--<script src="https://cdn.jsdelivr.net/npm/@eonasdan/tempus-dominus@6.0.0/dist/js/tempus-dominus.min.js"></script>--%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const pickupTimeInput = document.getElementById("pickupTime");
        const dropOffTimeInput = document.getElementById("dropOffTime");
        const timeHrInput = document.getElementById("timeHr");
        const priceForHrInput = document.getElementById("priceForHr");
        const totalFareInput = document.getElementById("totalFare");

        function calculateTimeAndFare() {
            const pickupTime = new Date(pickupTimeInput.value);
            const dropOffTime = new Date(dropOffTimeInput.value);
            const pricePerHour = parseFloat(priceForHrInput.value) || 0;

            if (!isNaN(pickupTime) && !isNaN(dropOffTime)) {
                if (dropOffTime < pickupTime) {
                    alert("Drop-off time cannot be earlier than Pickup time!");
                    dropOffTimeInput.value = ""; // Reset drop-off time
                    timeHrInput.value = "0";
                    totalFareInput.value = "0";
                    return;
                }

                // Calculate the time difference in hours
                const timeDifference = dropOffTime - pickupTime;
                const hoursDifference = timeDifference / (1000 * 60 * 60); // Convert ms to hours

                // Update the hours field
                timeHrInput.value = hoursDifference.toFixed(2);

                // Calculate total fare
                const totalFare = hoursDifference * pricePerHour;
                totalFareInput.value = totalFare.toFixed(2); // Round to 2 decimal places
            } else {
                timeHrInput.value = "0";
                totalFareInput.value = "0";
            }
        }

        // Attach event listeners to input fields
        pickupTimeInput.addEventListener("change", calculateTimeAndFare);
        dropOffTimeInput.addEventListener("change", calculateTimeAndFare);
        priceForHrInput.addEventListener("input", calculateTimeAndFare);

        // Trigger search when user types in the input
        searchInput.addEventListener('keyup', function() {
            let query = searchInput.value.trim();

            // If empty, clear results
            if (query.length === 0) {
                searchResults.innerHTML = '';
                return;
            }

            // Example jQuery AJAX call (replace '/searchCustomer' with your endpoint)
            $.ajax({
                url: '${pageContext.request.contextPath}/searchCustomer',
                type: 'GET',
                data: { q: query }, // The query parameter
                dataType: 'json',
                success: function(data) {
                    let rows = '';
                    if (data && data.length > 0) {
                        data.forEach(function(customer) {
                            rows += `
                  <tr>
                    <td>${customer.nic}</td>
                    <td>${customer.name}</td>
                    <td>${customer.phone}</td>
                    <td>${customer.address}</td>
                  </tr>
                `;
                        });
                    } else {
                        rows = '<tr><td colspan="4">No results found.</td></tr>';
                    }
                    searchResults.innerHTML = rows;
                },
                error: function() {
                    searchResults.innerHTML = '<tr><td colspan="4">Error loading data.</td></tr>';
                }
            });
        });

        $("#carSearchInput").on("keyup", function() {
            var query = $(this).val().trim();

            // If the search input is empty, clear the results
            if(query.length === 0) {
                $("#carSearchResults").html("");
                return;
            }

            // AJAX call to search for cars
            $.ajax({
                url: '${pageContext.request.contextPath}/searchCar',  // Ensure this matches your servlet mapping
                type: 'GET',
                data: { q: query },
                dataType: 'json',
                success: function(data) {
                    var rows = "";
                    if(data && data.length > 0) {
                        $.each(data, function(index, car) {
                            rows += "<tr>";
                            rows += "<td>" + car.carId + "</td>";
                            rows += "<td>" + car.model + "</td>";
                            rows += "<td>" + car.type + "</td>";
                            rows += "<td>" + car.regNumber + "</td>";
                            rows += "<td>" + car.seatingCapacity + "</td>";
                            rows += "<td>" + car.available + "</td>";
                            rows += "</tr>";
                        });
                    } else {
                        rows = "<tr><td colspan='6'>No results found.</td></tr>";
                    }
                    $("#carSearchResults").html(rows);
                },
                error: function() {
                    $("#carSearchResults").html("<tr><td colspan='6'>Error loading data.</td></tr>");
                }
            });
        });

        $.ajax({
            url: '${pageContext.request.contextPath}/getCarTypes',
            type: 'GET',
            dataType: 'json',
            success: function(data){
                var options = '<option value="">-- Select Car Type --</option>';
                $.each(data, function(index, carType){
                    options += '<option value="' + carType.typeId + '">' + carType.typeName + '</option>';
                });
                $("#carType").html(options);
            },
            error: function(){
                $("#carType").html('<option value="">Error loading car types</option>');
            }
        });

        $('#carType').on('change', function() {
            var typeId = $(this).val();
            // Clear the car model dropdown if no car type is selected
            if (!typeId) {
                $('#carModel').html('<option value="">-- Select Car Model --</option>');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/getCarModels', // adjust your context path as needed
                type: 'GET',
                data: { typeId: typeId },
                dataType: 'json',
                success: function(data) {
                    var options = '<option value="">-- Select Car Model --</option>';
                    if(data && data.length > 0) {
                        $.each(data, function(index, carModel) {
                            options += '<option value="' + carModel.modelId + '">' + carModel.modelName + '</option>';
                        });
                    } else {
                        options += '<option value="">No models available</option>';
                    }
                    $('#carModel').html(options);
                },
                error: function() {
                    $('#carModel').html('<option value="">Error loading models</option>');
                }
            });
        });

        $.ajax({
            url: '${pageContext.request.contextPath}/loadDrivers', // Replace with your actual context path
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                var options = '<option value="">-- Select Driver --</option>';
                if (data && data.length > 0) {
                    $.each(data, function(index, driver) {
                        // Assuming each driver has properties "driverId" and a nested "user" object with "fullName"
                        options += '<option value="' + driver.driverId + '">' + driver.user.fullName + '</option>';
                    });
                } else {
                    options += '<option value="">No drivers available</option>';
                }
                $('#driver').html(options);
            },
            error: function() {
                $('#driver').html('<option value="">Error loading drivers</option>');
            }
        });

        $("#bookingForm").submit(function(e){
            e.preventDefault(); // Prevent the default form submission
            // console.log($(this).serialize())
            let url = '${pageContext.request.contextPath}/booking/insert';
            if($("#bookingNumber").val().trim() != "") {
                url = '${pageContext.request.contextPath}/booking/update';
            }
            $.ajax({
                url: url,
                type: 'POST',
                data: $(this).serialize(), // Serialize form data
                // dataType: 'json',
                success: function(response) {
                    if(response.status === "success") {
                        alert("Booking saved successfully! Booking ID: " + response.bookingNumber);
                        $("#bookingNumber").val(response.bookingNumber);
                        // Optionally, clear the form or redirect the user:
                        // $("#bookingForm")[0].reset();
                    } else {
                        alert("Error: " + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert("Ajax error: " + error);
                }
            });
        });

    });
</script>
