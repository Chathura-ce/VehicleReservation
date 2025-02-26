<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/header.jsp" />
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="text-center">Create New Booking</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/booking/create" method="post">
                            <div class="mb-3">
                                <label for="pickupLocation" class="form-label">Pickup Location</label>
                                <input type="text" class="form-control" id="pickupLocation" name="pickupLocation" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="dropLocation" class="form-label">Drop Location</label>
                                <input type="text" class="form-control" id="dropLocation" name="dropLocation" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="pickupDateTime" class="form-label">Pickup Date & Time</label>
                                <input type="datetime-local" class="form-control" id="pickupDateTime" name="pickupDateTime" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="vehicleId" class="form-label">Vehicle Type</label>
                                <select class="form-select" id="vehicleId" name="vehicleId" required>
                                    <option value="">Select a vehicle</option>
                                    <c:forEach var="vehicle" items="${vehicles}">
                                        <option value="${vehicle.vehicleId}">${vehicle.model} - ${vehicle.type}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="driverId" class="form-label">Driver</label>
                                <select class="form-select" id="driverId" name="driverId" required>
                                    <option value="">Select a driver</option>
                                    <c:forEach var="driver" items="${drivers}">
                                        <option value="${driver.userId}">${driver.fullName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="fare" class="form-label">Estimated Fare</label>
                                <input type="number" step="0.01" class="form-control" id="fare" name="fare" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="customerNote" class="form-label">Additional Notes</label>
                                <textarea class="form-control" id="customerNote" name="customerNote" rows="3"></textarea>
                            </div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Create Booking</button>
                                <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>