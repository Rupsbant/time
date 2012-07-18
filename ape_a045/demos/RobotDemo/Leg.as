
package {
	import org.cove.ape.*;
	import flash.display.Graphics;
	
	public class Leg extends Composite {

		private var sg:Graphics;
				
		private var pa:CircleParticle;
		private var pb:CircleParticle;
		private var pc:CircleParticle;
		private var pd:CircleParticle;
		private var pe:CircleParticle;
		private var pf:CircleParticle;
		private var ph:CircleParticle;
	
		private var lineColor:uint;
		private var lineAlpha:Number;
		private var lineWeight:Number;
		
		private var fillColor:uint;
		private var fillAlpha:Number;
		private var _visible:Boolean;
		
		public function Leg (
				px:Number, 
				py:Number, 
				orientation:int, 
				scale:Number, 
				lineWeight:Number,
				lineColor:uint,
				lineAlpha:Number,
				fillColor:uint,
				fillAlpha:Number) {
			
			this.lineColor = lineColor;
			this.lineAlpha = lineAlpha;
			this.lineWeight = lineWeight;
			
			this.fillColor = fillColor;
			this.fillAlpha = fillAlpha;
			
			sg = sprite.graphics;
			
			// top triangle -- pa is the attach point to the body
			var os:Number = orientation * scale;
			pa = new CircleParticle(px + 31 * os, py - 8 * scale, 1);
			pb = new CircleParticle(px + 25 * os, py - 37 * scale, 1);
			pc = new CircleParticle(px + 60 * os, py - 15 * scale, 1);
			
			// bottom triangle particles -- pf is the foot
			pd = new CircleParticle(px + 72 * os, py + 12 * scale,  1);
			pe = new CircleParticle(px + 43 * os, py + 19 * scale,  1);
			pf = new CircleParticle(px + 54 * os, py + 61 * scale,  2);
			
			// strut attach point particle
			ph = new CircleParticle(px, py, 3);
			
			// top triangle constraints
			var cAB:SpringConstraint = new SpringConstraint(pa,pb,1);
			var cBC:SpringConstraint = new SpringConstraint(pb,pc,1);
			var cCA:SpringConstraint = new SpringConstraint(pc,pa,1);
			
			// middle leg constraints
			var cCD:SpringConstraint = new SpringConstraint(pc,pd,1);
			var cAE:SpringConstraint = new SpringConstraint(pa,pe,1);
			
			// bottom leg constraints
			var cDE:SpringConstraint = new SpringConstraint(pd,pe,1);
			var cDF:SpringConstraint = new SpringConstraint(pd,pf,1);
			var cEF:SpringConstraint = new SpringConstraint(pe,pf,1);
			
			// cam constraints
			var cBH:SpringConstraint = new SpringConstraint(pb,ph,1);
			var cEH:SpringConstraint = new SpringConstraint(pe,ph,1);
			
			addParticle(pa);
			addParticle(pb);
			addParticle(pc);
			addParticle(pd);
			addParticle(pe);
			addParticle(pf);
			addParticle(ph);	
			
			addConstraint(cAB);
			addConstraint(cBC);
			addConstraint(cCA);
			addConstraint(cCD);
			addConstraint(cAE);
			addConstraint(cDE);
			addConstraint(cDF);
			addConstraint(cEF);
			addConstraint(cBH);
			addConstraint(cEH);	
			
			// for added efficiency, only test the feet (pf) for collision. these
			// selective tweaks should always be considered for best performance.
			pa.collidable = false;
			pb.collidable = false;
			pc.collidable = false;
			pd.collidable = false;
			pe.collidable = false;
			ph.collidable = false;
			
			_visible = true;
		}
	
	
		public function get cam():CircleParticle {
			return ph;
		}


		public function get fix():CircleParticle {
			return pa;
		}
		

		// in most cases when you want to do custom painting youll need to override init because
		// it sets up the sprites with vector drawings that get moved around in the default paint
		// method. in this case were dynamically drawing the legs so we dont need to do anything
		// with the init override, eg draw the leg first and then move it around in the paint method.
		// by doing nothing here we prevent the init from being called on all the particles and 
		// constraints of the leg, which is what we want.
		public override function init():void {
		}
		
		
		public override function paint():void {
			
			sg.clear();
			if (! _visible) return;
			
			sg.lineStyle(lineWeight, lineColor, lineAlpha);
			sg.beginFill(fillColor, fillAlpha);
			
			sg.moveTo(pa.px, pa.py);
			sg.lineTo(pb.px, pb.py);
			sg.lineTo(pc.px, pc.py);
			sg.lineTo(pa.px, pa.py);
			
			sg.moveTo(pd.px, pd.py);
			sg.lineTo(pe.px, pe.py);
			sg.lineTo(pf.px, pf.py);
			sg.lineTo(pd.px, pd.py);
			sg.endFill();
			
			// triangle to triangle
			sg.moveTo(pa.px, pa.py);
			sg.lineTo(pe.px, pe.py);
			sg.moveTo(pc.px, pc.py);
			sg.lineTo(pd.px, pd.py);
			
			// leg motor attachments
			sg.moveTo(pb.px, pb.py);
			sg.lineTo(ph.px, ph.py);
			sg.moveTo(pe.px, pe.py);
			sg.lineTo(ph.px, ph.py);
			
			sg.drawCircle(pf.px, pf.py, pf.radius);
		}
		
		
		public function set visible(b:Boolean):void {
			_visible = b;
		}
	}
}