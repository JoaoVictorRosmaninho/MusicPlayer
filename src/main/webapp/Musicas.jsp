<%-- 
    Document   : Musicas
    Created on : Oct 1, 2021, 2:00:31 PM
    Author     : jv
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <script src="http://code.jquery.com/jquery-latest.min.js"></script>

        <title>JSP Page</title>
    </head>
    <body>
        <div id="result"></div>
        <h1>Hello World!</h1>
        <script>
            let allMusic = [];                 
           $.get("listSource", function(responseJson) {          // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response JSON...
        var $table = $("<table>").appendTo($("#result")); // Create HTML <table> element and append it to HTML DOM element with ID "somediv".
        $.each(responseJson, function(index, product) {    // Iterate over the JSON array.
            $("<tr>").appendTo($table)                     // Create HTML <tr> element, set its text content with currently iterated item and append it to the <table>.
                .append($("<td>").text(product.id))        // Create HTML <td> element, set its text content with id of currently iterated product and append it to the <tr>.
                .append($("<td>").text(product.name))      // Create HTML <td> element, set its text content with name of currently iterated product and append it to the <tr>.
                .append($("<td>").text(product.price)); 
             });
    });
        </script>
    </body>
</html>
