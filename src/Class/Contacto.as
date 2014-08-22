package Class
{
	import flash.events.EventDispatcher;
	
	import mx.events.PropertyChangeEvent;

	public class Contacto extends EventDispatcher
	{
		private var _nombre:String;	
		private var _email:String;
		private var _celular:String;
		private var _id_usuario:int;
		private var _id_contacto:int;
		
		public function Contacto(contacto:Object){
			nombre = contacto.nombre;
			email = contacto.email;
			celular = contacto.celular;
			id_usuario = contacto.id_usuario;
			id_contacto = contacto.id_contacto;
		}
		
		[Bindable(event="propertyChange")]
		public function get nombre():String{
			return _nombre;
		}
		
		public function set nombre(newValue:String):void{
			if (newValue != nombre)
			{
				_nombre = newValue;
				
				if (hasEventListener("valueChanged"))
					dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			}
		}
		
		[Bindable(event="propertyChange")]
		public function get email():String{
			return _email;
		}
		
		public function set email(newValue:String):void{
			if (newValue != email)
			{
				_email = newValue;
				
				if (hasEventListener("valueChanged"))
					dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			}
		}
		
		[Bindable(event="propertyChange")]
		public function get celular():String{
			return _celular;
		}
		
		public function set celular(newValue:String):void{
			if (newValue != celular)
			{
				_celular = newValue;
				
				if (hasEventListener("valueChanged"))
					dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			}
		}
		
		[Bindable(event="propertyChange")]
		public function get id_usuario():int{
			return _id_usuario;
		}
		
		public function set id_usuario(newValue:int):void{
			if (newValue != id_usuario)
			{
				_id_usuario = newValue;
				
				if (hasEventListener("valueChanged"))
					dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			}
		}
		
		[Bindable(event="propertyChange")]
		public function get id_contacto():int{
			return _id_contacto;
		}
		
		public function set id_contacto(newValue:int):void{
			if (newValue != id_contacto)
			{
				_id_contacto = newValue;
				
				if (hasEventListener("valueChanged"))
					dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			}
		}
	}
}