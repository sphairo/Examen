package Class
{
	import flash.events.EventDispatcher;
	
	import mx.events.PropertyChangeEvent;

	public class Usuario extends EventDispatcher
	{
		private var _nombre:String;	
		private var _apellidos:String;
		private var _email:String;
		private var _fecha_nacimiento:Date = GlobalStatic.DateToday();
		private var _id_usuario:int;
		
		public function Usuario(Usuario:Object){
			nombre = Usuario.nombre;
			apellidos = Usuario.apellidos;
			email = Usuario.email;
			fecha_nacimiento = GlobalStatic.DateFormat(Usuario.fecha_nacimiento);
			id_usuario = Usuario.id_usuario;
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
		public function get apellidos():String{
			return _apellidos;
		}
		
		public function set apellidos(newValue:String):void{
			if (newValue != apellidos)
			{
				_apellidos = newValue;
				
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
		public function get fecha_nacimiento():Date{
			return _fecha_nacimiento;
		}
		
		public function set fecha_nacimiento(newValue:Date):void{
			if (newValue != fecha_nacimiento)
			{
				_fecha_nacimiento = newValue;
				
				if (hasEventListener("valueChanged"))
					dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			}
		}
	}
}