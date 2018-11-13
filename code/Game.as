package code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * This is the game class which holds all functions for the game
	 * Extends to MovieClip so that movie clip can access any info in this class
	 */
	public class Game extends MovieClip {

		static public var platforms: Array = new Array(); // array that hold platforms
		
		private var level:MovieClip;
		
		private var player:Player;

		/**
		 * this is the games class constructor function
		 */
		public function Game() {
			KeyboardInput.setup(stage); // brings the static keyboard class into the stage
			addEventListener(Event.ENTER_FRAME, gameLoop); // brings gameLoop into the stage
			
			
			loadLevel();
		}
		
		private function loadLevel():void {
			
			level = new Level01();
			addChild(level);
			
			
			if(level.player){
				player = level.player;
			} else{
				player = new Player();
				addChild(player);
			}
			
			
		}

		/**
		 * This function is the gameLoop function which handles the continuous looping that games usually do
		 * @param e passes the ENTER_FRAME event into this class
		 */
		private function gameLoop(e: Event): void {
			Time.update(); // update time
			player.update(); // update player
			doCollisionDetection(); // detect any collisions
			
			doCameraMove();
			
			KeyboardInput.update(); // update keyboard

		} // end game loop

		private var shakeTimer: Number = 0;
		private var shakeMultiplier: Number = 20;

		private function shakeCamera(time: Number = .5, mult: Number = 20): void {

			shakeTimer += time;
			shakeMultiplier = mult;
		}

		private function doCameraMove(): void {

			var targetX: Number = -player.x + stage.stageWidth / 2;
			var targetY: Number = -player.y + stage.stageHeight / 2;

			var offsetX: Number = 0; //Math.random() * 20 - 10; 
			var offsetY: Number = 0; //Math.random() * 20 - 10; 

			if (shakeTimer > 0) {
				shakeTimer -= Time.dt;

				var shakeIntensity: Number = shakeTimer;

				if (shakeIntensity > 1) {
					shakeIntensity = 1;
				}

				shakeIntensity = 1 - shakeIntensity; // flip falloff curve 

				shakeIntensity *= shakeIntensity; // bend curve 

				shakeIntensity = 1 - shakeIntensity; // flipp falloff curve 

				var shakeAmount: Number = shakeMultiplier * shakeIntensity;


				offsetX = Math.random() * shakeAmount - (shakeAmount / 2);
				offsetY = Math.random() * shakeAmount - (shakeAmount / 2);
			}

			var camEaseMultiplier: Number = 5;

			level.x += (targetX - level.x) * Time.dt * camEaseMultiplier + offsetX;
			level.y += (targetY - level.y) * Time.dt * camEaseMultiplier + offsetY;


		}

		/**
		 * This function is to handle any collision detection for all platforms
		 */
		private function doCollisionDetection(): void {

			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) { // if overlapping...

					// find the fix
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);


					if (fix.y > 0) {
						shakeCamera(.2, 100);
					}


					// apply the fix
					player.applyFix(fix);

				}

			} // ends for

		} // ends doCollisionDetection

	} // end game class

} // end package