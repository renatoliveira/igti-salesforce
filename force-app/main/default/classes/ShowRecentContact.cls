public with sharing class ShowRecentContact {

    /**
     * Busca o contato mais recente com base em uma conta
     * que foi informada.
     *
     * Params:
     * - recordId: Id da conta
     */
    @AuraEnabled
    public static Contact getLastContact (Id recordId) {
        SObjectType sot = Id.valueOf(recordId).getSobjectType();

        // Valida se o ID é de uma conta mesmo
        if (sot != Schema.Account.getSObjectType()) {
            throw new AuraHandledException('Objeto com ID não suportado: ' + recordId);
        }

        List<Contact> recents = [
            SELECT Id, LastModifiedDate
            FROM Contact
            WHERE AccountId = :recordId
            ORDER BY LastModifiedDate DESC
        ];

        return recents.isEmpty() ? null : recents[0];
    }
}
