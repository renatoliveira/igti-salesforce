@IsTest
private class ContactTriggerHandlerTest {

    @IsTest
    static void test_cep() {
        Account a = new Account(
            Name = 'Company, co.'
        );
        insert a;

        Contact record = new Contact(
            LastName = 'Pattingson'
        );
        insert record;

        Test.setMock(HttpCalloutMock.class, new ViaCEPMock());
        Test.startTest();
        record.MailingPostalCode = '00000000';
        update record;
        Test.stopTest();

        record = [
            SELECT Id, MailingStreet
            FROM Contact
            WHERE Id = :record.Id
        ];

        System.assertNotEquals(null, record.MailingStreet, 'Deveria ter preenchido com a rua.');
    }
}
