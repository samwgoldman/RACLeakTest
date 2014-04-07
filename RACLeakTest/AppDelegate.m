#import "AppDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation AppDelegate

- (void)runLeak:(NSButton *)button
{
    size_t n = 1000;

    __strong id* subjects = (__strong id*)calloc(n, sizeof(id));

    dispatch_apply(n, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        RACSubject *subject = [RACSubject subject];

        subjects[i] = subject;

        NSNumber *value = [NSNumber numberWithUnsignedLong:i];
        [[subject startWith:value] subscribeCompleted:^{
        }];
    });

    dispatch_apply(n, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        RACSubject *subject = subjects[i];
        [subject sendCompleted];
        subjects[i] = nil;
    });

    free(subjects);
    subjects = nil;
}

- (void)runNoLeak:(NSButton *)button
{
    size_t n = 1000;

    __strong id* subjects = (__strong id*)calloc(n, sizeof(id));

    dispatch_apply(n, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        NSNumber *value = [NSNumber numberWithUnsignedLong:i];
        RACSubject *subject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:value];

        subjects[i] = subject;

        [subject subscribeCompleted:^{
        }];
    });

    dispatch_apply(n, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        RACSubject *subject = subjects[i];
        [subject sendCompleted];
        subjects[i] = nil;
    });

    free(subjects);
    subjects = nil;
}

@end
