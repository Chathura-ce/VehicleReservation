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
            <form onsubmit="event.preventDefault();" id="bookingForm">
                <!-- Row 1: Booking Number -->
                <div class="mb-3">
                    <label for="bookingNumber" class="form-label">Booking Number</label>
                    <select onchange="getBookingDetails()" class="form-control" name="bookingNumber" id="bookingNumber">
                        <option value="">--Select One--</option>
                    </select>
                </div>

                <!-- Row 2: Customer Reg No (with search), Name, NIC -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="customerId" class="form-label">Customer ID</label>
                        <div class="input-group">
                            <input readonly
                                   type="text"
                                   class="form-control"
                                   id="customerId"
                                   name="customerId"
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
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="customerNIC" class="form-label">NIC</label>
                        <input
                                type="text"
                                class="form-control"
                                id="customerNIC"
                                name="customerNIC"
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
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="customerEmail" class="form-label">Email</label>
                        <input
                                type="text"
                                class="form-control"
                                id="customerEmail"
                                name="customerEmail"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="phoneNo" class="form-label">Phone No</label>
                        <input
                                type="text"
                                class="form-control"
                                id="phoneNo"
                                name="phoneNo"
                        />
                    </div>
                </div>

                <!-- Row 4: Car ID (with search), Car Reg No, Car Type -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="carId" class="form-label">Car ID</label>
                        <div class="input-group">
                            <input readonly
                                   type="text"
                                   class="form-control"
                                   id="carId"
                                   name="carId"
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
                        <label for="carType" class="form-label">Car Type</label>
                        <input readonly
                               type="text"
                               class="form-control"
                               id="carType"
                               name="carType"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="carModel" class="form-label">Car Model</label>
                        <%--<select class="form-select" id="carModel" name="carModel">
                            <option>-- Select Car Model --</option>
                        </select>--%>
                        <input readonly
                               type="text"
                               class="form-control"
                               id="carModel"
                               name="carModel"
                        />
                    </div>
                </div>

                <!-- Row 5: Car Model (ComboBox), Driver, Booking Status -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="seatingCapacity" class="form-label">Seating Capacity</label>
                        <input readonly
                               type="text"
                               class="form-control"
                               id="seatingCapacity"
                               name="seatingCapacity"
                        />
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
<%--                            <option value="1">Pending</option>--%>
                            <option value="2">Confirmed</option>
<%--                            <option value="3">Completed</option>--%>
                            <option value="4">Cancelled</option>
                        </select>
                    </div>
                </div>

                <!-- Row 6: Time (Hr), Total Fare, Buttons -->
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="priceForKm" class="form-label">Price for KM</label>
                        <input
                                type="text"
                                class="form-control"
                                id="priceForKm"
                                name="priceForKm"
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="pickupLocation" class="form-label">Pickup Location</label>
                        <input
                                value=""
                                type="text"
                                class="form-control"
                                id="pickupLocation"
                                name="pickupLocation"
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
                        />
                    </div>

                    <div class="col-md-3">
                        <label for="distance" class="form-label">Distance (Km)</label>
                        <input
                               value=""
                               type="text"
                               class="form-control"
                               id="distance"
                               name="distance"
                        />
                    </div>
                </div>

                <!-- Row 7: Buttons -->
                <div class="row mb-3">
                   <%-- <div class="col-md-3">
                        <label for="pickupTime" class="form-label">Pickup Time</label>
                        <input
                                type="datetime-local"
                                class="form-control"
                                id="pickupTime"
                                name="pickupTime"
                        />
                    </div>
                    <div class="col-md-3">
                        <label for="dropOffTime" class="form-label">Drop-off Time</label>
                        <input
                                type="datetime-local"
                                class="form-control"
                                id="dropOffTime"
                                name="dropOffTime"
                        />
                    </div>--%>
                    <div style="display:none" class="col-md-3">
                        <label for="totalFare" class="form-label">Total Fare</label>
                        <input readonly
                               value="0"
                               type="text"
                               class="form-control"
                               id="totalFare"
                               name="totalFare"
                        />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">&nbsp;</label>
                        <div class="">
                            <button onclick="saveData();" type="button" class="btn btn-primary me-2">Create</button>
                            <button onclick="printBill();" type="button" class="btn btn-success me-2">Print</button>
                            <button onclick="newBooking();" type="reset" class="btn btn-secondary">New
                            </button>
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="searchCustomerModal" tabindex="-1" aria-labelledby="searchCustomerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title" id="searchCustomerModalLabel">Search Customer</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
                <div class="mb-3">
                    <label for="searchInput" class="form-label">Type Customer ID, Name, NIC, Email or Phone No :</label>
                    <input type="text" class="form-control" id="searchInput">
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>NIC</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th></th>
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
    <div class="modal-dialog modal-xl">
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
                    <input type="text" class="form-control" id="carSearchInput">
                </div>
                <!-- Results Table -->
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Car ID</th>
                        <th>Type</th>
                        <th>Model</th>
                        <th>Registration Number</th>
                        <th>Seating Capacity</th>
                        <th>Driver</th>
                        <th>Status</th>
                        <th></th>
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

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // const pickupTimeInput = document.getElementById("pickupTime");
        // const dropOffTimeInput = document.getElementById("dropOffTime");
        // const priceForKmInput = document.getElementById("priceForKm");
        // const distanceInput = document.getElementById("distance");
        // const totalFareInput = document.getElementById("totalFare");

        // pickupTimeInput.addEventListener("change", calculateTimeAndFare);
        // dropOffTimeInput.addEventListener("change", calculateTimeAndFare);
        // priceForKmInput.addEventListener("input", calculateTimeAndFare);
        var bookingNumber = getQueryParam("bookingNumber");
        getBookingNumbers(bookingNumber,true);

        /*function calculateTimeAndFare() {
            const pickupTime = new Date(pickupTimeInput.value);
            const dropOffTime = new Date(dropOffTimeInput.value);
            const pricePerHour = parseFloat(priceForHrInput.value) || 0;

            if (!isNaN(pickupTime) && !isNaN(dropOffTime)) {
                if (dropOffTime < pickupTime) {
                    errorMsg("Drop-off time cannot be earlier than Pickup time!");
                    dropOffTimeInput.value = ""; // Reset drop-off time
                    distanceInput.value = "0";
                    totalFareInput.value = "0";
                    return;
                }

                // Calculate the time difference in hours
                const timeDifference = dropOffTime - pickupTime;
                const hoursDifference = timeDifference / (1000 * 60 * 60); // Convert ms to hours

                // Update the hours field
                distanceInput.value = hoursDifference.toFixed(2);

                // Calculate total fare
                const totalFare = hoursDifference * pricePerHour;
                totalFareInput.value = totalFare.toFixed(2); // Round to 2 decimal places
            } else {
                distanceInput.value = "0";
                totalFareInput.value = "0";
            }
        }*/


        $("#searchCustomerModal").on("shown.bs.modal", function () {
            loadPopupCustomers();
        });

        $("#searchInput").on("keyup", function () {
            loadPopupCustomers();
        });

        $("#searchCarModal").on("shown.bs.modal", function () {
            loadPopupCars();
        });

        $("#carSearchInput").on("keyup", function () {
            loadPopupCars();
        });

        $('#carType').on('change', function () {
            var typeId = $(this).val();
            // Clear the car model dropdown if no car type is selected
            if (!typeId) {
                $('#carModel').html('<option value="">-- Select Car Model --</option>');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/getCarModels', // adjust your context path as needed
                type: 'GET',
                data: {typeId: typeId},
                dataType: 'json',
                success: function (data) {
                    var options = '<option value="">-- Select Car Model --</option>';
                    if (data && data.length > 0) {
                        $.each(data, function (index, carModel) {
                            options += '<option value="' + carModel.modelId + '">' + carModel.modelName + '</option>';
                        });
                    } else {
                        options += '<option value="">No models available</option>';
                    }
                    $('#carModel').html(options);
                },
                error: function () {
                    $('#carModel').html('<option value="">Error loading models</option>');
                }
            });
        });


        loadDrivers();
    });
    function saveData(){
        // e.preventDefault(); // Prevent the default form submission
        if(!validateBookingForm()){
            return;
        }
        // console.log($(this).serialize())
        let url = '${pageContext.request.contextPath}/booking/insert';
        if ($("#bookingNumber").val().trim() != "") {
            url = '${pageContext.request.contextPath}/booking/update';
        }
        $.ajax({
            url: url,
            type: 'POST',
            data: $('#bookingForm').serialize(), // Serialize form data
            // dataType: 'json',
            success: function (response) {
                if (response.status === "success") {
                    success("Booking saved successfully! Booking ID: " + response.bookingNumber);
                    $("#bookingNumber").val(response.bookingNumber);

                    // Show print button
                    $("#printButton").show();
                    // $("#bookingForm")[0].reset();
                    getBookingNumbers(response.bookingNumber);

                } else {
                    errorMsg("Error: " + response.message);
                }
            },
            error: function (xhr, status, error) {
                errorMsg("Internal server error.Please Try again");
            }
        });
    }

    function loadDrivers() {
        $.ajax({
            url: '${pageContext.request.contextPath}/loadDrivers', // Replace with your actual context path
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var options = '<option value="">-- Select Driver --</option>';
                if (data && data.length > 0) {
                    $.each(data, function (index, driver) {
                        // Assuming each driver has properties "driverId" and a nested "user" object with "fullName"
                        options += '<option value="' + driver.driverId + '">' + driver.user.fullName + '</option>';
                    });
                } else {
                    options += '<option value="">No drivers available</option>';
                }
                $('#driver').html(options);
            },
            error: function () {
                $('#driver').html('<option value="">Error loading drivers</option>');
            }
        });
    }

    function getCarTypes() {
        $.ajax({
            url: '${pageContext.request.contextPath}/getCarTypes',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var options = '<option value="">-- Select Car Type --</option>';
                $.each(data, function (index, carType) {
                    options += '<option value="' + carType.typeId + '">' + carType.typeName + '</option>';
                });
                $("#carType").html(options);
            },
            error: function () {
                $("#carType").html('<option value="">Error loading car types</option>');
            }
        });
    }

    function getBookingNumbers(select = "",trigger=false) {
        $.ajax({
            url: "../booking/get-booking-numbers",
            type: "GET",
            dataType: "json",
            success: function (response) {
                if (response.status == "success") {
                    let options = '<option value="">--Select One--</option>';

                    response.bookingNumbers.forEach((bookingNumber) => {
                        options += "<option value='" + bookingNumber + "'>" + bookingNumber + "</option>";
                    });
                    $("#bookingNumber").html(options);
                    $("#bookingNumber").val(select);
                   if(trigger) getBookingDetails();
                } else {
                    console.error("Error fetching booking numbers:", response.message);
                }
            },
            error: function (xhr, status, error) {
                console.error("Ajax error while fetching booking numbers:", error);
            }
        });
    }

    function getBookingDetails() {
        const bookingNumber = $("#bookingNumber").val();
        if (bookingNumber == "") {
            toggleCustomerDetails(false);
            resetForm()
            return;
        } else {
            toggleCustomerDetails(true);
            resetForm();
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/booking/get-details',
            type: 'GET',
            data: {bookingNumber: bookingNumber},
            dataType: 'json',
            success: function (response) {
                if (response.status === "success") {
                    // Disable customer-related fields
                    $("#customerRegNo,#openCustomerModal,#customerName, #customerNIC, #customerEmail, #phoneNo, #address").prop("disabled", true);

                    // Populate customer details
                    $("#customerId").val(response.booking.customerId);
                    $("#customerName").val(response.booking.user.fullName);
                    $("#customerNIC").val(response.booking.user.nic);
                    $("#address").val(response.booking.customer.address);
                    $("#customerEmail").val(response.booking.user.email);
                    $("#phoneNo").val(response.booking.user.phone);

                    // Populate car details
                    $("#carId").val(response.booking.carId);
                    // $("#carRegNo").val(response.booking.carRegNo);
                    $("#carType").val(response.booking.car.type.typeName);
                    $("#carModel").val(response.booking.car.model.modelName);
                    $("#seatingCapacity").val(response.booking.car.seatingCapacity);

                    // Populate driver and status
                    $("#driver").val(response.booking.driverId);
                    $("#bookingStatus").val(response.booking.statusId);

                    // Populate time and fare details
                    $("#priceForKm").val(response.booking.priceForKm);
                    // $("#pickupTime").val(response.booking.pickupTime);
                    // $("#dropOffTime").val(response.booking.dropOffTime);
                    $("#distance").val(response.booking.distance);
                    $("#totalFare").val(response.booking.totalFare);

                    // Populate locations
                    $("#pickupLocation").val(response.booking.pickupLocation);
                    $("#destination").val(response.booking.destination);

                    // Show print button for existing booking
                    $("#printButton").show();
                } else {
                    errorMsg("Error loading booking details: " + response.message);
                }
            },
            error: function (xhr, status, error) {
                errorMsg("Error loading booking details: " + error);
            }
        });
    }

    function toggleCustomerDetails(disable) {
        // Enable / Disable customer-related fields for existing booking
        $("#customerRegNo,#customerName,#customerNIC,#customerEmail,#phoneNo,#address").prop("disabled", disable);
        if ($('#bookingNumber').val() == "") $("#openCustomerModal").prop("disabled", false);
        else $("#openCustomerModal").prop("disabled", true);
    }

    function resetForm() {
        // Keep the booking number
        // const bookingNumber = $("#bookingNumber").val();

        // Reset customer details
        // $("#customerRegNo").val("");
        $("#customerName").val("");
        $("#customerNIC").val("");
        $("#customerEmail").val("");
        $("#phoneNo").val("");
        $("#address").val("");
        $("#customerId").val("");

        // Reset car details
        $("#carId").val("");
        $("#carRegNo").val("");
        $("#carType").val("");
        $("#carModel").val("");
        $("#priceForKm").val("0");

        // Reset driver
        $("#driver").val("");

        // Reset time and location details
        $("#pickupTime").val("");
        $("#dropOffTime").val("");
        $("#distance").val("0");
        $("#totalFare").val("0");
        $("#pickupLocation").val("");
        $("#destination").val("");

        // Hide print button for new booking
        $("#printButton").hide();

        // Restore the booking number
        // $("#bookingNumber").val(bookingNumber);
    }

    function loadPopupCustomers() {
        let query = $('#searchInput').val().trim();
        $.ajax({
            url: '${pageContext.request.contextPath}/searchCustomer',
            type: 'GET',
            data: {q: query}, // The query parameter
            dataType: 'json',
            success: function (data) {
                let rows = '';
                if (data && data.length > 0) {
                    data.forEach(function (customer) {
                        rows += "<tr>"
                            + "<td>" + customer.customerNumber + "</td>"
                            + "<td>" + customer.user.fullName + "</td>"
                            + "<td>" + customer.user.nic + "</td>"
                            + "<td>" + customer.address + "</td>"
                            + "<td>" + customer.user.email + "</td>"
                            + "<td>" + customer.user.phone + "</td>"
                            + "<td><button onclick='setUserData(this);' class='btn btn-success'><i class='bi bi-check-square'></i> Select</button></td>"
                            + "</tr>";
                    });
                } else {
                    rows = '<tr><td colspan="100%">No results found.</td></tr>';
                }
                $("#searchResults").html(rows);
            },
            error: function () {
                $("#searchResults").html('<tr><td colspan="100%">Error loading data.</td></tr>');
            }
        });
    }

    function setUserData(obj) {
        $('#customerId').val($(obj).closest('tr').find('td:eq(0)').text());
        $('#customerName').val($(obj).closest('tr').find('td:eq(1)').text());
        $('#customerNIC').val($(obj).closest('tr').find('td:eq(2)').text());
        $('#address').val($(obj).closest('tr').find('td:eq(3)').text());
        $('#customerEmail').val($(obj).closest('tr').find('td:eq(4)').text());
        $('#phoneNo').val($(obj).closest('tr').find('td:eq(5)').text());
        toggleCustomerDetails(true);
        $('#searchCustomerModal').modal('hide');
        $('#searchInput').val();
        toastSuccess("Customer added successfully");
    }

    function loadPopupCars() {
        var query = $("#carSearchInput").val().trim();

        // AJAX call to search for cars
        $.ajax({
            url: '${pageContext.request.contextPath}/searchCar',  // Ensure this matches your servlet mapping
            type: 'GET',
            data: {q: query},
            dataType: 'json',
            success: function (data) {
                var rows = "";
                if (data && data.length > 0) {
                    $.each(data, function (index, car) {
                        var available = car.available == '0' ? 'Not Available' : 'Available';
                        rows += "<tr>";
                        rows += "<td>" + car.carId + "</td>";
                        rows += "<td>" + car.type.typeName + "</td>";
                        rows += "<td>" + car.model.modelName + "</td>";
                        rows += "<td>" + car.regNumber + "</td>";
                        rows += "<td>" + car.seatingCapacity + "</td>";
                        rows += "<td data-driver_id='"+car.driver.driverId+"'>" + car.driver.driverName + "</td>";
                        rows += "<td>" + available + "</td>";
                        rows += "<td><button onclick='setCarData(this);' class='btn btn-success'><i class='bi bi-check-square'></i> Select</button></td>"
                        rows += "</tr>";
                    });
                } else {
                    rows = "<tr><td colspan='100%'>No results found.</td></tr>";
                }
                $("#carSearchResults").html(rows);
            },
            error: function () {
                $("#carSearchResults").html("<tr><td colspan='100%'>Error loading data.</td></tr>");
            }
        });
    }

    function setCarData(obj) {
        $('#carId').val($(obj).closest('tr').find('td:eq(0)').text());
        $('#carType').val($(obj).closest('tr').find('td:eq(1)').text());
        $('#carModel').val($(obj).closest('tr').find('td:eq(2)').text());
        $('#seatingCapacity').val($(obj).closest('tr').find('td:eq(4)').text());
        $('#driver').val($(obj).closest('tr').find('td:eq(5)').attr('data-driver_id'));

        $('#searchCarModal').modal('hide');
        $('#carSearchInput').val();
        toastSuccess("Car added successfully");
    }


    function validateBookingForm() {
        // Booking Number validation
        // const bookingNumber = $("#bookingNumber").val();
        /*if (bookingNumber === "") {
            errorMsg("Please select a Booking Number");
            return false;
        }*/

        // Customer validation
       /* const customerId = $("#customerId").val();
        if (customerId === "") {
            errorMsg("Please select a Customer ID");
            return false;
        }*/

        // Customer Name validation
        const customerName = $("#customerName").val().trim();
        if (customerName === "") {
            errorMsg("Customer Name is required");
            $("#customerName").focus()
            return false;
        }

        // NIC validation
        const customerNIC = $("#customerNIC").val().trim();
        if (customerNIC === "") {
            errorMsg("NIC is required");
            $("#customerNIC").focus()
            return false;
        }
        const nicRegex = /^(?:\d{9}[Vv]?|\d{12})$/;
        if (!nicRegex.test(customerNIC)) {
            errorMsg("Invalid NIC format (Use 123456789V or 12-digit format).");
            return;
        }

        // Address validation
        const address = $("#address").val().trim();
        if (address === "") {
            errorMsg("Address is required");
            $("#address").focus()
            return false;
        }

        // Email validation
        const email = $("#customerEmail").val().trim();
        if (email === "") {
            errorMsg("Email is required");
            $("#customerEmail").focus()
            return false;
        } else if (!isValidEmail(email)) {
            errorMsg("Please enter a valid email address");
            $("#customerEmail").focus()
            return false;
        }

        // Phone validation
        const phone = $("#phoneNo").val().trim();
        if (phone === "") {
            errorMsg("Phone Number is required");
            $("#phoneNo").focus()
            return false;
        }
        const phoneRegex = /^(?:\+94|0)\d{9}$/;
        if (!phoneRegex.test(phone)) {
            errorMsg("Invalid phone number (Use 0XXXXXXXXX or +94XXXXXXXXX format).");
            return;
        }


        // Car ID validation
        const carId = $("#carId").val();
        if (carId === "") {
            errorMsg("Please select a Car");
            $("#carId").focus()
            return false;
        }

        // Driver validation
        const driver = $("#driver").val();
        if (driver === "") {
            errorMsg("Please select a Driver");
            $("#driver").focus()
            return false;
        }

        // Booking Status validation
        const bookingStatus = $("#bookingStatus").val();
        if (bookingStatus === "") {
            errorMsg("Please select a Booking Status");
            $("#bookingStatus").focus()
            return false;
        }

        // Price for Hour validation
        const priceForKm = $("#priceForKm").val().trim();
        if (priceForKm === "") {
            errorMsg("Price for KM is required");
            $("#priceForKm").focus()
            return false;
        } else if (isNaN(priceForKm) || parseFloat(priceForKm) <= 0) {
            errorMsg("Please enter a valid Price for KM (must be a positive number)");
            $("#priceForKm").focus()
            return false;
        }

        // Pickup Time validation
        /*const pickupTime = $("#pickupTime").val();
        if (pickupTime === "") {
            errorMsg("Pickup Time is required");
            $("#pickupTime").focus()
            return false;
        }

        // Drop-off Time validation
        const dropOffTime = $("#dropOffTime").val();
        if (dropOffTime === "") {
            errorMsg("Drop-off Time is required");
            $("#dropOffTime").focus()
            return false;
        }*/

        // Compare pickup and drop-off times
       /* const pickupDateTime = new Date(pickupTime);
        const dropOffDateTime = new Date(dropOffTime);

        if (dropOffDateTime <= pickupDateTime) {
            errorMsg("Drop-off time must be after pickup time");
            $("#pickupTime").focus()
            return false;
        }*/

        // Pickup Location validation
        const pickupLocation = $("#pickupLocation").val().trim();
        if (pickupLocation === "") {
            errorMsg("Pickup Location is required");
            $("#pickupLocation").focus()
            return false;
        }

        // Destination validation
        const destination = $("#destination").val().trim();
        if (destination === "") {
            errorMsg("Destination is required");
            $("#destination").focus()
            return false;
        }
        // Distance validation
        const distance = $("#distance").val().trim();
        if (distance === "") {
            errorMsg("Distance is required");
            $("#distance").focus()
            return false;
        }

        // All validations passed
        return true;
    }

    // Helper function to validate email format
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }



    function calculateTimeDifference() {
        const pickupTime = $("#pickupTime").val();
        const dropOffTime = $("#dropOffTime").val();

        if (pickupTime && dropOffTime) {
            const pickupDateTime = new Date(pickupTime);
            const dropOffDateTime = new Date(dropOffTime);

            if (dropOffDateTime > pickupDateTime) {
                // Calculate time difference in hours
                const diffMs = dropOffDateTime - pickupDateTime;
                const diffHrs = diffMs / (1000 * 60 * 60);

                // Update the time hours field
                $("#distance").val(diffHrs.toFixed(2));

                // Calculate total fare if price per hour is available
                const pricePerHour = parseFloat($("#priceForKm").val());
                if (!isNaN(pricePerHour)) {
                    const totalFare = pricePerHour * diffHrs;
                    $("#totalFare").val(totalFare.toFixed(2));
                }
            } else {
                $("#distance").val("0");
                $("#totalFare").val("0");
            }
        }
    }

    function printBill() {
        let bookingNumber = $('#bookingNumber').val();  // Get the booking number from the input field

        // Construct the URL for the new page with the booking number as a query parameter
        let url = '${pageContext.request.contextPath}/bill?bookingNumber=' + bookingNumber;

        // Open the new page in a new tab
        window.open(url, '_blank');
    }

    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }


    function newBooking() {
        window.location.href = '/booking/new';
    }


</script>
