# NSURLProtocol




## API

#pragma mark - API



```
/// 该方法的目的是为协议实现者提供一个接口，用于定制与NSMutableURLRequest对象相关的协议特定信息。
/// @param value 要存储的属性
/// @param key 用于属性存储的字符串
/// @param request 用于存储属性的请求
+ (void)setProperty:(id)value forKey:(NSString *)key inRequest:(NSMutableURLRequest *)request;

/// 该方法的目的是为协议实现者提供一个接口，以访问与NSURLRequest对象相关的协议特定信息。
/// @param key 键值
/// @param request 用于存储属性的请求
+ (nullable id)propertyForKey:(NSString *)key inRequest:(NSURLRequest *)request;



/*
创建NSURLProtocol实例，NSURLProtocol注册之后
所有的注册 NSURLProtocol 的 NSURLSession、NSURLConnection都会通过这个方法检查是否持有该Http请求
我们可以在这个方法的实现里面进行请求的过滤，筛选出需要进行处理的请求。
*/
/*!
 @method canInitWithRequest:
 @abstract 此方法确定该协议是否能够处理给定的请求
 @discussion 具体的子类应该检查给定的请求，并确定实现是否可以对该请求执行加载。这是一个抽象的方法。子类必须提供一个实现。
 @param request 检查的请求。
 @result 如果协议能够处理给定的请求，则为YES;如果不能，则为NO。
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([NSURLProtocol propertyForKey:@"key" inRequest:request]) {
        // your coding...
        return YES;
    }
    return NO;
}




/*
虽然它与 + canInitWithRequest: 方法传入的 request 对象都是一个
但是最好不要在 + canInitWithRequest: 中操作对象，可能会有语义上的问题
所以，我们需要覆写 + canonicalRequestForRequest 这是一个抽象方法，子类必须实现 
一般不修改，需要修改也可以在这个方法里修改
*/
/*!
 @method canonicalRequestForRequest:
 @abstract 此方法返回给定请求的规范版本。
 @discussion 由每个具体的协议实现来定义“规范”的含义。但是，协议应该保证相同的输入请求总是产生相同的规范形式。在实现这个方法时需要特别考虑，因为请求的规范形式是用来在URL缓存中查找对象的，这是一个在NSURLRequest对象之间执行相等性检查的过程。
 这是一个抽象的方法;子类必须提供一个实现。
 @param request 使成为规范的请求。
 @result 给定请求的规范形式。
 */
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request;



/*
如果有两个URL请求，并且他们是相等的，那么这里可以使用相同的缓存空间通常只需要调用父类的实现
*/
/*!
 @method requestIsCacheEquivalent:toRequest:
 @abstract 比较关于缓存的两个等价请求。
 @discussion 当且仅当请求由相同的协议处理并且该协议在执行特定于实现的检查后声明它们是等价的，那么对于缓存目的，请求被认为是等价的。
 @result 如果两个请求是缓存等效的，则为YES，否则为NO。
 */
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b;

```
