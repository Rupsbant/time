package {
	import org.cove.ape.*;
	
	public class Rotator extends Group {
		
		private	var ctr:Vector;
		private var rectComposite:RectComposite;
		
		/**
		 * This is a Group containing a Composite object for the rectangle shape
		 * and additional contraints and particles for the swinging arms 
		 * 
		 * Because we want the swinging arm to collide with the turning rectangle
		 * collideInternal is set to true for the Group. Since Composites are never
		 * checked internally, this is still efficient. Only the swinging arm is 
		 * checked for collision against the turning rectangle sides, which are
		 * made out of colidable SpringConstraint objects.
		 */
		 	
		public function Rotator(colA:uint, colB:uint) {
				
			collideInternal = true;
			
			ctr = new Vector(555,175);
			rectComposite = new RectComposite(ctr, colA, colB);
			addComposite(rectComposite);
			
			var circA:CircleParticle = new CircleParticle(ctr.x,ctr.y,5);
			circA.setStyle(1, colA, 1, colB);
			addParticle(circA);
			
			var rectA:RectangleParticle = new RectangleParticle(555,160,10,10,0,false,3);
			rectA.setStyle(1, colA, 1, colB);
			addParticle(rectA);
			
			var connectorA:SpringConstraint = new SpringConstraint(rectComposite.pa, rectA, 1);
			connectorA.setStyle(2, colB);
			addConstraint(connectorA);
	
			var rectB:RectangleParticle = new RectangleParticle(555,190,10,10,0,false,3);
			rectB.setStyle(1, colA, 1, colB);
			addParticle(rectB);
					
			var connectorB:SpringConstraint = new SpringConstraint(rectComposite.pc, rectB, 1);
			connectorB.setStyle(2, colB);
			addConstraint(connectorB);
			
		}
		
		public function rotateByRadian(a:Number):void {
			rectComposite.rotateByRadian(a, ctr);
		}
	}
}