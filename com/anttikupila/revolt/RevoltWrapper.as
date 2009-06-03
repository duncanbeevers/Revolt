package com.anttikupila.revolt {
	[SWF(framerate="10")]
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.anttikupila.revolt.Log;
	
	public class RevoltWrapper extends MovieClip {
		private var revolt:Revolt;
		public function RevoltWrapper() {
			this.addEventListener(Event.ENTER_FRAME, init);
		}
		
		private function init(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, init);
			
			var params:Object = this.root.loaderInfo.parameters;
			this.revolt = new Revolt(params, this.stage.stageWidth, this.stage.stageHeight);
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			this.addChild(this.revolt);
		}
	}
}
