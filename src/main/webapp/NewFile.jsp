<%@page import="java.nio.channels.SeekableByteChannel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel = "stylesheet" type = "text/css" href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<link rel = "stylesheet" type = "text/css" href = "https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<link rel = "stylesheet" type = "text/css" href = "http://fezvrasta.github.io/bootstrap-material-design/dist/css/bootstrap-material-design.css" />
<link rel = "stylesheet" type = "text/css" href = "http://fezvrasta.github.io/bootstrap-material-design/dist/css/ripples.min.css" />
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="http://fezvrasta.github.io/bootstrap-material-design/dist/js/material.min.js"></script>
<script src="http://fezvrasta.github.io/bootstrap-material-design/dist/js/ripples.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/3.4.1/firebase.js"></script>
<script src="https://cdn.firebase.com/libs/angularfire/2.1.0/angularfire.min.js"></script>
<style>
input[type=file] {
    margin: 0 auto;
}

img{
  cursor:pointer;
  width: 100%; 
  height: 200px;
  border-style: solid; 
  border-color: #000000 #000000; 
  border-width: medium;
}
</style>
<script>
(function() {
	  'use strict';

	  angular
	    .module('myApp', ["firebase"])
	    .run(function () {
	  var config = {
    apiKey: "AIzaSyCsszwdt0qaUz5gwtWW3ruPmh-l10AlZnE",
    authDomain: "config-ab653.firebaseapp.com",
    databaseURL: "https://config-ab653.firebaseio.com",
    storageBucket: "config-ab653.appspot.com",
    messagingSenderId: "11382685438"
  };
		  firebase.initializeApp(config);
	    })
	    .controller('imagesController', imagesController)
	    .directive('customOnChange', customOnChange)

	  function imagesController ($firebaseArray) {

	    var vm = this;
	    var storageService = firebase.storage();
	    var ref = firebase.database().ref();
	    var list = $firebaseArray(ref);
	    vm.images = list;
	    vm.deleteImg = deleteImg;
	    vm.downloadImg = downloadImg;

	    vm.image = function(event){
	      event.preventDefault();
	        var file = event.target.files[0];
	      uploadImage(file);
	      };

	    function uploadImage(file) {
	      var random = parseInt(Math.random() * 1000000);
	      var refStorage = storageService.ref('uploads').child(file.name);
	      var uploadTask = refStorage.put(file);
	      

	      uploadTask.on('state_changed', null, function(error){
	        console.log('upload error', error);
	      }, function() {
	        var imageData = {
	          url: uploadTask.snapshot.downloadURL,
	          bytes: uploadTask.snapshot.totalBytes,
	          name: uploadTask.h.name,
	          path: uploadTask.h.fullPath,
	          date: uploadTask.h.timeCreated
	        }

	        list.$add(imageData).then(function(ref) {
	          swal("Success", "Your image has been upload", "success")
	        });
	      }
	    );
	    }

	    function downloadImg(id) {
	      var image = list.$getRecord(id);
	      window.open(image.url, 'Download');
	    }

	    function deleteImg(id) {
	      var image = list.$getRecord(id);

	      swal({
	        title: "Are you sure?",
	        text: "Do you want to remove this image?",
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#DD6B55",
	        confirmButtonText: "Yes, delete it!",
	        closeOnConfirm: false
	      },
	      function(){
	        var imgRef = storageService.ref(image.path);

	        imgRef.delete().then(function() {
	          list.$remove(image).then(function(ref) {
	            swal("Deleted!", "Your image has been deleted.", "success");
	          });
	        }).catch(function(error) {
	          console.log('an error occurred!', error);
	        });
	      });

	    }
	  }

	  function customOnChange() {
	    return {
	      restrict: 'A',
	      link: function (scope, element, attrs) {
	        var onChangeHandler = scope.$eval(attrs.customOnChange);
	        element.bind('change', onChangeHandler);
	      }
	    };
	  }
	  
	})();</script>
  
  <style>
tr:nth-child(even) {
	background: #FF6600
}

tr:nth-child(odd) {
	background: #2a2aae
}

tr:nth-child(odd) {
	color: #FFFFFF
}

tr:nth-child(even) {
	color: #FFFFFF
}
  </style>
</head>
<body>
<%!
  String Str_id;
  


%>
 
<div class="row1" style="height:50px">
    <div class="col-sm-12" style="background-color:orange;height:70px"><h1>99MDM</h1></div>
</div>
<div ng-app="myApp">
<div ng-controller="imagesController as vm">

<%


try {
	Class.forName("com.ibm.db2.jcc.DB2Driver");
    Connection con=DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
    Statement stmt = con.createStatement();
    ResultSet r1 = stmt.executeQuery("select STORE_ID,STR_NM from retail_store");
    %>
    <table BORDER="1" align="center" margin-top="10px">
    <TR>
        <th>Store_Id</th>
        <th>Store_Name</th>
        <th>Upload File</th>
    </tr>
     <%
			while (r1.next()) {
     %>
     <TR>
        <td><a href="Store_Detail.jsp?Value1=<%=r1.getString(1)%>" style="color: cyan"><%=r1.getString(1)%></a></td>
      
        <td><%=r1.getString(2)%></td>
        <td><input type="file"  custom-on-change="vm.image" /></td>
     </tr>
    <% 
			}
     %>
     </table>
     <%
}
catch(Exception e)
{
	out.println(e);
}

%>

<div ng-repeat="image in vm.images | orderBy: '-date'" class="col-xs-6 col-sm-6 col-md-3">
      <div class="col-xs-12 col-sm-12 col-md-12">
        <img ng-src="{{image.url}}">
      </div>
      <div class="col-xs-6 col-sm-6 col-md-6">
        <a href="{{image.url}}" class="btn btn-info btn-block" download>Download</a>
      </div>
      <div class="col-xs-6 col-sm-6 col-md-6">
        <a class="btn btn-danger btn-block" ng-click="vm.deleteImg(image.$id)">Delete</a>
      </div>
    </div>

</div>
</div>
</body>
</html>
