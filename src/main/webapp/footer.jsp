</div> <!--end::Container-->
</div> <!--end::App Content Header--> <!--begin::App Content-->
</main> <!--end::App Main--> <!--begin::Footer-->
<footer class="app-footer"> <!--begin::To the end-->
    <strong>
        Copyright &copy; 2014-2024&nbsp;
        <a href="https://adminlte.io" class="text-decoration-none">Chathura</a>.
    </strong>
    All rights reserved.
    <!--end::Copyright-->
</footer> <!--end::Footer-->
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!--end::App Wrapper--> <!--begin::Script--> <!--begin::Third Party Plugin(OverlayScrollbars)-->
<script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.3.0/browser/overlayscrollbars.browser.es6.min.js"
        integrity="sha256-H2VM7BKda+v2Z4+DRy69uknwxjyDRhszjXFhsL4gD3w=" crossorigin="anonymous"></script>
<!--end::Third Party Plugin(OverlayScrollbars)--><!--begin::Required Plugin(popperjs for Bootstrap 5)-->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha256-whL0tQWoY1Ku1iskqPFvmZ+CHsvmRWx/PIoEvIeWh4I=" crossorigin="anonymous"></script>
<!--end::Required Plugin(popperjs for Bootstrap 5)--><!--begin::Required Plugin(Bootstrap 5)-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha256-YMa+wAM6QkVyz999odX7lPRxkoYAan8suedu4k2Zur8=" crossorigin="anonymous"></script>
<!--end::Required Plugin(Bootstrap 5)--><!--begin::Required Plugin(AdminLTE)-->
<script src="${pageContext.request.contextPath}/js/adminlte.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.blockUI.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body><!--end::Body-->

</html>
<script>
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.onmouseenter = Swal.stopTimer;
            toast.onmouseleave = Swal.resumeTimer;
        }
    });
    function success(message) {
        Swal.fire({
            title: "Success!",
            text: message,
            icon: "success",
            confirmButtonText: "OK"
        });
    }
    function errorMsg(message) {
        Swal.fire({
            title: "Error!",
            text: message,
            icon: "error",
            confirmButtonText: "OK"
        });
    }
    function toastSuccess(title) {
        Toast.fire({
            icon: "success",
            title: title
        });
    }
    function toastError(title) {
        Toast.fire({
            icon: "error",
            title: title
        });
    }
    function blockUi() {
        $.blockUI({ css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff',
                zIndex: '999999',
            } });
    }
    function unblockUi() {
        $.unblockUI();
    }
</script>
<%
    // Remove the attribute so it doesn't persist
    session.removeAttribute("errorMessage");
    session.removeAttribute("successMessage");
%>