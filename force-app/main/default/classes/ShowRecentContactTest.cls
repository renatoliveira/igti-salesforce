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

        c = [
            SELECT Id, LastModifiedDate
            FROM Contact
            WHERE Id = :c.Id
        ];

        Test.startTest();
        Datetime d = ShowRecentContact.getLastContact(a.Id);
        Test.stopTest();

        System.assertEquals(d, c.LastModifiedDate, 'As datas de última modificação devem ser iguais.');
    }
}
