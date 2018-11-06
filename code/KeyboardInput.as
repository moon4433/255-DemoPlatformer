package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	
	/** 
	  * This is the KeyboardInput class, it is technically a static class so there will only ever be one of these throughout the entire program 
	  */
	public class KeyboardInput {

				
		static public var keysState:Array = new Array(); // an array to store any current keyStates
		static public var keysPrevState:Array = new Array(); // and array to store any keyStates from the previous frame
		
		/**
		  * this function sets up the keyboard for any stage that this keyboard is on
		  * @param stage is passing the game stage into this function so that the info inside can access any info
		  */
		static public function setup(stage:Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown); // adds key up events
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp); // adds key down events
		}
		
		/**
		 * this functions job is to cache all of the key valuses, for the NEXT frame.
		 */
		static public function update():void {
			
			keysPrevState = keysState.slice(); // in this context, slice() gives us a copy of the array
			
		}
		
		/**
		  * this function handles updating when a key is pressed
		  * @ param keyCode holds the key codes fo certain keys
		  * @ param2 isDown holds t/f and tells if a key is down or not
		  */
		static private function updateKey(keyCode:int, isDown:Boolean):void {
			
			keysState[keyCode] = isDown; // if a key is pressed, keystate is isDown
			
		}
		
		/**
		  * this function handles whenever a key is down
		  * @param e passes any keyboard events into this function
		  */
		static private function handleKeyDown(e:KeyboardEvent):void {
			//trace(e.keyCode);
			updateKey(e.keyCode, true); // when key is pressed, update key is set to true
		}
		
		/**
		  * this function handles whenever a key is up
		  * @param e passes any keyboard events into this function
		  */
		static private function handleKeyUp(e:KeyboardEvent):void {
			
			updateKey(e.keyCode, false); // when key is released, update key is set to false
		}
		
		/**
		  * This function is to handle if a key is down
		  * @param keyCode passes in any current key codes into this function
		  * Return t if a indexed key is pressed/f if a key that isnt a normal key is pressed
		  */
		static public function IsKeyDown(keyCode:int):Boolean {
			
			if(keyCode < 0) return false; // if keycode is less than 0, return false
			if(keyCode >= keysState.length) return false; // if keycode is greater than the array length return false
			
			return keysState[keyCode]; // return the keysState of the keycode
			
		}
		
		/**
		  * This function is to handle if a key is pressed
		  * @param keyCode passes in any current key codes into this function
		  * Return t if a indexed key is pressed/f if a key that isnt a normal key is pressed
		  */
		static public function OnKeyDown(keyCode:int):Boolean {
			
			if(keyCode < 0) return false; // if keyCode is less than 0, return false
			if(keyCode >= keysState.length) return false; // if keycode is greater than the array length return false
			
			return (keysState[keyCode] && !keysPrevState[keyCode]) // return the keysState of the keycode and the opposite of the keyState on the previous frame
			
		}

	}
	
}
