$(document).ready(function () {
    // Check if user is logged in
    var isLoggedIn = '<%=%>';
    if (isLoggedIn) {
        $("#signin-nav").hide(); // Hide sign in link
        $("#profile-nav").show(); // Show profile link
    } else {
        $("#signin-nav").show(); // Show sign in link
        $("#profile-nav").hide(); // Hide profile link
    }

    // Show signup form and hide login form when "Sign Up" link is clicked
    $("#signup-link").click(function (e) {
        e.preventDefault();
        $("#login-form").hide(); // Hide login form
        $("#signup-form").show(); // Show signup form
        $(".card-header").text("Sign Up"); // Change card header text
    });

    // Show login form and hide signup form when "Login" link is clicked
    $("#login-link").click(function (e) {
        e.preventDefault();
        $("#signup-form").hide(); // Hide signup form
        $("#login-form").show(); // Show login form
        $(".card-header").text("Login"); // Change card header text
    });

    // Handle login form submission
    $("#login-form").submit(function (e) {
        e.preventDefault();
        var email = $("#login-email").val();
        var password = $("#login-password").val();

        // Validate email
        if (!email) {
            $("#login-email-error").text("Email is required.");
            return;
        } else {
            $("#login-email-error").text(""); // Clear previous error message
        }

        // Validate password
        if (!password) {
            $("#login-password-error").text("Password is required.");
            return;
        } else {
            $("#login-password-error").text(""); // Clear previous error message
        }

        // Check if the entered credentials match the admin credentials
        if (email === "admin@admin.com" && password === "admin") {
            // Set isAdmin flag to true for admin
            localStorage.setItem("isAdmin", true);
            localStorage.setItem("isLoggedIn", true);
            window.location.href = "admin.html"; // Redirect to admin.html for admin
        } else {
            // Proceed with regular user login
            var users = JSON.parse(localStorage.getItem("users")) || [];
            var user = users.find(u => u.email === email && u.password === password);
            if (user) {
                localStorage.setItem("isLoggedIn", true);

                window.location.href = "index.html"; // Redirect to index.html for regular user
            } else {
                $("#login-email-error").text("Invalid email or password."); // Show invalid email/password error
            }
        }
    });




    // Handle signout link click
    $("#signout-link").click(function (e) {
        e.preventDefault();
        localStorage.removeItem("isLoggedIn"); // Remove logged in status
        localStorage.removeItem("currentUser"); // Remove current user data
        window.location.href = "BlinkList.aspx"; // Redirect to index.html
    });







});