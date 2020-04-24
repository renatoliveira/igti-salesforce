import { api, track, LightningElement } from 'lwc';
import getLastContact from '@salesforce/apex/ShowRecentContact.getLastContact'

export default class MostrarContatoMaisRecente extends LightningElement {

    // atributo para pegar o id do registro no qual o componente se faz presente
    // na página quando o usuário o acessa
    @api recordId

    // indica se o componente está carregando ou não
    @track loading = true

    // variável para armazenar o resultado da busca
    @track contact

    // atributo dinâmico para buscar o atributo de data e hora do contato
    // retornado (não é necessário usar isso, porque o valor da data e hora
    // poderia ser retornado diretamente pelo método no Apex, mas fica de
    // exemplo)
    get lastTime() {
        console.log("this.contact.LastModifiedDate: ")
        console.log(this.contact.LastModifiedDate)
        return new Date(this.contact.LastModifiedDate)
    }

    get hasContact() {
        // verificação se o contato é um valor verdadeiro ("truthy"), se sim
        // então indicamos que há um registro de contato retornado
        if (this.contact) {
            return true
        }
        // caso contrário mostra que não, porque aí mostra a mensagem de
        // que não há contato disponível
        return false
    }

    // O connectedCallback é o método que é chamado quando o componente é
    // instanciado no DOM da página.
    connectedCallback() {
        // quando executado, chama o método Apex no servidor passando como
        // parâmetro o ID do registro de acordo com a variável do componente
        // (que é preenchida automaticamente pelo Lightning Experience em
        // tempo de execução)
        getLastContact({ recordId: this.recordId }).then(res => {
            // o resultado é atribuído à variável do contato
            this.contact = res
        }).finally(() => {
            // e por fim indicamos que o componente não está mais carregando
            this.loading = false
        })
    }
}