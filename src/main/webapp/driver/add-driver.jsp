<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
 <style>
    .form-control.is-invalid {
        border-color: #dc3545;
        padding-right: calc(1.5em + 0.75rem);
        background-repeat: no-repeat;
        background-position: right calc(0.375em + 0.1875rem) center;
        background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
    }
    .form-control.is-valid {
        border-color: #198754;
        padding-right: calc(1.5em + 0.75rem);
        background-repeat: no-repeat;
        background-position: right calc(0.375em + 0.1875rem) center;
        background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
    }
    .invalid-feedback {
        display: none;
        width: 100%;
        margin-top: 0.25rem;
        padding-left: 0.5rem;
        font-size: 0.875em;
        color: #dc3545;
    }
    .invalid-feedback.d-block {
        display: block !important;
        margin-bottom: 1rem;
        color: #dc3545;
        font-size: 0.875em;
    }
    .input-group + .invalid-feedback {
        margin-top: -0.5rem;
        margin-bottom: 1rem;
    }
    .is-invalid ~ .invalid-feedback {
        display: block;
    }
</style>
<div class="row">
    <div class="col-sm-6">
        <h3 class="mb-0">Dashboard</h3>
    </div>
    <div class="col-sm-6">
        <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item">Driver</li>
            <li class="breadcrumb-item active" aria-current="page">Add Driver</li>
        </ol>
    </div>
</div>

<div class="row d-flex justify-content-center mt-5">
    <div class="col-sm-8">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Add New Driver</h3>
            </div>
            <div class="card-body">
                <!-- Display Validation Errors Using Scriptlets -->
                <%
                    String errorMessage = (String) session.getAttribute("errorMessage");
                    if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= errorMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        // Remove the attribute so it doesn't persist
                        session.removeAttribute("errorMessage");
                    }
                %>

                <!-- Display Success Message Using Scriptlets -->
                <%
                    String successMessage = (String) session.getAttribute("successMessage");
                    if (successMessage != null && !successMessage.trim().isEmpty()) {
                %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= successMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        // Remove the attribute so it doesn't persist
                        session.removeAttribute("successMessage");
                    }
                %>


                <form action="${pageContext.request.contextPath}/add-driver" method="post" id="driverForm" class="needs-validation" novalidate>
                    <!-- Username & Password Row -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Username</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="username" name="username"
                                       placeholder="Username" value="${username != null ? username : ''}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-person-fill"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Password" required>
                                <div class="input-group-text">
                                    <span class="bi bi-lock-fill"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Full Name & NIC Row -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       placeholder="Full Name" value="${fullName != null ? fullName : ''}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-card-heading"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="nic" class="form-label">NIC</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="nic" name="nic"
                                       placeholder="NIC" value="${nic != null ? nic : ''}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-file-person"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Phone Number & Email Row -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                                       placeholder="Phone Number" value="${phoneNumber != null ? phoneNumber : ''}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-telephone-fill"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <input type="email" class="form-control" id="email" name="email"
                                       placeholder="Email" value="${email != null ? email : ''}">
                                <div class="input-group-text">
                                    <span class="bi bi-envelope-fill"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <!-- License Number Row -->
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="licenseNumber" class="form-label">License Number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber"
                                       placeholder="License Number" value="${license != null ? license : ''}">
                                <div class="input-group-text">
                                    <span class="bi bi-person-badge"></span>
                                </div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary w-100">Add Driver</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>


<%@ include file="../footer.jsp" %>


<script>
$(document).ready(function() {
    const form = $('#driverForm');
    
    // Validation patterns
    const patterns = {
        username: /^[a-zA-Z0-9_]{3,20}$/,
        password: /^.{6,}$/,
        fullName: /^[a-zA-Z\s]{2,50}$/,
        nic: /^([0-9]{9}[vVxX]|[0-9]{12})$/,
        phoneNumber: /^(?:\+94|0)?[0-9]{9}$/,
        email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        licenseNumber: /^[A-Z0-9]{7,12}$/
    };

    // Validation messages
    const messages = {
        username: 'Username must be 3-20 characters',
        password: 'Password must be at least 6 characters',
        fullName: 'Please enter a valid full name',
        nic: 'Please enter a valid NIC number',
        phoneNumber: 'Please enter a valid Sri Lankan phone number',
        email: 'Please enter a valid email address',
        licenseNumber: 'Please enter a valid license number'
    };

    // Real-time validation
    form.find('input').on('input', function() {
        validateField($(this));
    });

    // Field validation function
    function validateField($field) {
        const fieldName = $field.attr('name');
        const value = $field.val().trim();
        let isValid = true;

        // Remove existing feedback
        $field.removeClass('is-valid is-invalid');
        $field.closest('.input-group').next('.invalid-feedback').remove();

        // Required field validation
        if ($field.prop('required') && !value) {
            isValid = false;
            showError($field, 'This field is required');
            return false;
        }

        // Pattern validation
        if (patterns[fieldName] && value) {
            isValid = patterns[fieldName].test(value);
            if (!isValid) {
                showError($field, messages[fieldName]);
                return false;
            }
        }

        if (isValid) {
            $field.addClass('is-valid');
        }
        return true;
    }

    // Show error message
    function showError($field, message) {
        $field.addClass('is-invalid');
        const $inputGroup = $field.closest('.input-group');
        $inputGroup.after("<div class='invalid-feedback d-block'>"+message+"</div>");
    }

    // Form submission
    form.on('submit', function(e) {
        let isValid = true;
        form.find('input').each(function() {
            if (!validateField($(this))) {
                isValid = false;
            }
        });

        if (!isValid) {
            e.preventDefault();
        }
    });
});
</script>

