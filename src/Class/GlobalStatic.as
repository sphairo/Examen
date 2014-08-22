package Class
{
	import flash.data.SQLConnection;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	public class GlobalStatic
	{		
		public function GlobalStatic(){}
		
		public static function isDbConnected():SQLConnection{
			var conn:SQLConnection = new SQLConnection();
			var dir:File = File.applicationDirectory;
			var db:File = dir.resolvePath("db.sqlite");
			if(!conn.connected){
				conn.open(db);
				conn.addEventListener(SQLEvent.OPEN, dbLoaded);
				conn.addEventListener(SQLErrorEvent.ERROR, sqlError);
			}
			return conn;
		}
		
		internal static function dbLoaded(e:SQLEvent):void{
			trace(e.target.valueOf());
		}
		
		internal static function sqlError(e:SQLErrorEvent):void{
			trace(e.error.message);
		}
		
		public static function DateToday():Date{
			var fecha:Date = new Date();
			return new Date((fecha.fullYear + "/" + ((fecha.month) + 1)  + "/" + fecha.date).toString());
		}
		
		public static function DateFormat(dateString:String):Date {
			if ( dateString == null ) {
				return null;
			}
			
			if ( dateString.indexOf("0000-00-00") != -1 ) {
				return null;
			}
			
			dateString = dateString.split("-").join("/");
			
			return new Date(Date.parse( dateString ));
		}
	}
}