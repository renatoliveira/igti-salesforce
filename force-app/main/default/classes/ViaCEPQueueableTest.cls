@IsTest
private class ViaCEPQueueableTest {

    @IsTest
    static void test() {
        Account a = new Account(
            Name = 'Company, co.'
        );
        insert a;

        Contact record = new Contact(
            LastName = 'Pattingson',
            MailingPostalCode = '30000000'
        );
        insert record;

        Test.setMock(HttpCalloutMock.class, new ViaCEPMock());
        Test.startTest();
        Id jobId = System.enqueueJob(new ViaCEPQueueable(record));
        Test.stopTest();

        System.assertNotEquals(null, jobId);

        record = [
            SELECT Id, MailingStreet
            FROM Contact
            WHERE Id = :record.Id
        ];

        System.assertNotEquals(null, record.MailingStreet, 'Deveria ter preenchido com a rua.');
    }
}
