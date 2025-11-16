start session
	scc connect offline
    scc set target ApplicationTarget ImportOnly refresh_all
    scc refresh target migrate
	scc close
end session