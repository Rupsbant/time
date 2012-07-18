package {
	import org.cove.ape.*;

	public class RectComposite extends Composite {
		
		private var cpA:CircleParticle;
		private var cpC:CircleParticle;
		
		public function RectComposite(ctr:Vector, colA:uint, colB:uint) {
			
			// just hard coding here for the purposes of the demo, you should pass
			// everything in the constructor to do it right.
			var rw:Number = 75;
			var rh:Number = 18;
			var rad:Number = 4;
			
			// going clockwise from left top..
			cpA = new CircleParticle(ctr.x-rw/2, ctr.y-rh/2, rad, true);
			var cpB:CircleParticle = new CircleParticle(ctr.x+rw/2, ctr.y-rh/2, rad, true);
			cpC = new CircleParticle(ctr.x+rw/2, ctr.y+rh/2, rad, true);
			var cpD:CircleParticle = new CircleParticle(ctr.x-rw/2, ctr.y+rh/2, rad, true);
			
			cpA.setStyle(0,0,0,colA);
			cpB.setStyle(0,0,0,colA);
			cpC.setStyle(0,0,0,colA);
			cpD.setStyle(0,0,0,colA);
			
			// by default all fixed particles are not repainted. this is for efficiency,
			// since it would be a waste to repaint a non moving particle. in this case
			// we are going to be rotating a group of fixed particles, so we'll turn on 
			// always repaint for each one.
			cpA.alwaysRepaint = true;
			cpB.alwaysRepaint = true;
			cpC.alwaysRepaint = true;
			cpD.alwaysRepaint = true;	
			
			var sprA:SpringConstraint = new SpringConstraint(cpA,cpB,0.5,true,rad * 2);
			var sprB:SpringConstraint = new SpringConstraint(cpB,cpC,0.5,true,rad * 2);
			var sprC:SpringConstraint = new SpringConstraint(cpC,cpD,0.5,true,rad * 2);
			var sprD:SpringConstraint = new SpringConstraint(cpD,cpA,0.5,true,rad * 2);
			
			sprA.setStyle(0,0,0,colA);
			sprB.setStyle(0,0,0,colA);
			sprC.setStyle(0,0,0,colA);
			sprD.setStyle(0,0,0,colA);
			
			// by default all fixed SpringConstraints are not repainted as well. A
			// SpringConstraint will be fixed if both its attached Particles are
			// fixed.
			sprA.alwaysRepaint = true;
			sprB.alwaysRepaint = true;
			sprC.alwaysRepaint = true;
			sprD.alwaysRepaint = true;	
			
			addParticle(cpA);
			addParticle(cpB);
			addParticle(cpC);
			addParticle(cpD);
			
			addConstraint(sprA);
			addConstraint(sprB);
			addConstraint(sprC);
			addConstraint(sprD);
		}
		
		public function get pa():CircleParticle {
			return cpA;
		}
		
		public function get pc():CircleParticle {
			return cpC;
		}
	}
}