<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/tyyli.css">
<title>Teht�v�5</title>
</head>
<body>
	<form id="tiedot">
		<table>
			<thead>
				<tr>
					<th colspan="6" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
				</tr>
				<tr>
					<th>Asiakasnumero</th>
					<th>Etunimi</th>
					<th>Sukunimi</th>
					<th>Puhelin</th>
					<th>Sposti</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="asiakasID" id="asiakasID"></td>
					<td><input type="text" name="etunimi" id="etunimi"></td>
					<td><input type="text" name="sukunimi" id="sukunimi"></td>
					<td><input type="text" name="puhelin" id="puhelin"></td> 
					<th><input type="text" name="sposti" id="sposti"></th>
					<td><input type="submit" id="tallenna" value="Lis��"></td>
				</tr>
			</tbody>		
		</table>
	</form>
	<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	$("#tiedot").validate({						
		rules: {
			asiakasID:  {
				required: true,
				number: true,
				minlength: 1				
			},	
			etunimi:  {
				required: true,
				minlength: 2				
			},
			sukunimi:  {
				required: true,
				minlength: 2
			},	
			puhelin:  {
				required: true,
				number: true,
				minlength: 10
			},
			sposti: {
				required: true,
				minlength: 5
			}
		},
		messages: {
			asiakasID: {     
				required: "Puuttuu",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt"			
			},
			etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt"
			},
			sposti:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
		submitHandler: function(form) {	
			lisaaTiedot();
		}
	});
	
});
	
	function lisaaTiedot(){	
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
		$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
			if(result.response==0){
	      	$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
	      }else if(result.response==1){			
	      	$("#ilmo").html("Asiakkaan lis��minen onnistui.");
	      	$("#asiakasID", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
			}
	  }});	
	}

</script>
</html>