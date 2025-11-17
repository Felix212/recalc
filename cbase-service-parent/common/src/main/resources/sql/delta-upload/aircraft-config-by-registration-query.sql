  SELECT distinct cen_airlines.cairline,   
         cen_aircraft.cactype,   
         cen_aircraft.cgalleyversion,   
         cen_aircraft.naircraft_key,   
         cen_aircraft.nairline_owner_key,   
         cen_aircraft_configurations.ngroup_key,   
         cen_aircraft_configurations.ndefault,   
         CBASE_FUNCTIONS.PF_GET_AIRCRAFT_CONFIG(cen_aircraft.naircraft_key , cen_aircraft_configurations.ngroup_key) comp_configuration
    FROM cen_aircraft,   
         cen_aircraft_configurations,   
         cen_aircraft_registrations,   
         cen_airlines  
   WHERE ( cen_aircraft_configurations.naircraft_key = cen_aircraft.naircraft_key ) and  
         ( cen_aircraft_registrations.naircraft_key = cen_aircraft.naircraft_key ) and  
         ( cen_airlines.nairline_key = cen_aircraft.nairline_owner_key ) and  
         ( cen_aircraft_registrations.cregistration = :arg_cregistration )