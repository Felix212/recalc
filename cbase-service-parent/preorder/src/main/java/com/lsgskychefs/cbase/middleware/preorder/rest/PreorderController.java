package com.lsgskychefs.cbase.middleware.preorder.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

import com.lsgskychefs.cbase.middleware.preorder.business.PreorderCbaseService;
import com.lsgskychefs.cbase.middleware.preorder.pojo.PreorderItem;
import com.lsgskychefs.cbase.middleware.preorder.pojo.PreorderSearchRequest;

import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/test")
public class PreorderController {
	
	//@Autowired
	//private WebClient webClient;
	
    @GetMapping
    public void findAll() {
    	WebClient webClient = WebClient.create();

        PreorderSearchRequest search = new PreorderSearchRequest();
    	search.setFromAirportCode("SEA");
    	
        Mono<PreorderItem[]> result = webClient.post()
        .uri("https://asa-uat.svc.flight-retail.com/preorder/api/v1/PreOrder/search/item")
        .body(search, PreorderSearchRequest.class)
        .retrieve()
        .bodyToMono(PreorderItem[].class);
        
        System.out.println(result.block());
    }
}
