trigger Account on Account (after update) {
    new AccountTriggerHandler().run();
}