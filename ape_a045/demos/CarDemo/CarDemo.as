package {
	import org.cove.ape.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	/**
	 * This is an example showing use of the WheelParticles and collidable
	 * SpringConstraints used as surfaces in the 'bridge' area. The bouncy
	 * area has a high elasticity setting to push the car back up to the top.
	 */
	[SWF(width="650", height="350", backgroundColor="#334433")] 
	public class CarDemo extends Sprite {
		
		private static var colA:uint = 0x334433;
		private static var colB:uint = 0x3366aa;
		private static var colC:uint = 0xaabbbb;
		private static var colD:uint = 0x6699aa;
		private static var colE:uint = 0x778877;
	
		private var car:Car;
		private var rotator:Rotator;
		
		public function CarDemo() {
		
			// set up the events, main loop handler, and the engine. you don't have to use
			// enterframe. you just need to call the ApeEngine.step() and ApeEngine.paint() 
			// wherever and however you're handling your program cycle.
			stage.frameRate = 55;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			addEventListener(Event.ENTER_FRAME, run);
			
			// Initialize the engine. The argument here is the time step value. 
			// Higher values scale the forces in the sim, making it appear to run
			// faster or slower. Lower values result in more accurate simulations.
			APEngine.init(1/4);
			
			// set up the default diplay container
			APEngine.container = this;
			
			// gravity -- particles of varying masses are affected the same
			APEngine.addMasslessForce(new Vector(0, 3));
			
			// groups - all these classes extend group
			var surfaces:Surfaces = new Surfaces(colA, colB, colC, colD, colE);
			APEngine.addGroup(surfaces);
			
			var bridge:Bridge = new Bridge(colB, colC, colD);
			APEngine.addGroup(bridge);
			
			var capsule:Capsule = new Capsule(colC);
			APEngine.addGroup(capsule);
			
			rotator = new Rotator(colB, colE);
			APEngine.addGroup(rotator);

			var swingDoor:SwingDoor = new SwingDoor(colC);
			APEngine.addGroup(swingDoor);
			
			car = new Car(colC, colE);
			APEngine.addGroup(car);
			
			// determine what collides with what.
			car.addCollidableList(new Array(surfaces, bridge, rotator, swingDoor, capsule));
			capsule.addCollidableList(new Array(surfaces, bridge, rotator, swingDoor));
			
		}
		
		
		private function run(evt:Event):void {
			APEngine.step();
			APEngine.paint();
			rotator.rotateByRadian(.02);
		}
		
				
		private function keyDownHandler(keyEvt:KeyboardEvent):void {
		
			var keySpeed:Number = 0.2;

			if (keyEvt.keyCode == 65) {
				car.speed = -keySpeed;
			} else if (keyEvt.keyCode == 68) {
				car.speed = keySpeed;
			}
		}
		
		
		private function keyUpHandler(keyEvt:KeyboardEvent):void {
			car.speed = 0;
		}
	}
}
