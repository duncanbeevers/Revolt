package com.anttikupila.revolt.transport {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.AntiAliasType;
	import com.anttikupila.revolt.Log;
	
	public class PlaybackHead extends Sprite {
		private var transport:Transport;
		private var playbackTimeField:TextField;
		private var textFieldHeight:Number;
		private var tf:TextFormat;
		
		[Embed(
			source="Eurostile.ttf",
			fontName="PlaybackHeadFont",
			unicodeRange="U+0030-U+003A",
			mimeType="application/x-font-truetype"
		)]
		private var font:String;
		
		public function PlaybackHead(t:Transport) {
			this.transport = t;
			this.textFieldHeight = 12;
			
			this.tf = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.font = "PlaybackHeadFont";
			tf.size = 12;
			
			this.playbackTimeField = new TextField();
			this.playbackTimeField.autoSize = TextFieldAutoSize.CENTER;
			this.playbackTimeField.embedFonts = true;
			this.playbackTimeField.selectable = false;
			this.playbackTimeField.antiAliasType = AntiAliasType.ADVANCED;
			this.playbackTimeField.x = -3;
			this.playbackTimeField.y = -this.textFieldHeight - 3;
			this.addChild(this.playbackTimeField);
			
			this.addEventListener(Event.ENTER_FRAME, render);
			super();
		}
		
		private function render(e:Event):void {
			var r:Number = 3,
				w:Number = 18, h:Number = this.textFieldHeight;
			
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF, 0.9);
			this.graphics.lineStyle(1, 0x000000, 0.5);
			this.graphics.moveTo(0, r);
			this.graphics.lineTo(r, 0);
			this.graphics.lineTo(w, 0);
			this.graphics.lineTo(w, -h);
			this.graphics.lineStyle(1, 0xFFFFFF, 0.9);
			this.graphics.lineTo(-w, -h);
			this.graphics.lineTo(-w, 0);
			this.graphics.lineStyle(1, 0x000000, 0.5);
			this.graphics.lineTo(-r, 0);
			this.graphics.lineStyle(1, 0xFFFFFF, 0.9);
			this.graphics.lineTo(0, r);
			this.graphics.endFill();
			
			this.playbackTimeField.text = this.transport.time();
			this.playbackTimeField.setTextFormat(this.tf);
		}
	}
}
