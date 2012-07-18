package {
	import org.cove.ape.*;
	
	public class Capsule extends Group {
		
		public function Capsule(colC:uint) {
	
			var capsuleP1:CircleParticle = new CircleParticle(300,10,14,false,1.3,0.4);
			capsuleP1.setStyle(0, colC, 1, colC);
			addParticle(capsuleP1);
			
			var capsuleP2:CircleParticle = new CircleParticle(325,35,14,false,1.3,0.4);
			capsuleP2.setStyle(0, colC, 1, colC);
			addParticle(capsuleP2);
			
			var capsule:SpringConstraint = new SpringConstraint(capsuleP1, capsuleP2, 1, true, 24);
			capsule.setStyle(5, colC, 1, colC, 1);
			addConstraint(capsule);
		}
	}
}