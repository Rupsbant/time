package engine 
{
	import org.cove.ape.AbstractParticle;
	/**
	 * ...
	 * @author Ingmar
	 */
	public class TypeFixed 
	{
		
		public function TypeFixed() { }
		
		public static function post(ap:AbstractParticle):void {
					trace("maak een fixed");
					ap.fixed = true;
					UIBrol.particles.push(ap);
					for each(var tf:TimeField in UIBrol.timeFields) {
						ap.addTimeField(tf);
					}
					UIBrol.collidables.addParticle(ap);
		}
		
	}

}