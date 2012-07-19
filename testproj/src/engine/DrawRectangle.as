package engine 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.cove.ape.APEngine;
	import org.cove.ape.Group;
	import org.cove.ape.RectangleParticle;
	import org.cove.ape.Vector2D;
	/**
	 * ...
	 * @author Ingmar
	 */
	public class DrawRectangle extends DrawAbstract
	{
		
		private var co1:MouseEvent;
		private var co2:MouseEvent;
		private var sprite:Sprite = new Sprite();
		private var tempRect:RectangleParticle;
		
		public function DrawRectangle(mc:MovieClip) {
			super(mc);
		}
		
		public function drawl(evt:MouseEvent):void {
			level.removeChild(sprite);
			sprite.graphics.clear();
			sprite.graphics.lineStyle(5,0x00FF00);
			sprite.graphics.moveTo(co1.stageX, co1.stageY);
			sprite.graphics.lineTo(evt.stageX, evt.stageY);
			level.addChild(sprite);
		}
				
		public function drawl2(evt:MouseEvent):void {
			level.removeChild(tempRect.sprite);
			var breedt:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
			var dx:Number = (co1.stageX - co2.stageX);
			var dy:Number = (co1.stageY - co2.stageY);
			var dx0:Number = (co1.stageX - evt.stageX);
			var dy0:Number = (co1.stageY - evt.stageY);
			var proj:Number = (dx*dy0-dy*dx0)/breedt;
			var angl:Number = Math.atan2(dy, dx)+Math.PI;
			var newX : Number = co1.stageX + breedt / 2 * Math.cos( -angl) + proj / 2 * Math.sin( -angl);
			var newY : Number = co1.stageY - breedt / 2 * Math.sin( -angl) + proj / 2 * Math.cos( -angl);
			g.removeParticle(tempRect);
			tempRect = new RectangleParticle(newX, newY, breedt, proj, angl);
			tempRect.setFill(0x00ff00);
			g.addParticle(tempRect);
		}
					
		public override function step1(evt:MouseEvent):Function {
			co1 = evt;
			level.addChild(sprite);
			level.addEventListener(MouseEvent.MOUSE_MOVE, drawl);
			tempRect = new RectangleParticle(0, 0, 0, 0);
			level.addChild(tempRect.sprite);
			g.addParticle(tempRect);
			return step2;
		}
		
		public function step2(evt:MouseEvent):Function { 
			co2 = evt;
			level.removeEventListener(MouseEvent.MOUSE_MOVE, drawl);
			level.addEventListener(MouseEvent.MOUSE_MOVE, drawl2);
			sprite.graphics.clear();
			return step3;
			}
			
		public function step3(co3:MouseEvent):Function {
				g.removeParticle(tempRect);
				level.removeEventListener(MouseEvent.MOUSE_MOVE, drawl2);
				var breedt:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
				var dx:Number = (co1.stageX - co2.stageX);
				var dy:Number = (co1.stageY - co2.stageY);
				var dx0:Number = (co1.stageX - co3.stageX);
				var dy0:Number = (co1.stageY - co3.stageY);
				var proj:Number = (dx*dy0-dy*dx0)/breedt;
				var angl:Number = Math.atan2(dy, dx)+Math.PI;
				var newX : Number = co1.stageX + breedt / 2 * Math.cos( -angl) + proj / 2 * Math.sin( -angl);
				var newY : Number = co1.stageY - breedt / 2 * Math.sin( -angl) + proj / 2 * Math.cos( -angl);
				var recht:RectangleParticle = new RectangleParticle(newX, newY, breedt, proj, angl);
				UIBrol.post(recht);
				return step1;
		}
	}
}
