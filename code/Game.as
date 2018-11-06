package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	  * This is the game class which holds all functions for the game
	  * Extends to MovieClip so that movie clip can access any info in this class
	  */
	public class Game extends MovieClip {
		
		static public var platforms:Array = new Array(); // array that hold platforms
		
		/**
		  * this is the games class constructor function
		  */
		public function Game() {
			KeyboardInput.setup(stage); // brings the static keyboard class into the stage
			addEventListener(Event.ENTER_FRAME, gameLoop); // brings gameLoop into the stage
		}
		
		/**
		  * This function is the gameLoop function which handles the continuous looping that games usually do
		  * @param e passes the ENTER_FRAME event into this class
		  */
		private function gameLoop(e:Event):void {
			Time.update(); // update time
			player.update(); // update player
			doCollisionDetection(); // detect any collisions
			KeyboardInput.update(); // update keyboard
			
		}// end game loop
		
		/**
		  * This function is to handle any collision detection for all platforms
		  */
		private function doCollisionDetection():void {
			
			for(var i:int = 0; i < platforms.length; i++){
					if(player.collider.checkOverlap(platforms[i].collider)){ // if overlapping...
						
					// find the fix
					var fix:Point = player.collider.findOverlapFix(platforms[i].collider);
				
					// apply the fix
					player.applyFix(fix);
				
				}
				
			} // ends for
			
		} // ends doCollisionDetection
		
	}// end game class
	
}// end package
