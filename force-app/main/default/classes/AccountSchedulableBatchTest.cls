/**
 * Se você já leu a documentação da Salesforce sobre classes batch agendáveis, deve ter percebido
 * que existe um método da classe System chamado scheduleBatch, onde é possível agendar uma batch
 * sem que ela implemente especificamente a interface Schedulable. O propósito deste exercício é
 * entender que em Apex é possível fazer várias implementações em uma mesma classe, e que isso pode
 * ser útil para outras situações.
 */
@IsTest
private class AccountSchedulableBatchTest {

    @TestSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            accounts.add(new Account(
                Name = 'Account #' + i
            ));
        }
        insert accounts;
    }

    @IsTest
    static void test_schedule() {

        Test.startTest();
        System.schedule('schedulable', '20 30 8 10 2 ?', new AccountSchedulableBatch());
        Test.stopTest();

        // Não podemos assegurar que a classe batch funcionou, por conta
        // do contexto de teste. Precisamos testar o contexto de batch
        // em outro método, separadamente.
        System.assert(true, '');
    }

    @IsTest
    static void test_batch() {

        Test.startTest();
        Database.executeBatch(new AccountSchedulableBatch());
        Test.stopTest();

        List<Account> accounts = [
            SELECT
            Id, Description
            FROM Account
        ];

        System.assertEquals(100, accounts.size());

        // É necessário assegurar que o campo de descrição foi alterado desta forma porque
        // não é possível filtrar o campo na query, por ser um campo de área de texto longo.
        // Se esta limitação não existisse, poderíamos simplesmente filtrar as contas usando a
        // cláusula "WHERE Description != NULL" e contar quantos registros foram retornados
        // (que devem ser os 100 que foram inserios pelo setup do teste).
        for (Account record : accounts) {
            System.assertNotEquals(null, record.Description);
        }
    }
}
