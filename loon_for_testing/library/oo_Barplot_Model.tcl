
::oo::class create ::loon::classes::Barplot_Model {
    
    superclass ::loon::classes::Plot_Model\
	::loon::classes::withLayers

    
    
    
    constructor {} {
        
        my New_state x double n ""
        my New_state selected double n FALSE
        
	my New_state color color n steelblue
	my New_state selected boolean n FALSE
	my New_state active boolean n TRUE

        
        my SetInitStates n x
	my AddNotLinkableStates x
        
	my setLinkedStates {color selected active}
        
    }
    
    method EvalConfigure {} {
	my variable confDict

        next

        

        
        
    }

    
}
