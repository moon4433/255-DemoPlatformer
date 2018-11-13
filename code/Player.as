package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	/**
	  * this is the player class which holds any functions that the player might have
	  * extends to MovieClips so that the movie clip can access the info from the player class
	  */
	public class Player extends MovieClip {



		private var gravity: Point = new Point(0, 800); // sets force of gravity for the player
		private var maxSpeed: Number = 200; // cap for how fast the player can move left or right
		private var velocity: Point = new Point(1, 5); // how far player can move left or right per frame
		
		private var maxJumpHeight: Number; // empty variable to hold the max jump height
		private var maxJumpHeight2: Number; // empty variable to hold the second max jump height

		private const HORIZONTAL_ACCELERATION: Number = 700; // how fast the player can move left or right
		private const HORIZONTAL_DECELERATION: Number = 800; // this is to fake friction for player

		private var isGrounded:Boolean = false; // is the player on the ground
		
		private var isJumping:Boolean = false; //whether the player is moving upward in a jump, this effects gravity.
		private var airJumpsLeft:int = 1; // how many jumps a player has
		private var airJumpsMax:int = 1; // how many extra jumps can player do
		
		private var jumpVelocity:Number = 350; // adds an impulse to the players "upward" velocity
		
		public var collider:AABB;// variable holds an AABB collider


		/**
		  * players constructor function
		  */
		public function Player() {
			// constructor code
		
		collider = new AABB(width/2, height/2); // sets the new AABB to the center of the player
			
			
		} // end constructor

		/**
		  * This is the update function which handles all the update for this class frame by frame
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

			if (KeyboardInput.IsKeyDown(Keyboard.LEFT)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt; // if left arrow is pressed, move left
			if (KeyboardInput.IsKeyDown(Keyboard.RIGHT)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt; // if right arrow is pressed, move right

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

		/**
		  * this function handles any jumping that the player might do
		  */
		private function handleJumping(): void {

				if (KeyboardInput.OnKeyDown(Keyboard.SPACE)) { // if the spacebar is pressed
				
				// apply an impulse up
					if(isGrounded){ // if player is on ground
					velocity.y = -jumpVelocity; // jump
					isGrounded = false; // player is not on ground
					isJumping = true; // player is jumping
					}else{ //in air, attempting to double jump
						if(airJumpsLeft > 0){ // if we have air jumps left:
						velocity.y = -jumpVelocity; // air jump
						airJumpsLeft--; // no jumps left
						isJumping = true; // is jumping
						}
					}
			     }
				 
				 if(!KeyboardInput.IsKeyDown(Keyboard.SPACE)) isJumping = false; // if space is not pressed, player is not jumping
				 if(velocity.y > 0) isJumping = false;
		     }

	    /**
		  *
		  */
		private function doPhysics(): void {
			
			var gravityMultiplyier:Number = 1; //
			
			if(!isJumping) gravityMultiplyier = 2; //
			
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

		/**
		  * This function is to handle if the player is touching the ground or not (really for testing)
		  */
		private function detectGround(): void {
			// look at y position
			var ground: Number = 390; // holds a set number for the ground
			if (y > ground) { // if the player goes past the ground number
				y = ground; // clamp
				velocity.y = 0; // set velocity.y to 0
				airJumpsLeft = airJumpsMax; // adds another jump to the jumps left
				isGrounded = true; // is on ground
				}
			}
			
			/**
			  * this function handles the fix of if the player is overlapping with other objects
			  * @param fix passes a vector into this function
			  */
			public function applyFix(fix:Point):void {
				if(fix.x != 0){ // if there is no gap
					x += fix.x; // push the opposite direction
					velocity.x = 0; // set velocity.x to 0
				}
				if(fix.y != 0){ // if there is no gap
					y += fix.y; // push the opposite direction
					velocity.y = 0; // set velocity.y to 0
				}
				if(fix.y < 0){ // we moved the player UP, so they are on the ground
					airJumpsLeft = airJumpsMax; // reset jumps to max jump
					isGrounded = true; // is back on ground
				}
				collider.calcEdges(x, y); // calculate the colliding edges
				
			}
		


	} // end class

} // end package