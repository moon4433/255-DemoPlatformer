package code {
	import flash.geom.Point;
	
	/**
	  * This is the AABB class which holds functions for AABB collision
      */
	public class AABB {
		
		private var halfWidth:Number; // empty variable to hold half width
		private var halfHeight:Number; // empty variable to hold half height
		
		public var xmin:Number; // empty variable to hold the x min
		public var xmax:Number; // empty variable to hold the x max
		public var ymin:Number; // empty variable to hold the y min
		public var ymax:Number; // empty variable to hold the y max

		/**
		  * This is the constructor function of the AABB class
		  * @param halfWidth passes in a number to be the center x position
		  * @param halfHeight passes in a number to be the center y position
		  */
		public function AABB(halfWidth:Number, halfHeight:Number) {
			setSize(halfWidth, halfHeight); // sets AABB to objects halfheight and halfwidth
		}
		
		/**
		  * This function is to handle setting the height and width of the bounding Box
		  * @param halfWidth passes in a number to be the center x position
		  * @param halfHeight passes in a number to be the center y position
		  */
		public function setSize(halfWidth:Number, halfHeight:Number):void {
			this.halfWidth = halfWidth; // sets the half width of the specific object
			this.halfHeight = halfHeight; // sets the half height of the specific object
			
			// recalculate edges!!!!!!!!!!!
			calcEdges((xmin + xmax)/2, (ymin + ymax)/2);
		}
		
		/**
		  * calculate the position of the 4 edges from the cente(x, y) position
		  */
		public function calcEdges(x:Number, y:Number):void{
			
			xmin = x - halfWidth;
			xmax = x + halfWidth;
			ymin = y - halfHeight;
			ymax = y + halfHeight;
			
		}
		
		/**
		  * this function checks to see if thus AABB
		  * is overlapping another AABB.
		  * @param other The other AABB to check this AABB against.
		  * @return Whether or not they are overlapping. if true, they are overlapping
		  */
		public function checkOverlap(other:AABB):Boolean {
			
			if(this.xmax < other.xmin) return false; // gap to the right 
			if(this.xmin > other.xmax) return false; // gap to the left
			if(this.ymax < other.ymin) return false; // gap below 
			if(this.ymin > other.ymax) return false; // gap above
			
			return true;
		}
		
		/**
		  * This function calculates how far to move THIS box so that it no longer
		  * intersects another AABB.
		  * @param other The other AABB.
		  * @return The "fix" vector - how far to move this box.
		  */
		public function findOverlapFix(other:AABB):Point{
			
			var moveL:Number = other.xmin - this.xmax; // calculates if is shorter distance to move left
			var moveR:Number = other.xmax - this.xmin; // calculates if is shorter distance to move right
			var moveU:Number = other.ymin - this.ymax; // calculates if is shorter distance to move up
			var moveD:Number = other.ymax - this.ymin; // calculates if is shorter distance to move down
			
			var fix:Point = new Point(); // creates a new vector
			
			fix.x = (Math.abs(moveL) < Math.abs(moveR)) ? moveL : moveR; // determins if it is shorter to move left or right
			fix.y = (Math.abs(moveU) < Math.abs(moveD)) ? moveU : moveD; // determins if it is shorter to move up or down
			
			if(Math.abs(fix.x) < Math.abs(fix.y)) { // if x is less than y
				fix.y = 0; 
			}
			else {
				fix.x = 0;
			}
			
			return fix;
			
		}
		

	}
	
}
