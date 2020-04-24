# Projeto Salesforce

Repositório de projeto Salesforce de exemplo para o Bootcamp Salesforce pelo IGTI com SysMap.

## Exemplo de método assíncrono anotado com @future

Na linha 7 da classe `AccountTriggerHandler` há uma chamada para o método assíncrono `getPostalCode` que está definido na linha 13 da mesma classe. Este método é anotado com `@future(callout=true)` e invoca um webservice público para consulta de informações de CEP.

## Exemplo de classe que implementa a interface Queueable

Na linha 10 da classe `ContactTriggerHandler` há uma invocação para enfileirar um serviço definido na classe `ViaCEPQueueable`. A classe recebe no construtor uma instância de um registro e atualiza este registro com as informações de CEP devolvidas pelo mesmo webservice do exemplo assíncrono com a anotação `@future`.
