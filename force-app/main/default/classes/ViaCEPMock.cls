public class ViaCEPMock implements HttpCalloutMock {

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();

        ViaCEPResponse payload = new ViaCEPResponse();
        payload.logradouro = 'Rua Tal';
        payload.cep = '00000000';

        res.setBody(JSON.serialize(payload));

        return res;
    }
}
