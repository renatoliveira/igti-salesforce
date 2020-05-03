/**
 * Classe que implementa duas interfaces simultaneamente.
 * Quando seu agendamento for executado, a classe agendará a si própria.
 * A plataforma, executará então os métodos de contexto de processamento em lotes (batches).
 */
public without sharing class AccountSchedulableBatch implements Schedulable, Database.Batchable<SObject> {

    /**
     * Método obrigatório da interface Schedulable.
     * Executado quando chega a hora agendada.
     */
    public void execute(SchedulableContext ctx) {
        // executa o trabalho em lotes
        Database.executeBatch(this);
    }

    /**
     * Método obrigatório da interface Batchable.
     * Executado quando o trablaho em lotes é iniciado.
     */
    public Database.QueryLocator start(Database.BatchableContext ctx) {
        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }

    /**
     * Método obrigatório da interface Batchable.
     * Executado durante o trabalho em lotes múltiplas vezes (a depender do tamanho do lote).
     */
    public void execute(Database.BatchableContext ctx, List<SObject> scope) {
        Datetime now = Datetime.now();

        for (Account record : (List<Account>) scope) {
            record.Description = String.format('Atualizado em {0}', new List<String>{ now.format() });
        }

        Database.update(scope, false);
    }

    /**
     * Método obrigatório da interface Batchable.
     * Executado quando o trablaho em lotes é finalizado.
     */
    public void finish(Database.BatchableContext ctx) {
        System.debug(LoggingLevel.INFO, 'Finished!');
    }
}
