package {
	import engine.TimeField;
	import flash.geom.Rectangle;
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
	public class Hello extends Sprite {
		public static var r1:RectangleParticle;
		public static var r2:CircleParticle;
		public static var timeFields:Vector.<TimeField> = new Vector.<TimeField>();
		public static var particles:Vector.<AbstractParticle> = new Vector.<AbstractParticle>;
		
		public function Hello() {
		
			// set up the events, main loop handler, and the engine. you don't have to use
			// enterframe. you just need to call the ApeEngine.step() and ApeEngine.paint() 
			// wherever and however you're handling your program cycle.
			stage.frameRate = 55;

			//addEventListener(Event.ENTER_FRAME, run);
			
			// Initialize the engine. The argument here is the time step value. 
			// Higher values scale the forces in the sim, making it appear to run
			// faster or slower. Lower values result in more accurate simulations.
			APEngine.init(1/4);
			
			// set up the default diplay container
			APEngine.container = this;
			
			// gravity -- particles of varying masses are affected the same
			APEngine.addMasslessForce(new Vector2D(0, 3));
			
			r1 = new RectangleParticle(150, 100, 100, 100);
			r1.fixed = true;
			var tf: TimeField = new TimeField(r1.sprite, 4);
			
			var r3:CircleParticle = new CircleParticle(200, 100, 50);
			r3.fixed = true;
			var tf2:TimeField = new TimeField(r3.sprite, 0.3);
			
			r2 = new CircleParticle(100, 50, 10);
			r2.addTimeField(tf);
			r2.addTimeField(tf2);
			var g:Group = new Group();
			g.addParticle(r1);
			g.addParticle(r2);
			g.addParticle(r3);
			APEngine.addGroup(g);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, down);
			new UI(stage);
			
		}
		
		private function down(evt:KeyboardEvent):void {
			if (evt.keyCode == 37) {
				r2.addForce(new Vector2D( -3, 0));
			}else if (evt.keyCode == 38) {
				r2.addForce(new Vector2D(0,-3));
			}else if (evt.keyCode == 39) {
				r2.addForce(new Vector2D(3,0));
			}else if (evt.keyCode == 40) {
				r2.addForce(new Vector2D(0,3));
			}
		}
		
		
		private function run(evt:Event):void {
			APEngine.step();
			APEngine.paint();
		}
		
	}
}
