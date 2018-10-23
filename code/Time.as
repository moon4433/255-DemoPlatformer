package code {
	import flash.utils.getTimer;
	
	
	/**
	 * The class for handling all game time
	 */
	public class Time {
		
		/**
		 * how much time has passed since the previous frame
		 */
		public static var dt:Number = 0;
		/**
		 * A scaled version of seltatime (dt). uses Time.scale. measured in seconds
		 */
		public static var dtScaled:Number = 0;
		/**
		 * The current frame's timestamp. how many milliseconds have passed since the game began
		 */
		public static var time:Number = 0;

		public static var scale:Number = 1;
		
		private static var timePrev:Number = 0;
		
		public static function update():void {
			time = getTimer();
			dt = (time - timePrev) / 1000;
			dtScaled = dt * scale;
			timePrev = time; // cache for next frame
		}
	}
}
