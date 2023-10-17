<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

<!-- 자체적으로 해당 jsp오면 다른 페이지로 넘어오게 하기 -->
<script>
   location.href = "/gen/main";    
</script>

<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
