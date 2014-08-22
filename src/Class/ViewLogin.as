import Class.GlobalStatic;
import Class.Usuario;

import flash.data.SQLResult;
import flash.data.SQLStatement;
import flash.events.MouseEvent;
import flash.events.SQLErrorEvent;
import flash.events.SQLEvent;
import flash.net.NetworkInfo;
import flash.net.NetworkInterface;

import mx.collections.ArrayCollection;
import mx.events.EffectEvent;

[Bindable]
internal var stmt:SQLStatement = new SQLStatement();
[Bindable]
internal var usuario:ArrayCollection = new ArrayCollection();

internal function btnRegistrarse_clickHandler(event:MouseEvent):void{
	parallel2.play();
	parallel2.addEventListener(EffectEvent.EFFECT_END, end);
}

internal function end(event:EffectEvent):void{
	this.navigator.pushView(views.viewRegister);
}

internal function btnEntrar_clickHandler(event:MouseEvent):void{
	selectContacts();
	return;
	if(txtUser.text == "" || txtPassword.text == ""){
		lbl.text = "Debe ingresar usuario y contraseña.";
		return;
	}
	
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
		selectContacts();
	}else
		lbl.text="No esta conectado a internet.";
}

internal function end2(event:EffectEvent):void{
	this.navigator.pushView(views.viewProfile, usuario);
}

internal function sqlResult(res:SQLEvent):void{				
	var sqlResult:SQLResult = stmt.getResult();
	if (sqlResult) {		
		var data:Array = sqlResult.data;
		
		if(data == null)
			lbl.text = "Usuario o contraseña incorrectos."
		else{
			usuario = new ArrayCollection();
			
			parallel3.play();
			parallel3.addEventListener(EffectEvent.EFFECT_END, end2);
			for each(var item:Object in data){
				usuario.addItem(new Usuario(item));
			}			
		}
	}
}

internal function sqlError(e:SQLErrorEvent):void{
	lbl.text = e.error.message.toString();
}

internal function selectContacts():void{
	
	stmt.sqlConnection = GlobalStatic.isDbConnected();
	stmt.text = "SELECT * FROM usuarios WHERE username = '" + txtUser.text +"' AND password = '" + txtPassword.text + "'";
	stmt.addEventListener(SQLErrorEvent.ERROR, sqlError);
	stmt.addEventListener(SQLEvent.RESULT, sqlResult);
	stmt.execute();
}