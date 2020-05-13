$(document).keyup(function(event) {
    if ($("#guess").is(":focus") && (event.key == "Enter")) {
        $("#goButton").click();
    }
});