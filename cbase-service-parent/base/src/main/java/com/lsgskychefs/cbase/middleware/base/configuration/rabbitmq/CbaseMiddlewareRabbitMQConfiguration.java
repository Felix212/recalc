/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.rabbitmq;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;
import com.lsgskychefs.cbase.middleware.base.messaging.ExchangeNames;

/**
 * The Class CbaseMiddlewareRabbitMQConfiguration.
 */
@Configuration
@Profile("rmq")
public class CbaseMiddlewareRabbitMQConfiguration {
	static final String topicExchangeName = "spring-boot-exchange";

	static final String queueName = "spring-boot";

	@Autowired
	private static CbaseMiddlewareConfigurationService configService;

	//
	// @Bean
	// Queue queue() {
	// return new Queue(queueName, false);
	// }
	//
	// @Bean
	// TopicExchange exchange() {
	// return new TopicExchange(topicExchangeName);
	// }
	//
	// @Bean
	// Binding binding(final Queue queue, final TopicExchange exchange) {
	// return BindingBuilder.bind(queue).to(exchange).with("foo.bar.#");
	// }
	//
	// @Bean
	// SimpleMessageListenerContainer container(final ConnectionFactory connectionFactory,
	// final MessageListenerAdapter listenerAdapter) {
	// final SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
	// container.setConnectionFactory(connectionFactory);
	// container.setQueueNames(queueName);
	// container.setMessageListener(listenerAdapter);
	// return container;
	// }

	/*
	 * @Bean MessageListenerAdapter listenerAdapter(final CbaseMiddlewareReceiver receiver) { return new MessageListenerAdapter(receiver,
	 * "receiveMessage"); }
	 */

	private static final boolean NON_DURABLE = false;
	// public static final String QUEUE_IDENT = configService.getApplicationName().concat("-").concat(configService.getJvmRoute());
	public static final String QUEUE_IDENT = "cbasemiddleware-instance1";

	@Bean
	Queue queue() {
		return new Queue(QUEUE_IDENT, true);
	}

	@Bean
	TopicExchange exchange() {
		return new TopicExchange(ExchangeNames.DEFAULT.getValue());
	}

	// @Bean
	// List<Binding> binding(final Queue queue, final TopicExchange exchange) {
	// return Arrays.asList(BindingBuilder.bind(queue()).to(exchange()).with("1"),
	// BindingBuilder.bind(queue()).to(exchange()).with("2"));
	// }

	@Bean
	Binding binding1(final TopicExchange exchange) {
		return BindingBuilder.bind(queue()).to(exchange()).with("1");
	}

	@Bean
	Binding binding2(final TopicExchange exchange) {
		return BindingBuilder.bind(queue()).to(exchange()).with("2");
	}

	@Bean
	public ConnectionFactory connectionFactory() {
		final CachingConnectionFactory connectionFactory = new CachingConnectionFactory("localhost");
		connectionFactory.setUsername("guest");
		connectionFactory.setPassword("guest");
		return connectionFactory;
	}

	@Bean
	public MessageConverter jsonMessageConverter() {
		return new Jackson2JsonMessageConverter();
	}

	@Bean
	public RabbitTemplate rabbitTemplate() {
		final RabbitTemplate template = new RabbitTemplate(connectionFactory());
		// template.setRoutingKey(QueueNames.SEC);
		template.setMessageConverter(jsonMessageConverter());
		return template;
	}
}
