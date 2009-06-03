package com.anttikupila.revolt.transport {
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.external.ExternalInterface;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	import flash.system.Security;
	import com.anttikupila.revolt.Log;
	
	public class Transport extends Sprite {
		private var sound:Sound;
		private var w:uint;
		private var h:uint;
		private var soundChannel:SoundChannel;
		private var progressBar:ProgressBar;
		private var playPauseButton:PlayPauseButton;
		private var playing:Boolean, paused_at:uint;
		private var lastActivity:uint;
		
		public function Transport(mp3:String, s:Sound, iw:uint, ih:uint, autoPlay:Boolean = false) {
			super();
			this.paused_at = 0;
			this.sound = s;
			this.w = iw;
			this.h = ih;
			
			var bg:Sprite = new Sprite();
			bg.graphics.lineStyle(0, 0x000000, 0);
			bg.graphics.beginFill(0x000000,0);
			bg.graphics.drawRect(0, 0, w, h);
			bg.graphics.endFill();
			this.addChild(bg);
			
			s.load(new URLRequest(mp3));
			
			var button_width:uint = 30, control_height:uint = 15,
					margin:int = 15, h_margin:int = 10;
			
			this.playPauseButton = new PlayPauseButton(this, button_width, control_height);
			this.playPauseButton.x = 0;
			this.playPauseButton.x = margin;
			this.playPauseButton.y = h - h_margin - control_height;
			this.addChild(this.playPauseButton);
			
			this.progressBar = new ProgressBar(this, w - (button_width + margin * 3), control_height);
			this.progressBar.x = button_width + margin * 2;
			this.progressBar.y = h - h_margin - control_height;
			this.addChild(this.progressBar);
			
			var matrix:Matrix = new Matrix();
			var bg_height:uint = control_height + h_margin * 2;
			matrix.createGradientBox(w, bg_height, Math.PI / 2, 0, h - bg_height);
			this.graphics.beginGradientFill('linear', [ 0x808080, 0x000000 ], [ 0.5, 0.3 ], [ 0, 64 ], matrix);
			this.graphics.lineStyle(0, 0x000000, 0);
			this.graphics.drawRect(0, h - bg_height, w, bg_height);
			this.graphics.endFill();
			
			if (autoPlay) { this.play(0); }
			
			Security.allowDomain('*');
			ExternalInterface.addCallback('seek', seek);
			ExternalInterface.addCallback('play', play);
			ExternalInterface.addCallback('stop', stop);
			ExternalInterface.addCallback('pause', pause);
			
			this.activity();
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(MouseEvent.MOUSE_MOVE, onActivity);
			addEventListener(MouseEvent.MOUSE_DOWN, onActivity);
		}
		
		public function play(percent:Number = 0):void {
			this.activity();
			if (0 == arguments.length) {
				this.playAtTime(this.paused_at);
			} else {
				this.playAtTime(percent * this.sound.length);
			}
		}
		
		private function playAtTime(t:uint):void {
			this.pauseAllPlayers();
			if (this.soundChannel) {
				this.soundChannel.stop();
				this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
			}
			this.playing = true;
			this.soundChannel = this.sound.play(t);
			this.soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
		}
		
		public function pause():void {
			if (!this.playing) { return; }
			this.activity();
			this.playing = false;
			if (this.soundChannel) {
				this.paused_at = this.soundChannel.position;
				this.soundChannel.stop();
			}
		}
		
		public function stop():void {
			this.activity();
			this.playing = false;
			this.paused_at = 0;
			this.soundChannel.stop();
			this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
		}
		
		public function progress():Number {
			if (!this.soundChannel) { return 0; }
			return this.soundChannel.position / this.sound.length;
		}
		
		private function seek(time:String):void {
			var ms:Array = time.split(':');
			var m:uint = uint(ms[0]) * 1000 * 60 + uint(ms[1]) * 1000;
			this.playAtTime(m);
		}
		
		public function isPlaying():Boolean {
			return this.playing;
		}
		
		public function time():String {
			if (!this.soundChannel) { return '00:00'; }
			var millis_per_minute:uint = 1000 * 60;
			var millis_per_second:uint = 1000;
			var p:uint = this.soundChannel.position;
			var minutes:uint = p / millis_per_minute;
			p -= minutes * millis_per_minute;
			var seconds:uint = p / millis_per_second;
			
			var m:String, s:String;
			if (minutes < 10) { m = '0' + minutes.toString(); }
			else { m = minutes.toString(); }
			if (seconds < 10) { s = '0' + seconds.toString(); }
			else { s = seconds.toString(); }
			
			return m + ':' + s;
		}
		
		private function soundComplete(e:Event):void {
			this.stop();
		}
		
		private function enterFrame(e:Event):void {
			//inactive for four seconds
			var targetAlpha:Number;
			if (getTimer() - this.lastActivity > 4000){
				targetAlpha = 0;
			} else {
				targetAlpha = 1;
			}
			this.alpha += ((targetAlpha - this.alpha) / 3);
		}
		
		private function onActivity(e:MouseEvent):void {
			this.activity();
		}
		
		private function activity():void {
			this.lastActivity = getTimer();
		}
		
		private function pauseAllPlayers():void {
			try {
				ExternalInterface.call('pauseAllSoundPlayers');
			} catch(_:Error) {}
		}
	}
}
