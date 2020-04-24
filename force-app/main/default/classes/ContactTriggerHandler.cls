public class ContactTriggerHandler {

    public void run() {
        if (Trigger.isUpdate && Trigger.isAfter) {
            Contact record = (Contact) Trigger.new[0];

            System.debug(record);

            if (String.isNotBlank(record.MailingPostalCode) && String.isBlank(record.MailingStreet)) {
                System.enqueueJob(new ViaCEPQueueable(record));
            }
        }
    }
}
