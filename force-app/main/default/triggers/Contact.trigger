trigger Contact on Contact (after update) {
    new ContactTriggerHandler().run();
}