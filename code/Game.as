﻿package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Game extends MovieClip {
		
		
		public function Game() {
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		private function gameLoop(e:Event):void {
			
			Time.update();
			
			player.update();
			
		}// end game loop
		
		
	}// end game class
	
}// end package
