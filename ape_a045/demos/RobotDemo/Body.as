package {
	
	import org.cove.ape.*;

	public class Body extends Composite {
		
		private var top:AbstractParticle;
		private var rgt:AbstractParticle;
		private var lft:AbstractParticle;
		private var bot:AbstractParticle;		
		private var ctr:AbstractParticle;
		
		public function Body(
				left:AbstractParticle, 
				right:AbstractParticle, 
				height:int,
				lineWeight:Number,
				lineColor:uint,
				lineAlpha:Number) {
			
			var cpx:Number = (right.px + left.px) / 2;
			var cpy:Number = right.py; 
			
			
			rgt = new CircleParticle(right.px, right.py, 1);
			rgt.setStyle(3, lineColor, 1, lineColor, 1);		
			lft = new CircleParticle(left.px, left.py, 1);		
			lft.setStyle(3, lineColor, 1, lineColor, 1);
			
			ctr = new CircleParticle(cpx, cpy, 1);	
			ctr.visible = false;
			top = new CircleParticle(cpx, cpy - height / 2, 1);
			top.visible = false			
			bot = new CircleParticle(cpx, cpy + height / 2, 1);	
			bot.visible = false				
			
			
			
			// outer constraints
			var tr:SpringConstraint = new SpringConstraint(top,rgt,1);
			tr.visible = false;
			var rb:SpringConstraint = new SpringConstraint(rgt,bot,1);
			rb.visible = false;
			var bl:SpringConstraint = new SpringConstraint(bot,lft,1);			
			bl.visible = false;
			var lt:SpringConstraint = new SpringConstraint(lft,top,1);
			lt.visible = false;
			
			// inner constrainst
			var ct:SpringConstraint = new SpringConstraint(top,center,1);
			ct.visible = false;
			var cr:SpringConstraint = new SpringConstraint(rgt,center,1);
			cr.setLine(lineWeight, lineColor, lineAlpha);
			var cb:SpringConstraint = new SpringConstraint(bot,center,1);
			cb.visible = false;
			var cl:SpringConstraint = new SpringConstraint(lft,center,1);
			cl.setLine(lineWeight, lineColor, lineAlpha);
			
			ctr.collidable = false;
			top.collidable = false;
			rgt.collidable = false;
			bot.collidable = false;
			lft.collidable = false;
			
			addParticle(ctr);
			addParticle(top);
			addParticle(rgt);
			addParticle(bot);
			addParticle(lft);
			
			addConstraint(tr);
			addConstraint(rb);
			addConstraint(bl);
			addConstraint(lt);
			
			addConstraint(ct);
			addConstraint(cr);
			addConstraint(cb);
			addConstraint(cl);
		}
		
	
		public function get left():AbstractParticle {
			return lft;
		}
			
		public function get center():AbstractParticle {
			return ctr;	
		}
		
		public function get right():AbstractParticle {
			return rgt;
		}
	}
}