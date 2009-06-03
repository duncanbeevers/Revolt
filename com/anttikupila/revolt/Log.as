package com.anttikupila.revolt {
	import flash.external.ExternalInterface;
	public class Log {
		public static function console(o:*):void {
			ExternalInterface.call("console.log", o);
		}
	}
}
