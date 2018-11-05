package code {
	import flash.geom.Point;
	
	public class AABB {
		
		private var halfWidth:Number;
		private var halfHeight:Number;
		
		public var xmin:Number;
		public var xmax:Number;
		public var ymin:Number;
		public var ymax:Number;

		public function AABB(halfWidth:Number, halfHeight:Number) {
			setSize(halfWidth, halfHeight);
		}
		
		public function setSize(halfWidth:Number, halfHeight:Number):void {
			this.halfWidth = halfWidth;
			this.halfHeight = halfHeight;
			
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
