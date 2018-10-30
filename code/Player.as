package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {



		private var gravity: Point = new Point(0, 1000);
		private var maxSpeed: Number = 300;
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

		public function Player() {
			// constructor code
		} // end constructor

		public function update(): void {

			handleJumping();

			handleWalking();

			doPhysics();
			
			//handleDoubleJump();

			detectGround();
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
			var ground: Number = 360;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
				airJumpsLeft = airJumpsMax;
				isGrounded = true;
			}
			}
		


	} // end class

} // end package