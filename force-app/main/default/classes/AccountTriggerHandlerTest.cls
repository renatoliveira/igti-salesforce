@IsTest
private class AccountTriggerHandlerTest {

    @IsTest
    static void test_cep() {
        Account record = new Account(
            Name = 'Company, co.'
        );
        insert record;

        Test.setMock(HttpCalloutMock.class, new ViaCEPMock());
        Test.startTest();
        record.BillingPostalCode = '00000000';
        update record;
        Test.stopTest();

        record = [
            SELECT Id, BillingStreet
            FROM Account
            WHERE Id = :record.Id
        ];

        System.assertNotEquals(null, record.BillingStreet, 'Deveria ter preenchido com a rua.');
    }
}
