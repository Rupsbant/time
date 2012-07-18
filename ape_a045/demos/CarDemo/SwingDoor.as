package {
	
	import org.cove.ape.*;
	
	public class SwingDoor extends Group {
		
		public function SwingDoor(colE:uint) {	
			
			// setting collideInternal allows the arm to hit the hidden stoppers. 
			// you could also make the stoppers its own group and tell it to collide 
			// with the SwingDoor
			collideInternal = true;
			
			var swingDoorP1:CircleParticle = new CircleParticle(543,55,7);
			swingDoorP1.mass = 0.001;
			swingDoorP1.setStyle(1, colE, 1, colE);
			addParticle(swingDoorP1);
			
			var swingDoorP2:CircleParticle = new CircleParticle(620,55,7,true);
			swingDoorP2.setStyle(1, colE, 1, colE);
			addParticle(swingDoorP2);
			
			var swingDoor:SpringConstraint = new SpringConstraint(swingDoorP1, swingDoorP2, 1, true, 13);
			swingDoor.setStyle(2, colE, 1, colE);
			addConstraint(swingDoor);
			
			var swingDoorAnchor:CircleParticle = new CircleParticle(543,5,2,true);
			swingDoorAnchor.visible = false;
			swingDoorAnchor.collidable = false;
			addParticle(swingDoorAnchor);
			
			var swingDoorSpring:SpringConstraint = new SpringConstraint(swingDoorP1, swingDoorAnchor, 0.02);
			swingDoorSpring.restLength = 40;
			swingDoorSpring.visible = false;
			addConstraint(swingDoorSpring);
			
			var stopperA:CircleParticle = new CircleParticle(550,-60,70,true);
			stopperA.visible = false;
			addParticle(stopperA);
			
			var stopperB:RectangleParticle = new RectangleParticle(650,130,42,70,0,true);
			stopperB.visible = false;
			addParticle(stopperB);

		}
	}
}