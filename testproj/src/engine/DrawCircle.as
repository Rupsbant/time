package engine 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.cove.ape.CircleParticle;
	import org.cove.ape.Vector2D;
	/**
	 * ...
	 * @author Ingmar
	 */
	public class DrawCircle extends DrawAbstract
	{
		private var sprite:Sprite = new Sprite();
		private var co1:MouseEvent;
		
		public function DrawCircle(mc:MovieClip) 
		{
			super(mc);			
		}
		
		public override function step1(evt:MouseEvent):Function {
			co1 = evt;
			level.addChild(sprite);
			level.addEventListener(MouseEvent.MOUSE_MOVE, drawc);
			trace("part 1");
			return step2;
		}
		
		public function drawc(evt:MouseEvent):void {
				level.removeChild(sprite);
				sprite.graphics.clear();
				sprite.graphics.beginFill(0x00FF00);
				var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(evt.stageX, evt.stageY));
				sprite.graphics.drawCircle(0, 0, radius);
				sprite.graphics.endFill();
				sprite.x = co1.stageX;
				sprite.y = co1.stageY;
				level.addChild(sprite);
		}
		
		
		public function step2(co2:MouseEvent):Function { 
			level.removeEventListener(MouseEvent.MOUSE_MOVE, drawc);
			sprite.graphics.clear();
			trace("part 2");
			var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
			var circ:CircleParticle = new CircleParticle(co1.stageX, co1.stageY, radius);
			UIBrol.post(circ);
			return step1;
		}
		
	}

}