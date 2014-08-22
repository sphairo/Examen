import Class.Contacto;
import Class.GlobalStatic;

import flash.data.SQLResult;
import flash.data.SQLStatement;
import flash.events.MouseEvent;
import flash.events.SQLErrorEvent;
import flash.events.SQLEvent;

import mx.collections.ArrayCollection;

[Bindable]
internal var stmt:SQLStatement = new SQLStatement();

[Bindable]
internal var contactList:ArrayCollection = new ArrayCollection();

[Bindable]
private var contacto:Class.Contacto;

internal function dbLoaded(op:SQLEvent):void{
	selectContacts();
}

internal function sqlError(err:SQLErrorEvent):void{
	trace(err.error.message);
}

internal function sqlResult(res:SQLEvent):void{
	
	var sqlResult:SQLResult = stmt.getResult();
	if (sqlResult) {		
		var data:Array = sqlResult.data;
		
		contactList = new ArrayCollection();
		
		for each(var item:Object in data){
			contacto = new Contacto(item);
			contactList.addItem(contacto);
		}
	}
}

internal function insertContact(nombre:String, celular:String, email:String):void{
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "INSERT INTO contactos (nombre, celular, email, id_usuario) VALUES('"+nombre+"','"+celular+"','"+email+"', " +this.data.getItemAt(0).id_usuario+");";
	stmt.addEventListener(SQLEvent.RESULT, result);
	stmt.execute();
}

internal function result(event:SQLEvent):void{
	txtCelular.text = "";
	txtNombre.text = "";
	txtEmail.text = "";
	
	stmt = new SQLStatement();
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "SELECT * FROM contactos WHERE id_usuario = " + this.data.getItemAt(0).id_usuario + " ORDER BY id_contacto DESC";
	stmt.addEventListener(SQLErrorEvent.ERROR, sqlError);
	stmt.addEventListener(SQLEvent.RESULT, sqlResult);
	stmt.execute();
}

internal function selectContacts():void{
	stmt = new SQLStatement();
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "SELECT * FROM contactos WHERE id_usuario = " + this.data.getItemAt(0).id_usuario + " ORDER BY id_contacto DESC";
	
	stmt.addEventListener(SQLErrorEvent.ERROR, sqlError);
	stmt.addEventListener(SQLEvent.RESULT, sqlResult);
	stmt.execute();
}

internal function btnguardar1_clickHandler(event:MouseEvent):void{
	if(txtCelular.text == "" ||
		txtNombre.text == "" ||
		txtEmail.text == ""){
		lblError.text = "Complete la información.";
	}else
		insertContact(txtNombre.text, txtCelular.text, txtEmail.text);
}

public function borrarContacto(id_contacto:*):void{
	stmt = new SQLStatement();
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "DELETE FROM contactos WHERE id_usuario = " + this.data.getItemAt(0).id_usuario + " AND id_contacto = " + id_contacto;
	
	stmt.addEventListener(SQLErrorEvent.ERROR, sqlError);
	stmt.addEventListener(SQLEvent.RESULT, borrarContactoExito);
	stmt.execute();
}

internal function borrarContactoExito(event:SQLEvent):void{
	stmt = new SQLStatement();
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "SELECT * FROM contactos WHERE id_usuario = " + this.data.getItemAt(0).id_usuario + " ORDER BY id_contacto DESC";
	stmt.addEventListener(SQLErrorEvent.ERROR, sqlError);
	stmt.addEventListener(SQLEvent.RESULT, sqlResult);
	stmt.execute();
}