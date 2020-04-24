public without sharing class ViaCEPQueueable implements Queueable, Database.AllowsCallouts {

    public Contact record;

    public ViaCEPQueueable(Contact record) {
        this.record = record;
    }

    public void execute(QueueableContext ctx) {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(String.format(
            'callout:Via_CEP/ws/{0}/json/',
            new List<String>{ this.record.MailingPostalCode }
        ));

        HttpResponse res = new Http().send(req);

        ViaCEPResponse data = (ViaCEPResponse) JSON.deserialize(
            res.getBody(),
            ViaCEPResponse.class
        );

        this.record = this.record.clone(true, false, true, true);

        this.record.MailingPostalCode = data.cep;
        this.record.MailingCity = data.localidade;
        this.record.MailingState = data.uf;
        this.record.MailingStreet =
            (data.logradouro != null ? data.logradouro : '') +
            (data.complemento != null ? data.complemento : '');

        // necessário clonar o objeto para evitar a exceção
        // |FATAL_ERROR|System.FinalException: Record is read-only
        update this.record;
    }
}
