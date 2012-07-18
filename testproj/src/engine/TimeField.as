package engine 
{
	import com.coreyoneil.collision.CollisionList;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import org.cove.ape.AbstractParticle;
	/**
	 * ...
	 * @author Ingmar
	 */
	public class TimeField extends EventDispatcher
	{
		public var surface:DisplayObject; 
		public var modifier:Number;
		private var _actives:Vector.<AbstractParticle>;
		
		public function TimeField(surface:DisplayObject,modifier:Number = 1) 
		{
			this.surface = surface;
			this.modifier = modifier;
			_actives = new Vector.<AbstractParticle>();
		}
		
		public function collide(other:AbstractParticle):void {
			trace(_actives);
			var hit:Boolean = new CollisionList(surface, other.sprite).checkCollisions().length == 1;//surface.hitTestObject(other.sprite);
			var active:int = _actives.indexOf(other);
			if (hit && active==-1) {
				other.timeModifier *= modifier;
				_actives.push(other);
			}else if(!hit && active >= 0) {
				other.timeModifier *= 1 / modifier;
				_actives.splice(active, 1);
			};
		}
		
		
		
	}

}