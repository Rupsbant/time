package {
	
	import org.cove.ape.*;
	
	public class Robot extends Group {
		
		private var body:Body;
		private var motor:Motor;
		
		private var direction:int;
		private var powerLevel:Number;
		
		private var powered:Boolean;
		private var legsVisible:Boolean;
		
		private var legLA:Leg;
		private var legRA:Leg;
		private var legLB:Leg;
		private var legRB:Leg;
		private var legLC:Leg;
		private var legRC:Leg;
		
		public function Robot(px:Number, py:Number, scale:Number, power:Number) {
			
			// legs
			legLA = new Leg(px, py, -1, scale, 2, 0x444444, 1, 0x222222, 1);
			legRA = new Leg(px, py,  1, scale, 2, 0x444444, 1, 0x222222, 1);
			legLB = new Leg(px, py, -1, scale, 2, 0x666666, 1, 0x444444, 1);
			legRB = new Leg(px, py,  1, scale, 2, 0x666666, 1, 0x444444, 1);
			legLC = new Leg(px, py, -1, scale, 2, 0x888888, 1, 0x666666, 1);
			legRC = new Leg(px, py,  1, scale, 2, 0x888888, 1, 0x666666, 1);
			
			// body
			body = new Body(legLA.fix, legRA.fix, 30 * scale, 2, 0x336699, 1);
			
			// motor
			motor = new Motor(body.center, 8 * scale, 0x336699);
			
			// connect the body to the legs
			var connLA:SpringConstraint = new SpringConstraint(body.left,  legLA.fix, 1);
			var connRA:SpringConstraint = new SpringConstraint(body.right, legRA.fix, 1);
			var connLB:SpringConstraint = new SpringConstraint(body.left,  legLB.fix, 1);
			var connRB:SpringConstraint = new SpringConstraint(body.right, legRB.fix, 1);
			var connLC:SpringConstraint = new SpringConstraint(body.left,  legLC.fix, 1);
			var connRC:SpringConstraint = new SpringConstraint(body.right, legRC.fix, 1);

			
			// connect the legs to the motor
			legLA.cam.position = motor.rimA.position;
			legRA.cam.position = motor.rimA.position;
			var connLAA:SpringConstraint = new SpringConstraint(legLA.cam, motor.rimA, 1);
			var connRAA:SpringConstraint = new SpringConstraint(legRA.cam, motor.rimA, 1);
			
			legLB.cam.position = motor.rimB.position;
			legRB.cam.position = motor.rimB.position;
			var connLBB:SpringConstraint = new SpringConstraint(legLB.cam, motor.rimB, 1);
			var connRBB:SpringConstraint = new SpringConstraint(legRB.cam, motor.rimB, 1);		
			
			legLC.cam.position = motor.rimC.position;
			legRC.cam.position = motor.rimC.position;
			var connLCC:SpringConstraint = new SpringConstraint(legLC.cam, motor.rimC, 1);
			var connRCC:SpringConstraint = new SpringConstraint(legRC.cam, motor.rimC, 1);
			
			connLAA.setLine(2,0x999999);
			connRAA.setLine(2,0x999999);
			connLBB.setLine(2,0x999999);
			connRBB.setLine(2,0x999999);
			connLCC.setLine(2,0x999999);
			connRCC.setLine(2,0x999999);
			
			// add to the engine
			addComposite(legLA);
			addComposite(legRA);
			addComposite(legLB);
			addComposite(legRB);
			addComposite(legLC);
			addComposite(legRC);
				
			addComposite(body); 
			addComposite(motor);
			
			addConstraint(connLA);
			addConstraint(connRA);
			addConstraint(connLB);
			addConstraint(connRB);
			addConstraint(connLC);
			addConstraint(connRC);			
			
			addConstraint(connLAA); 
			addConstraint(connRAA);
			addConstraint(connLBB); 
			addConstraint(connRBB);
			addConstraint(connLCC); 
			addConstraint(connRCC);
			
			direction = -1
			powerLevel = power; 
			
			powered = true;
			legsVisible = true;
		}
		
		
		public function get px():Number {
			return body.center.px;
		}
		
		
		public function get py():Number {
			return body.center.py;
		}	
		
		
		public function run():void {
			motor.run();
		}
		
		
		public function togglePower():void {
			
			powered = !powered
			
			if (powered) {
				motor.power = powerLevel * direction;
				stiffness = 1;
				APEngine.damping = 0.99;
			} else {
				motor.power = 0;
				stiffness = 0.2;				
				APEngine.damping = 0.35;
			}
		}
		
		
		public function toggleDirection():void {
			direction *= -1;
			motor.power = powerLevel * direction;
		}
		
		
		public function toggleLegs():void {
			legsVisible = ! legsVisible;
			if (!legsVisible) {
				legLA.visible = false;
				legRA.visible = false;
				legLB.visible = false;
				legRB.visible = false;
			} else {
				legLA.visible = true;
				legRA.visible = true;		
				legLB.visible = true;
				legRB.visible = true;
			}
		}
		
		
		private function set stiffness(s:Number):void {
			
			// top level constraints in the group
			for (var i:int = 0; i < constraints.length; i++) {
				var sp:SpringConstraint = constraints[i]; 
				sp.stiffness = s;
			}
			
			// constraints within this groups composites
			for (var j:int = 0; j < composites.length; j++) {
				for (i = 0; i < composites[j].constraints.length; i++) {
					sp = composites[j].constraints[i]; 
					sp.stiffness = s;
				}
			}
		}
	}
}