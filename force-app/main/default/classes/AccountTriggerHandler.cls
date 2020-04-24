public class AccountTriggerHandler {
    public void run() {
        if (Trigger.new.size() == 1 && Trigger.isUpdate && Trigger.isAfter) {
            Account record = (Account) Trigger.new[0];

            if (String.isNotBlank(record.BillingPostalCode) && String.isBlank(record.BillingStreet)) {
                getPostalCode(record.Id);
            }
        }
    }

    @future(callout=true)
    public static void getPostalCode(Id recordId) {

        System.debug(recordId);

        Account record = [
            SELECT Id, BillingPostalCode
            FROM Account
            WHERE Id = :recordId
        ];

        HttpRequest req = new HttpRequest();
        req.setEndpoint(String.format('callout:Via_CEP/ws/{0}/json/', new List<String>{ record.BillingPostalCode }));
        req.setMethod('GET');

        HttpResponse res = new Http().send(req);

        ViaCEPResponse data = (ViaCEPResponse) JSON.deserialize(res.getBody(), ViaCEPResponse.class);

        record.BillingPostalCode = data.cep;
        record.BillingCity = data.localidade;
        record.BillingState = data.uf;
        record.BillingStreet = (data.logradouro != null ? data.logradouro : '') + (data.complemento != null ? data.complemento : '');

        update record;
    }
}
