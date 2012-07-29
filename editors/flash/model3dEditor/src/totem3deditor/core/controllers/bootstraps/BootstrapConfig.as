package totem3deditor.core.controllers.bootstraps
{
	import org.robotlegs.core.IInjector;
	
	import totem.debug.Logger;
	import totem.display.StageProxy;
	
	public class BootstrapConfig
	{
		
		public function BootstrapConfig( injector : IInjector )
		{
			//  we have to use the injector because you cant do injection in the constructor.
			var stageProxy : StageProxy = injector.getInstance( StageProxy );
			
			Logger.print(this, "Initializing " + this + ".");
			Logger.startup( stageProxy.stage );
		}
	}
}


