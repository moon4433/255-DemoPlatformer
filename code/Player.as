package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {



		private var gravity: Point = new Point(0, 1000);
		private var maxSpeed: Number = 200;
		private var velocity: Point = new Point(1, 5);
		
		private var maxJumpHeight: Number;
		private var maxJumpHeight2: Number;

		private const HORIZONTAL_ACCELERATION: Number = 800;
		private const HORIZONTAL_DECELERATION: Number = 800;

		private var isGrounded:Boolean = false;
		/**
		 *whether the player is moving upward in a jump, this effects gravity.
		 */
		private var isJumping:Boolean = false;
		private var airJumpsLeft:int = 1;
		private var airJumpsMax:int = 1;
		
		private var jumpVelocity:Number = 400;
		
		public var collider:AABB;



		public function Player() {
			// constructor code
		
		collider = new AABB(width/2, height/2);
			
			
		} // end constructor

		/**
		  *
		  */
		public function update(): void {
			handleJumping(); // this handles if the player jumps or not
			handleWalking(); // this handles if the player goes left or right
			doPhysics(); // makes the player act as if gravity was being applied
			collider.calcEdges(x, y); // this consantly calculates the edges for the players AABB
			
			//detectGround(); // this is so player wont fall off screen for testing
			
			isGrounded = false; // this allows us to walk off of edges and no longer be "on the ground"
		}

		/**
		 * this function looks at the keyboard input input in order to accelerate
		 * left or right. As a result, this function changes the player's velocity.
		 */
		private function handleWalking(): void {

			if (KeyboardInput.IsKeyDown(Keyboard.LEFT)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.IsKeyDown(Keyboard.RIGHT)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.IsKeyDown(Keyboard.LEFT) && !KeyboardInput.IsKeyDown(Keyboard.RIGHT)) { // left and right not being pressed...
				if (velocity.x < 0) { // moving left

					velocity.x += HORIZONTAL_DECELERATION * Time.dt; // accelerate right
					if (velocity.x > 0) velocity.x = 0;

				}
				if (velocity.x > 0) { // moving right

					velocity.x -= HORIZONTAL_DECELERATION * Time.dt; // accelerate left
					if (velocity.x < 0) velocity.x = 0;

				}
			}

		}

		private function handleJumping(): void {

				if (KeyboardInput.OnKeyDown(Keyboard.SPACE)) {
				//trace("jump");
				// apply an impulse up
					if(isGrounded){
					velocity.y = -jumpVelocity;
					isGrounded = false;
					isJumping = true;
					}else{ //in air, attempting to double jump
						if(airJumpsLeft > 0){ // if we have air jumps left:
						velocity.y = -jumpVelocity; // air jump
						airJumpsLeft--;
						isJumping = true;
						}
					}
			     }
				 
				 if(!KeyboardInput.IsKeyDown(Keyboard.SPACE)) isJumping = false;
				 if(velocity.y > 0) isJumping = false;
		     }

		private function doPhysics(): void {
			
			var gravityMultiplyier:Number = 1;
			
			if(!isJumping) gravityMultiplyier = 2;
			
			// apply gravity to velocity
			//velocity.x += gravity.x * Time.dt * gravityMultiplyier;
			velocity.y += gravity.y * Time.dt * gravityMultiplyier;

			// constrain to maxSpeed
			if (velocity.x > maxSpeed) velocity.x = maxSpeed; // clamp going right
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed; // clamp going left



			// apply velocity to position
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;



		}

		private function detectGround(): void {
			// look at y position
			var ground: Number = 390;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
				airJumpsLeft = airJumpsMax;
				isGrounded = true;
			}
			}
			
			public function applyFix(fix:Point):void {
				if(fix.x != 0){
					x += fix.x;
					velocity.x = 0;
				}
				if(fix.y != 0){
					y += fix.y;
					velocity.y = 0;
				}
				if(fix.y < 0){ // we moved the player UP, so they are on the ground
					airJumpsLeft = airJumpsMax;
					isGrounded = true;
				}
				collider.calcEdges(x, y);
				
			}
		


	} // end class

} // end package