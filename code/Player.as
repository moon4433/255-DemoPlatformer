package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;


	public class Player extends MovieClip {



		private var gravity: Point = new Point(0, 100);
		private var maxSpeed: Number = 300;
		private var velocity: Point = new Point(1, 5);
		
		private var maxJumpHeight: Number = y - 100;

		private const HORIZONTAL_ACCELERATION: Number = 800;
		private const HORIZONTAL_DECELERATION: Number = 800;

		private const VERTICAL_ACCELERATION: Number = 1600;
		private const VERTICAL_DECELERATION: Number = 1000;

		private var isJumping: Boolean = false;
		private var isDoubleJump: Boolean = false;
		private var isJumpDone: Boolean = false;
		
		var doubleJumpReady:Boolean = false;
		var upReleasedInAir:Boolean = false;


		public function Player() {
			// constructor code
		} // end constructor

		public function update(): void {

			handleJumping();

			handleWalking();

			doPhysics();

			handleJump();
			
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


			if (KeyboardInput.IsKeyDown(Keyboard.SPACE)) {
				//trace("jump");
				isJumping = true;
				
			}else{
				isJumping = false;
			}
			
		}

		private function doPhysics(): void {
			// apply gravity to velocity
			velocity.x += gravity.x * Time.dt;
			velocity.y += gravity.y * Time.dt;

			// constrain to maxSpeed
			if (velocity.x > maxSpeed) velocity.x = maxSpeed; // clamp going right
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed; // clamp going left



			// apply velocity to position
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;



		}

		private function handleJump(): void {



			if (isJumping == true && isJumpDone == false) {	
					velocity.y -= VERTICAL_ACCELERATION * Time.dt;
				} 
			if(y < maxJumpHeight){
					velocity.y += 300 * Time.dt;
					isJumpDone = true;
				}
				
				if(isJumping && upReleasedInAir){
					velocity.y -= VERTICAL_ACCELERATION * Time.dt;
					doubleJumpReady = false;
				} 
				if(y < 100 && upReleasedInAir){
					
					velocity.y += VERTICAL_DECELERATION * Time.dt;
					upReleasedInAir = false;
					
				}
			
		}


		private function detectGround(): void {
			// look at y position
			var ground: Number = 360;
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
				isJumping = false;
				isJumpDone = false;
				upReleasedInAir = false;
				doubleJumpReady = true;
			}
			else if(y != ground){
				velocity.y += VERTICAL_DECELERATION * Time.dt;
				if(isJumping == false){
				upReleasedInAir = true;
				}
			}
		}


	} // end class

} // end package