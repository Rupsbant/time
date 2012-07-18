package {
	
	import org.cove.ape.*;
	
	public class Car extends Group {
		
		private var wheelParticleA:WheelParticle;
		private var wheelParticleB:WheelParticle;
		
		
		public function Car(colC:uint, colE:uint) {
			
			wheelParticleA = new WheelParticle(140,10,14,false,2);
			wheelParticleA.setStyle(0, colC, 1, colE);
			addParticle(wheelParticleA);
			wheelParticleA.sprite.cacheAsBitmap = true;
			
			wheelParticleB = new WheelParticle(200,10,14,false,2);
			wheelParticleB.setStyle(0, colC, 1, colE);
			addParticle(wheelParticleB);
			wheelParticleB.sprite.cacheAsBitmap = true;
			
			var wheelConnector:SpringConstraint = new SpringConstraint(wheelParticleA, wheelParticleB,
					0.5, true, 8);
			wheelConnector.setStyle(0, colC, 1, colE);
			addConstraint(wheelConnector);
		}
		
		
		public function set speed(s:Number):void {
			wheelParticleA.angularVelocity = s;
			wheelParticleB.angularVelocity = s;
		}
	}
}