<%@	page	 contentType="text/html;charset=UTF-8"	%>
<%@ 	page import = "java.io.*"	%>
<%@ 	page import = "java.net.*"	%>
<%@ 	page import = "org.json.*	"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Currency Converter</title>
	<link rel = "stylesheet" href = "style.css"></link>
</head>
<body>
	<h2>Currency Converter</h2>
	<form method = "POST">
		<label>Enter amount in Rs</label>
		<input type = "number" name = "air" step = "0.1"  placeholder = "Enter amount in Rs" required/></br>
		<div class="radio-group">
		<label><input type = "radio" name = "amt" value = "USD"  checked = true >USD</label>
		<label><input type = "radio" name = "amt" value = "GBP" >GBP</label>
		<label><input type = "radio" name = "amt" value = "SGD">SGD</label>
		<label><input type = "radio" name = "amt" value = "AUD">AUD</label></br>
		</div>
		<input type = "submit" name = "btnSubmit" value = "Convert"  />
	</form>

	<%
		if(request.getParameter("btnSubmit")!=null){
			String msg = "";
			double air = Double.parseDouble(request.getParameter("air"));
			String select = request.getParameter("amt");
			
			try{
				String apiURL = "https://api.exchangerate-api.com/v4/latest/INR";
				URL url = new URL(apiURL);
				HttpURLConnection con = (HttpURLConnection)url.openConnection(); 
				con.setRequestMethod("GET");

				InputStreamReader isr = new InputStreamReader(con.getInputStream(),"UTF-8");
				BufferedReader br = new BufferedReader(isr);
				String jsonStr = "";
				String line = br.readLine();
	
				while(line!=null){
					jsonStr+= line;
					line = br.readLine();
				}

				JSONObject info = new JSONObject(jsonStr);	
				JSONObject rate = info.getJSONObject("rates");
				double amount = rate.getDouble(select);
				
				String symbol = "";
				if(select.equals("USD")){
					symbol = "$";
				}else if(select.equals("GBP")){
					symbol = "£";
				}else if(select.equals("SGD")){
					symbol = "S$";
				}else{
					symbol = "A$";
				}

				msg = "₹"+ air + " = "+ symbol+String.format("%.2f",(air*amount));

			}catch(Exception  e){
				msg = "issue: "+e;
			}
		%>
			<h2 id = "id_msg"><%=msg%></h2>
		<%
		}
	%>
</body>
</html>
