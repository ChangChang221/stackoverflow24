package com.stackoverflow.nhom24.elasticsearch.config;

import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.client.ClientConfiguration;
import org.springframework.data.elasticsearch.client.RestClients;
import org.springframework.data.elasticsearch.config.AbstractElasticsearchConfiguration;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;

import java.net.InetAddress;


@Configuration
@EnableElasticsearchRepositories(basePackages = "com.stackoverflow.nhom24.elasticsearch.repository")
@ComponentScan(basePackages = { "com.stackoverflow.nhom24.elasticsearch" })
public class ElasticsearchConfig extends AbstractElasticsearchConfiguration {
    @Value("${elasticsearch.host}")
    private String esHost;

    @Value("${elasticsearch.port}")
    private int esPort;

    @Value("${elasticsearch.clustername}")
    private String esClusterName;

//    @Bean
//    public Client client() throws Exception {
//        Settings esSettings = Settings.builder()
//                .put("client.transport.sniff", true)
//                .put("cluster.name", esClusterName)
//                .build();
//
//        TransportClient client = new PreBuiltTransportClient(esSettings);
//        client.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName(esHost), esPort));
//        return client;
//    }
//
//    @Bean
//    public ElasticsearchOperations elasticsearchTemplate() throws Exception {
//        return new ElasticsearchTemplate(client());
//    }

    @Override
    public RestHighLevelClient elasticsearchClient() {
        final ClientConfiguration clientConfiguration =
                ClientConfiguration
                        .builder()
                        .connectedTo(esHost + ":" + esPort)
                        .build();

        return RestClients.create(clientConfiguration).rest();
    }
}
