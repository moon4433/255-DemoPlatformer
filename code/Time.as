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

		/**
		  * The scale of time, whether it is normal time or slowed down
		  */
		public static var scale:Number = 1;
		
		/**
		  * this is to hold the time from the previous frame
		  */
		private static var timePrev:Number = 0;
		
		/**
		  * This is the update function, which handles making sure the time is current on the current frame
		  */
		public static function update():void {
			time = getTimer(); // storing timer inside a variable
			dt = (time - timePrev) / 1000; // calculating milliseconds to seconds
			dtScaled = dt * scale; // scales the current time from slow to current time
			timePrev = time; // cache for next frame
		}
	}
}
