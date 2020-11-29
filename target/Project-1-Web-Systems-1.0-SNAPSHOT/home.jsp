<%--
  Created by IntelliJ IDEA.
  User: atiyakailany
  Date: 11/25/20
  Time: 9:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Facebook Login JavaScript</title>
    <meta charset="UTF-8">
</head>

<body>
<script>
    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            //session.setAttribute("accessToken", response.authResponse.accessToken);
            //< c:set var="accessToken" value=response.authResponse.accessToken scope="request"/>

            // Logged into your app and Facebook
            storeUserID
            storeImages();
            testAPI();
        }
        else {
            // The person is not logged into your app or we are unable to tell.
           // document.getElementById('status').innerHTML = 'Please log ' + 'into this app.';
            console.log("Login unsuccessful");

        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }


    //CALL FB.init
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '874548586626136',
            cookie     : true,  // enable cookies to allow the server to access
            // the session
            xfbml      : true,  // parse social plugins on this page
            version    : 'v9.0' // use graph api version 2.8
        });


        // NOW that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus().  This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide.  They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        //    your app or not.
        //
        // These three cases are handled in the callback function.
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    };



    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));


    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML =
                'Thanks for logging in, ' + response.name + '!';
        });
    }

    function storeUserID() {
        var userID = null;
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Successful login for: ' + response.name);
            userID = response.id;

        });
        document.getElementById('userID').value = userID;

        // session.setAttribute("userID", userID);

    }

    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function storeImages() {

        console.log('Welcome!  Fetching your information.... ');
        var imageLinks = new Array();
        var imageID = new Array();
        FB.api('/me/albums?fields=photos{webp_images}', function(response) {

            console.log('Successful login for: ' + response.name);
            var photos = response.photos.data;


            photos.forEach(photo =>{
                imageLinks.push(photo.webp_images[0].source)
                imageID.push(photo.id)
            });
            document.getElementById('imageLinks').value = imageLinks;
            document.getElementById('imageID').value = imageID;
            //document.getElementById("form_home").submit();



            // session.setAttribute("imageLinks", imageLinks);
            // session.setAttribute("photoID", imageID);


            // document.getElementById('status').innerHTML =
            //     'Thanks for logging in, ' + response.name + '!';
        });
    }




</script>

<!--    Below we include the Login Button social plugin. This button uses
    the JavaScript SDK to present a graphical Login button that triggers
    the FB.login() function when clicked.  -->

<fb:login-button scope="user_photos" onlogin="checkLoginState();">
</fb:login-button>
<br><br>


<p>To Run the Dominant color app on your application click <a href="app">here</a></p>


<form id="form_home" action="/processImages" method="post">
    <input type="hidden" name="userID"  id="userID">
    <input type="hidden" name="imageLinks"  id="imageLinks">
    <input type="hidden" name="imageID"  id="imageID">

    <div id="status">  </div>


    <input type="submit" class="btn btn-default btn-block" value="Submit">

</form>



<br><br>


</body>
</html>