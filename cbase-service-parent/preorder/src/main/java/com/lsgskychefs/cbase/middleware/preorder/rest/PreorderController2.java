package com.lsgskychefs.cbase.middleware.preorder.rest;

import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.BodyInserters.FormInserter;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClient.Builder;

import com.fasterxml.jackson.databind.JsonNode;
import com.lsgskychefs.cbase.middleware.preorder.business.PreorderCbaseService;
import com.lsgskychefs.cbase.middleware.preorder.pojo.PreorderItem;
import com.lsgskychefs.cbase.middleware.preorder.pojo.PreorderSearchRequest;

import io.netty.channel.ChannelOption;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.HttpClient;
import reactor.netty.tcp.ProxyProvider;

@RestController
@RequestMapping("/test2")
public class PreorderController2 {
	
	@Autowired
	private WebClient webClient;
	
    @GetMapping
    public void findAll() {
  
        PreorderSearchRequest search = new PreorderSearchRequest();
    	search.setFromAirportCode("SEA");
    	
        String encodedClientData = Base64Utils.encodeToString("asa-uat-preorder.lsg.client:KHFP9dN4XYPydgs4EbLt".getBytes());
        
        FormInserter<String> fromFormData = BodyInserters.fromFormData("grant_type", "password");
        fromFormData.with("username", "michael.ortwein");
        fromFormData.with("password", "an2br3cL!8H");
        
        Mono<PreorderItem[]> result = webClient.post()
	      .uri("/identity/connect/token")
	      .header("Authorization", "Basic " + encodedClientData)
	      .body(fromFormData)
	      .retrieve()
	      .bodyToMono(JsonNode.class)
	      .flatMap(tokenResponse -> {
	          String accessTokenValue = tokenResponse.get("access_token")
	            .textValue();
	          return webClient.post()
	            .uri(uriBuilder -> uriBuilder
	            	    .path("/preorder/api/v1/PreOrder/search/item")
	            	    //.queryParam("TenantCode", "ASA")
	            	    .build())
	            .headers(h -> h.setBearerAuth(accessTokenValue))
	            .headers(h -> h.add("TenantCode", "ASA"))
	            .body(Mono.just(search), PreorderSearchRequest.class)
	            .retrieve()
	            .bodyToMono(PreorderItem[].class);
	        });
	    
        PreorderItem[] items = result.block();
        System.out.println(String.format("received %s preorders from RIM", items.length));
    }
    
}
