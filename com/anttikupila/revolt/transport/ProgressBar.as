package com.anttikupila.revolt.transport {
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.anttikupila.revolt.Log;
	
	public class ProgressBar extends Sprite {
		private var transport:Transport;
		private var w:uint, h:uint;
		public var playbackHead:PlaybackHead;
		
		public function ProgressBar(t:Transport, iw:uint, ih:uint) {
			this.transport = t;
			this.w = iw;
			this.h = ih;
			this.playbackHead = new PlaybackHead(t);
			this.addChild(playbackHead);
			
			this.addEventListener(Event.ENTER_FRAME, render);
			this.addEventListener(MouseEvent.MOUSE_UP, seek);
			super();
		}
		
		private function seek(e:MouseEvent):void {
			if (e.localX >= 0 && e.localX <= this.w) {
				this.transport.play(e.localX / this.w);
			}
		}
		
		private function render(e:Event):void {
			this.graphics.clear();
			
			var padding:uint = 2;
			
			// Transport border and transparent background to capture mouse clicks
			this.graphics.lineStyle(1, 0x83160F, 0.8);
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(-padding, -padding, this.w + padding * 2, this.h + padding * 2);
			this.graphics.endFill();
			
			// Transport progress meter
			var true_x:uint = this.transport.progress() * this.w;
			var speed:Number = (true_x - this.playbackHead.x) / 3;
			this.playbackHead.x += speed;
			
			this.graphics.lineStyle(1, 0x5A0E08, 0.75);
			this.graphics.beginFill(0x5A0E08, 0.75);
			this.graphics.drawRect(0, 0, this.playbackHead.x, this.h);
			this.graphics.endFill();
		}
	}
}
