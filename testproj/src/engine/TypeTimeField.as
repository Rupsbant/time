package engine 
{
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.Group;
	import org.cove.ape.APEngine;
	/**
	 * ...
	 * @author Ingmar
	 */
	public class TypeTimeField 
	{
		
		public function TypeTimeField() 
		{
			
		}
		
		public static function post(ap:AbstractParticle){
					var tf:TimeField = new TimeField(ap.sprite, UIBrol.p.TimeFieldFactorSld.value/100.0);
					ap.fixed = true;
					UIBrol.timeFields.push(tf);
					trace("maak een timefield "+ap+" "+ap.position);
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					for each(var ap:AbstractParticle in UIBrol.particles) {
						ap.addTimeField(tf);
					}
		}
		
	}

}