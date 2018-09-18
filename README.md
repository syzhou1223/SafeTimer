# SafeTimer
打破NSTimer的循环引用


使用方法： 在初始Timer的时候，把target指向ForwardingObject的对象，如下： [NSTimer timerWithTimeInterval:1 target:[ForwardingObject forwardWithTarget:self] selector:@selector(refreshTime) userInfo:nil repeats:YES]

这样Timer内部就不会强引用住Self，从而可以正常释放。

Tips:在dealloc方法里面记得调用Timer的invalidate方法。
