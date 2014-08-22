import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import mx.events.FlexEvent;
import mx.events.FlexMouseEvent;

internal function onShowDefaultCalloutClick():void {
	defaultCallout.open(btnMenu);
}

internal function onMouseDownOutside(event:FlexMouseEvent):void {
	event.target.close();
}

internal function defaultCallout_mouseDownHandler(event:MouseEvent):void{
	defaultCallout.close();
}

internal function image1_clickHandler(event:MouseEvent):void{
	defaultCallout.close();
	this.navigator.pushView(views.viewLogin, this.data);
}

internal function rendercatalogoproductos1_clickHandler(event:MouseEvent):void{
	defaultCallout.close();
	this.navigator.pushView(views.viewContacts, this.data);
}

internal function view1_creationCompleteHandler(event:FlexEvent):void{
	parallel2.play();
	parallel3.play();
}

internal function emailIcon_clickHandler():void{
	navigateToURL((new URLRequest("mailto:" + "sphairo_529@hotmail.com")));
}