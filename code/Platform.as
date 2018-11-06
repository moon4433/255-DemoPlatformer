package code {
	
	import flash.display.MovieClip;
	
	/**
	  * this is the platform class which handles all functions for any platform in scene
	  * Extends to MovieClip so that the movie clip can access any info from this class
	  */
	public class Platform extends MovieClip {
		
		public var collider:AABB; // putting an AABB instance inside a variable
		
		/**
		  * this function is the constructor function and sets cetain variables whenever a platform spawns 
		  */
		public function Platform() {
			
			collider = new AABB(width/2, height/2); // brings in a new AABB instance and sets it to the center of the object
			collider.calcEdges(x, y); // calculates the x and y edges of the platform
			
			// add to platforms array...
			Game.platforms.push(this); // pushes whatever platform spawns into the platforms array in the game class
			
		}
	}
	
}
