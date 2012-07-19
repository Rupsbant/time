
package engine 
{
	import org.cove.ape.AbstractParticle;
	
	/**
	 * ...
	 * @author Ingmar
	 */
	public class TypeVariable 
	{
		public function TypeVariable(){}
		public static function post(ap:AbstractParticle):void {
					trace("maak een movable");
					UIBrol.particles.push(ap);
					for each(var tf:TimeField in UIBrol.timeFields) {
						ap.addTimeField(tf);
					}
					UIBrol.collidables.addParticle(ap);
		}
		
	}

}