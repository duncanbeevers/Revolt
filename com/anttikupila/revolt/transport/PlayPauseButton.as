package com.anttikupila.revolt.transport {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.anttikupila.revolt.Log;
	
	public class PlayPauseButton extends Sprite {
		private var transport:Transport;
		private var w:uint, h:uint;
		
		public function PlayPauseButton(t:Transport, iw:uint, ih:uint) {
			this.transport = t;
			this.w = iw;
			this.h = ih;
			this.addEventListener(Event.ENTER_FRAME, render);
			this.addEventListener(MouseEvent.MOUSE_UP, toggle);
			super();
		}
		
		private function toggle(e:Event):void {
			if (this.transport.isPlaying()) {
				this.transport.pause();
			} else {
				this.transport.play();
			}
		}
		
		private function render(e:Event):void {
			var r:Number = 3, padding:uint = 2;
			this.graphics.clear();
			
			// Button border and transparent background to capture mouse clicks
			this.graphics.lineStyle(1, 0x83160F, 0.8);
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(-padding, -padding, this.w + padding * 2, this.h + padding * 2);
			this.graphics.endFill();
			
			// Button body
			this.graphics.lineStyle(1, 0x5A0E08, 0.75);
			this.graphics.beginFill(0x5A0E08, 0.75);
			this.graphics.drawRect(0, 0, this.w, this.h);
			this.graphics.endFill();
			
			// Indicator
			var ox:Number = this.w / 2,
					oy:Number = this.h / 2;
			if (this.transport.isPlaying()) {
				// Draw pause symbol
				var l:Number = 10, hl:Number = l / 2,
						spacing:Number = 4, hs:Number = spacing / 2,
						t:Number = 3;
				this.graphics.lineStyle(1, 0xFFFFFF, 1);
				this.graphics.beginFill(0xFFFFFF, 1);
				this.graphics.drawRect(-hs - t + ox, -hl + oy, t, l);
				this.graphics.drawRect(hs + ox, -hl + oy, t, l);
				this.graphics.endFill();
			} else {
				// Draw play symbol
				var edge:Number = 7, n:Number = 2;
				this.graphics.lineStyle(1, 0xFFFFFF, 1);
				this.graphics.beginFill(0xFFFFFF, 1);
				this.graphics.moveTo(-edge / n + ox, -edge / 2 + oy);
				this.graphics.lineTo((edge / n) * (n - 1) + ox, oy);
				this.graphics.lineTo(-edge / n + ox, edge / 2 + oy);
				this.graphics.endFill();
			}
		}
	}
}
