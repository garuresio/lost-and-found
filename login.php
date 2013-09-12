<%-- 
    Document   : index
    Created on : May 11, 2013, 10:08:20 PM
    Author     : santiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="ie6 ielt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="ie7 ielt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="ie8"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--> <!--<![endif]-->
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rapido y furioso Car´s</title>
        <link rel="stylesheet" type="text/css" href="login.css" />
    </head>
    <body>
<div class="container">
	<section id="content">
		<form method="post" action="auth.jsp">
			<h1>Inicio de sesion</h1>
			<div>
				<input type="text" placeholder="Username" required="" id="username" name="uname" />
			</div>
			<div>
				<input type="password" placeholder="Password" required="" id="password" name="password" />
			</div>
			<div>
				<input type="submit" value="Iniciar sesion" />
			</div>
		</form>
	</section><!-- content -->
</div><!-- container -->
    </body>
</html>
