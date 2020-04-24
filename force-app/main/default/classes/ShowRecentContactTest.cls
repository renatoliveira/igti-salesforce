@IsTest
private class ShowRecentContactTest {

    @IsTest
    static void test_contacts() {
        Account a = new Account(
            Name = 'Company, Inc'
        );
        insert a;

        Contact c = new Contact(
            FirstName = 'Bob',
            LastName = 'Johnson',
            AccountId = a.Id
        );
        insert c;

        Test.startTest();
        Contact record = ShowRecentContact.getLastContact(a.Id);
        Test.stopTest();

        System.assertEquals(record.Id, c.Id, 'Deveria ter buscado o registro de contato.');
    }
}
