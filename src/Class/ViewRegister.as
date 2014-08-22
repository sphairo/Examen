import Class.GlobalStatic;
import Class.Usuario;

import flash.data.SQLConnection;
import flash.data.SQLResult;
import flash.data.SQLStatement;
import flash.events.MouseEvent;
import flash.events.SQLErrorEvent;
import flash.events.SQLEvent;
import flash.net.NetworkInfo;
import flash.net.NetworkInterface;

import mx.collections.ArrayCollection;
import mx.formatters.DateFormatter;

[Bindable]
public var conn:SQLConnection = new SQLConnection();
[Bindable]
internal var stmt:SQLStatement = new SQLStatement();

[Bindable]
internal var usuario:ArrayCollection = new ArrayCollection();

internal function btnguardar1_clickHandler(event:MouseEvent):void{
	insertNewUser(txtNombre.text, txtApellidos.text , txtEmail.text, txtUsername.text,txtPassword.text, formatoFechaYYYYMMDD(dateSpinner.selectedDate));
	return;
	var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
	var connected:Boolean = false;
	for(var i:uint = 0; i < interfaces.length; i++) {
		if(interfaces[i].name.toLowerCase() == "wifi" && interfaces[i].active) {
			connected = true;
			break;
		} else if(interfaces[i].name.toLowerCase() == "mobile" && interfaces[i].active) {
			connected = true;
			break;
		}
	}
	if(connected){
		if(txtNombre.text == "" || txtApellidos.text == "" || txtEmail.text == "" || txtUsername.text == "" || txtPassword.text == "")
			lblError.text = "Usted debe completar la información";
		else
			insertNewUser(txtNombre.text, txtApellidos.text , txtEmail.text, txtUsername.text,txtPassword.text, formatoFechaYYYYMMDD(dateSpinner.selectedDate));
	}else
		lblError.text="No esta conectado a internet.";
}

internal function insertNewUser(nombre:String, apellidos:String, email:String, username:String, password:String, fecha_nacimiento:String):void{
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "INSERT INTO usuarios (nombre, apellidos, email, username, password, fecha_nacimiento) VALUES('"+nombre+"','"+apellidos+"','"+email+"', '" +username+"', '"+ password+"', '"+fecha_nacimiento+"');";
	stmt.execute();
	selectContacts();
}

internal function selectContacts():void{
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "SELECT * FROM usuarios WHERE username = '" +txtUsername.text + "' AND password = '" + txtPassword.text + "'";
	
	stmt.addEventListener(SQLErrorEvent.ERROR, sqlError);
	stmt.addEventListener(SQLEvent.RESULT, sqlResult);
	stmt.execute();
}

internal function sqlResult(res:SQLEvent):void{
	
	var sqlResult:SQLResult = stmt.getResult();
	if (sqlResult) {		
		var data:Array = sqlResult.data;
		
		usuario = new ArrayCollection();
		
		for each(var item:Object in data){
			usuario.addItem(new Usuario(item));
		}
	}
	this.navigator.pushView(views.viewProfile, usuario);
}

internal function dbLoaded(op:SQLEvent):void{
	selectContacts();
}

internal function sqlError(err:SQLErrorEvent):void{
	trace(err.error.message);
}

internal function formatoFechaYYYYMMDD(item:Object):String { 
	var formatear:DateFormatter = new DateFormatter();
	formatear.formatString = "YYYY-MM-DD";
	return formatear.format(item);
}
